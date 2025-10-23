using System;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;
using System.IO;
using System.Windows.Input;
using System.Xml;
using System.Threading;
using System.Text;
using System.Net;
using System.Web;
using System.Diagnostics;
using System.ComponentModel;
using AutoUpdaterDotNET;
using System.Security.Cryptography;
using System.Reflection;
using System.Web.Script.Serialization;
using System.Runtime.Serialization.Json;
using System.Collections.Specialized;

namespace client
{
    /// <summary>
    /// Логика взаимодействия для Window1.xaml
    /// </summary>
    public partial class Main : Window, INotifyPropertyChanged
    {
        static byte[] additionalEntropy = { 2, 1, 8, 4, 2 };
        private clientSettings _settings = new clientSettings();
        public static bool debug = false;
        public static string setting_file = "settings.dat";
        public static string tso_folder = "tso_portable";
        public static string lang = string.Empty;
        public static int http_timeout = 300000;
        public static string totpkey = string.Empty;
        public static bool isLoaded = false;
        public static string[] upstream_data = null;
        public static CookieCollection _cookies;
        public static string _region = string.Empty;
        public static VersionInfo winver;
        public static Arguments cmd;
        private string _langLogin;
        private string _langPass;
        private string _langRun;
        private string _langExit;
        private string _langRemember;
        private string _dropboxToken;
        private static string extraVersion = "#TESTTAG#";
        public const string appversion = "1.5.8.2";
        public static bool newAuth = false;
        public string version
        {
            get { return appversion; }
        }
        public string langLogin
        {
            get { return _langLogin; }
            set { _langLogin = value; OnPropertyChanged("langLogin"); }
        }
        public string langPass
        {
            get { return _langPass; }
            set { _langPass = value; OnPropertyChanged("langPass"); }
        }
        public string langRun
        {
            get { return _langRun; }
            set { _langRun = value; OnPropertyChanged("langRun"); }
        }
        public string langExit
        {
            get { return _langExit; }
            set { _langExit = value; OnPropertyChanged("langExit"); }
        }
        public string langRemember
        {
            get { return _langRemember; }
            set { _langRemember = value; OnPropertyChanged("langRemember"); }
        }
        public event PropertyChangedEventHandler PropertyChanged;
        string[] args_help = new string[] {
            "--config - set config file",
            "--totpkey - 2fa auth key",
            "--clientconfig - set client config file",
            "--login - set login",
            "--fastlogin - use saved token and client boot arg. Read wiki carefully before use it!",
            "--token - extra token for fastlogin",
            "--password - set password",
            "--autologin - allows to start client with login/password from setting.dat",
            "--lang [de|us|en|fr|ru|pl|es2|es|nl|cz|pt|it|el|ro] - changes the game interface language.",
            "--window [fullscreen|maximized|minimized] - initital game window size",
            "--skip - allows to skip update checking of client.swf",
            "--tsofolder - set different tso folder name",
            "--x64 - use x64 adobe air runtime",
            "--debug - creates a debug.txt file with an error report in case of failure"
        };

        protected void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        public Main()
        {
            cmd = new Arguments(Environment.GetCommandLineArgs());
            AppDomain.CurrentDomain.UnhandledException += new UnhandledExceptionEventHandler(CurrentDomain_UnhandledException);
            System.Net.ServicePointManager.Expect100Continue = false;
            InitializeComponent();
            this.DataContext = this;
            Loaded += Main_Loaded;
        }

        private void Main_Loaded(object sender, RoutedEventArgs e)
        {
            WinVersion.GetVersion(out winver);
            if (cmd["config"] != null)
                setting_file = cmd["config"].Trim();
            ReadSettings();
            if (cmd["debug"] != null)
                debug = true;
            if (cmd["cipauth"] != null)
                newAuth = true;
            if (cmd["tsofolder"] != null)
                tso_folder = cmd["tsofolder"].Trim();
            if (cmd["totpkey"] != null)
                totpkey = cmd["totpkey"].Trim();
            if (cmd["lang"] != null && Servers._langs.ContainsKey(cmd["lang"]))
                lang = Servers._langs[cmd["lang"]];
            if (cmd["login"] != null && cmd["password"] != null)
            {
                login.Text = cmd["login"];
                password.Password = cmd["password"];
                pwd.Visibility = System.Windows.Visibility.Collapsed;
            }
            isLoaded = true;
            new Thread(checkVersion) { IsBackground = true }.Start();
        }

        public string ClientDirectory
        {
            get
            {
                return Path.IsPathRooted(tso_folder) ? tso_folder : Path.Combine(_settings.tsoFolderNearLauncher ? AppDomain.CurrentDomain.BaseDirectory : Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), tso_folder);
            }
        }
        private const string _chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        private static Random _rng = new Random();
        public static string RandomString
        {
            get
            {

                char[] buffer = new char[5];
                for (int i = 0; i < 5; i++)
                {
                    buffer[i] = _chars[_rng.Next(_chars.Length)];
                }
                return new string(buffer);
            }
        }

        public void checkVersion()
        {
            AutoUpdater.InstalledVersion = new Version(appversion);
            AutoUpdater.ShowSkipButton = true;
            AutoUpdater.OpenDownloadPage = true;
            AutoUpdater.Start("https://raw.githubusercontent.com/fedorovvl/tso_client/master/changelog.xml");
            Dispatcher.BeginInvoke(new ThreadStart(delegate { butt.IsEnabled = false; error.Text = Servers.getTrans("checking"); }));
            if (!Directory.Exists(ClientDirectory))
                Directory.CreateDirectory(ClientDirectory);
            
            using (var unzip = new Unzip(new MemoryStream(Properties.Resources.content)))
            {
                // ensure that scripts dir always fresh
                if(Directory.Exists(Path.Combine(ClientDirectory, "scripts")))
                {
                    DirectoryInfo dir = new DirectoryInfo(Path.Combine(ClientDirectory, "scripts"));
                    foreach (FileInfo fi in dir.GetFiles())
                    {
                        if (!debug)
                            fi.Delete();
                    }
                }
                if (!debug)
                    unzip.ExtractToDirectory(ClientDirectory);
            }
            if (!debug)
            {
                if (System.Environment.Is64BitOperatingSystem && (cmd["x64"] != null || _settings.x64))
                {
                    using (var unzip = new Unzip(new MemoryStream(Properties.Resources.runtime_x64)))
                    {
                        unzip.ExtractToDirectory(ClientDirectory);
                    }
                } else
                {
                    using (var unzip = new Unzip(new MemoryStream(Properties.Resources.runtime_x86)))
                    {
                        unzip.ExtractToDirectory(ClientDirectory);
                    }
                }
            }
            try
            {
                foreach (string tmpDir in Directory.GetDirectories(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "TSO-*"))
                {
                    Directory.Delete(tmpDir, true);
                }
            }
            catch { }
            if (!string.IsNullOrEmpty(_settings.dropboxkey) && !string.IsNullOrEmpty(_settings.dropboxrefresh))
            {
                dropboxGetToken();
            }
            if (!string.IsNullOrEmpty(_settings.nickName) && _dropboxToken != null && _settings.accountId != 0)
            {
                Dispatcher.BeginInvoke(new ThreadStart(delegate { error.Text = "Download fastArgs"; }));
                try
                {
                    _settings.tsoArg = new Crypt().Decrypt(dropboxDownloadFile(_settings.accountId + ".dat"), true);
                }
                catch { }
            }
            if (cmd["skip"] != null && File.Exists(Path.Combine(ClientDirectory, "client.swf")))
            {
                Dispatcher.BeginInvoke(new ThreadStart(delegate { error.Text = Servers.getTrans("letsplay"); butt.IsEnabled = true; }));
                if (cmd["autologin"] != null)
                {
                    Dispatcher.BeginInvoke(new ThreadStart(delegate { butt_Click_1(null, null); }));
                }
                if (cmd["fastlogin"] != null && !string.IsNullOrEmpty(_settings.tsoArg))
                {
                    if (cmd["token"] != null)
                    {
                        var tsoUrl = HttpUtility.ParseQueryString(_settings.tsoArg);
                        tsoUrl.Set("dsoAuthToken", cmd["token"].Trim());
                        _settings.tsoArg = HttpUtility.UrlDecode(tsoUrl.ToString());
                    }
                    Dispatcher.BeginInvoke(new ThreadStart(delegate
                    {
                        run_tso();
                    }));
                }
                return;
            }
            try
            {
                PostSubmitter post;
                var json = new JavaScriptSerializer();
                Dispatcher.BeginInvoke(new ThreadStart(delegate { error.Text = Servers.getTrans("checking"); }));
                string chksum = string.Empty;
                bool needDownload = false;
                if (File.Exists(System.IO.Path.Combine(ClientDirectory, "client.swf"))) {
                    byte[] chksumdata = File.ReadAllBytes(System.IO.Path.Combine(ClientDirectory, "client.swf"));
                    byte[] chksumheader = UTF8Encoding.UTF8.GetBytes("blob " + chksumdata.Length + "\0");
                    using (MemoryStream ms = new MemoryStream())
                    {
                        ms.Write(chksumheader, 0, chksumheader.Length);
                        ms.Write(chksumdata, 0, chksumdata.Length);
                        chksum = BitConverter.ToString(SHA1.Create().ComputeHash(ms.ToArray())).ToLower().Replace("-", "");
                    }
                } else
                    needDownload = true;
                if (upstream_data == null)
                {
                    post = new PostSubmitter
                    {
                        Url = "https://raw.githubusercontent.com/fedorovvl/tso_client/master/upstream.json",
                        Type = PostSubmitter.PostTypeEnum.Get
                    };
                    string upstream_json = post.Post(ref _cookies).Trim();
                    try
                    {
                        upstream_data = json.Deserialize<string[]>(upstream_json);
                    }
                    catch { }
                }
                bool upstream_swf = upstream_data != null && Array.IndexOf(upstream_data, _region) >= 0;
                Dispatcher.BeginInvoke(new ThreadStart(delegate { swf_upsteam.IsChecked = upstream_swf; }));
                string swf_filename = upstream_swf ? "client_upstream.swf" : _region == "ts" ? "client_testing.swf" : "client.swf";
                if (upstream_swf || _region == "ts")
                    newAuth = true;
                if (!string.IsNullOrEmpty(chksum))
                {
                    post = new PostSubmitter
                    {
                        Url = "https://api.github.com/repos/fedorovvl/tso_client/contents/" + swf_filename,
                        Type = PostSubmitter.PostTypeEnum.Get
                    };
                    string rchksum = post.Post(ref _cookies).Trim();
                    try
                    {
                        gitFile data = json.Deserialize<gitFile>(rchksum);
                        if (chksum != data.sha)
                            needDownload = true;
                    } catch { needDownload = true; }
                }
                if (needDownload)
                {
                    Dispatcher.BeginInvoke(new ThreadStart(delegate { error.Text = Servers.getTrans("downloading"); }));
                    byte[] client = DownloadFile("https://raw.githubusercontent.com/fedorovvl/tso_client/master/" + swf_filename);
                    File.WriteAllBytes(System.IO.Path.Combine(ClientDirectory, "client.swf"), client);
                }
                Dispatcher.BeginInvoke(new ThreadStart(delegate { error.Text = Servers.getTrans("letsplay"); butt.IsEnabled = true; }));
                if (cmd["autologin"] != null)
                {
                    Dispatcher.BeginInvoke(new ThreadStart(delegate { butt_Click_1(null, null); }));
                }
                if (cmd["fastlogin"] != null && !string.IsNullOrEmpty(_settings.tsoArg))
                {
                    if(cmd["token"] != null)
                    {
                        var tsoUrl = HttpUtility.ParseQueryString(_settings.tsoArg);
                        tsoUrl.Set("dsoAuthToken", cmd["token"].Trim());
                        _settings.tsoArg = HttpUtility.UrlDecode(tsoUrl.ToString());
                    }
                    Dispatcher.BeginInvoke(new ThreadStart(delegate
                    {
                        run_tso();
                    }));
                }
                return;
            } catch (Exception e)
            {
                MessageBox.Show(e.Message + e.StackTrace);
            }
            return;
        }

        public byte[] DownloadFile(string remoteFilename)
        {
            int bytesProcessed = 0;
            Stream remoteStream = null;
            WebResponse response = null;
            List<byte> resultArray = new List<byte>();
            try
            {
                WebRequest request = WebRequest.Create(remoteFilename);
                request.Method = "GET";
                if (request != null)
                {
                    response = request.GetResponse();
                    if (response != null)
                    {
                        remoteStream = response.GetResponseStream();
                        byte[] buffer = new byte[4096];
                        long bytesTotal = response.ContentLength;
                        int bytesRead;
                        do
                        {
                            bytesRead = remoteStream.Read(buffer, 0, buffer.Length);
                            byte[] Buf = new byte[bytesRead];
                            Buffer.BlockCopy(buffer, 0, Buf, 0, bytesRead);
                            resultArray.AddRange(Buf);
                            bytesProcessed += bytesRead;
                            Dispatcher.BeginInvoke(new ThreadStart(delegate { error.Text = string.Format(Servers.getTrans("downloading") + " {0}%", (100 * bytesProcessed / bytesTotal).ToString()); }));
                        } while (bytesRead > 0);
                    }
                }
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
            finally
            {
                if (response != null) response.Close();
                if (remoteStream != null) remoteStream.Close();
            }

            return resultArray.ToArray();
        }

        public void ReadSettings()
        {
            string settings = null;
            if (File.Exists(setting_file))
            {
                try
                {
                    settings = Encoding.UTF8.GetString(ProtectedData.Unprotect(File.ReadAllBytes(setting_file), additionalEntropy, DataProtectionScope.LocalMachine));
                    _settings = new JavaScriptSerializer().Deserialize<clientSettings>(settings);
                }
                catch
                {
                    try
                    {
                        //convert
                        string[] settings_convert = settings.Split(new[] { '|' }, StringSplitOptions.None);
                        _settings = new clientSettings()
                        {
                            username = settings_convert[0].Trim(),
                            password = settings_convert[1].Trim(),
                            nickName = settings_convert[3].Trim(),
                            region = int.Parse(settings_convert[5].Trim())
                        };
                        if(!string.IsNullOrEmpty(_settings.nickName) && _settings.nickName != "0")
                        {
                            _settings.tsoArg = UTF8Encoding.UTF8.GetString(Convert.FromBase64String(settings_convert[4].Trim()));
                        }
                        Dispatcher.BeginInvoke(new ThreadStart(delegate { error.Text = "Settings converted"; }));
                    }
                    catch
                    {
                        File.Move(setting_file, string.Format("bad_{0}", setting_file));
                    }
                }
            }
            if (!string.IsNullOrEmpty(_settings.username))
            {
                login.Text = _settings.username;
                password.Password = _settings.password;
                pwd.Visibility = System.Windows.Visibility.Collapsed;
            }
            region_list.SelectedIndex = _settings.region;
            _region = (region_list.SelectedItem as ComboBoxItem).Tag.ToString();
            tso_folder = _settings.tsofolder;
            totpkey = _settings.totpkey;
            SaveLogin.IsChecked = _settings.remember;
        }

        private bool dropboxCheckFile(string filename)
        {
            if (string.IsNullOrEmpty(_dropboxToken)) { return false; }
            CookieCollection _cookies = new CookieCollection();
            PostSubmitter post = new PostSubmitter
            {
                Url = Servers.dropboxAPI + "/2/files/get_metadata",
                Type = PostSubmitter.PostTypeEnum.Post,
                useBC = true
            };
            post.HeaderItems.Add("Authorization", "Bearer " + _dropboxToken);
            post.ContentType = "application/json";
            post.PostItems.Add(string.Format(@"{{""path"":""/{0}""}}", filename), string.Empty);
            string result = post.Post(ref _cookies);
            return result == " CAPCHA " ? false : true;
        }

        private string dropboxDownloadFile(string filename)
        {
            if (!dropboxCheckFile(filename)) { return string.Empty; }
            CookieCollection _cookies = new CookieCollection();
            PostSubmitter post = new PostSubmitter
            {
                Url = Servers.dropboxContentAPI + "/2/files/download",
                Type = PostSubmitter.PostTypeEnum.Post,
                useBC = true
            };
            post.HeaderItems.Add("Authorization", "Bearer " + _dropboxToken);
            post.ContentType = "application/octet-stream";
            post.HeaderItems.Add("Dropbox-API-Arg", string.Format(@"{{""path"":""/{0}""}}", filename));
            string result = post.Post(ref _cookies);
            return result == " CAPCHA " ? string.Empty : result;
        }
        private bool dropboxUploadFile(string filename, string data)
        {
            if (string.IsNullOrEmpty(_dropboxToken)) { return false; }
            CookieCollection _cookies = new CookieCollection();
            PostSubmitter post = new PostSubmitter
            {
                Url = Servers.dropboxContentAPI + "/2/files/upload",
                Type = PostSubmitter.PostTypeEnum.Post,
                useBC = true
            };
            post.HeaderItems.Add("Authorization", "Bearer " + _dropboxToken);
            post.ContentType = "application/octet-stream";
            post.HeaderItems.Add("Dropbox-API-Arg", string.Format(@"{{""path"":""/{0}"", ""mode"": {{"".tag"": ""overwrite""}}}}", filename));
            post.PostItems.Add(data, string.Empty);
            string result = post.Post(ref _cookies);
            return result.Contains("error") ? false: true;
        }

        private void dropboxGetToken()
        {
            if (string.IsNullOrEmpty(_settings.dropboxkey) || string.IsNullOrEmpty(_settings.dropboxrefresh)) { return; }
            CookieCollection _cookies = new CookieCollection();
            PostSubmitter post = new PostSubmitter
            {
                Url = Servers.dropboxAPI + "/oauth2/token",
                Type = PostSubmitter.PostTypeEnum.Post
            };
            post.HeaderItems.Add("Authorization", "Basic " + Convert.ToBase64String(UTF8Encoding.UTF8.GetBytes(_settings.dropboxkey)));
            post.PostItems.Add("grant_type", "refresh_token");
            post.PostItems.Add("refresh_token", _settings.dropboxrefresh);
            string result = post.Post(ref _cookies);
            if (!result.Contains("access_token"))
            {
                return;
            }
            dropBoxToken dropTokenData = Deserialize<dropBoxToken>(result);
            _dropboxToken = dropTokenData.access_token;
        }
        public static T Deserialize<T>(string aJSON) where T : new()
        {
            T deserializedObj = new T();
            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(aJSON));
            DataContractJsonSerializer ser = new DataContractJsonSerializer(deserializedObj.GetType());
            deserializedObj = (T)ser.ReadObject(ms);
            ms.Close();
            return deserializedObj;
        }

        void CurrentDomain_UnhandledException(object sender, UnhandledExceptionEventArgs e)
        {
            ExceptionDumper.DumpException(e.ExceptionObject as Exception);
        }

        private void titleBar_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
        }

        private void butt_Click(object sender, RoutedEventArgs e)
        {
            App.Current.Shutdown();
        }

        private void password_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if((sender as TextBox).Text == Servers.getTrans("login") || (sender as TextBox).Text == Servers.getTrans("password"))
            {
                (sender as TextBox).Text = "";
            }

        }

        private void login_LostFocus(object sender, RoutedEventArgs e)
        {
            if ((sender as TextBox).Text == "") (sender as TextBox).Text = Servers.getTrans("login");
        }

        private void butt_Click_1(object sender, RoutedEventArgs e)
        {
            string error_msg = string.Empty;
            if (string.IsNullOrEmpty(login.Text.Trim()) || login.Text.Trim() == Servers.getTrans("login")) error_msg = Servers.getTrans("emptylogin");
            if (string.IsNullOrEmpty(password.Password.Trim()) || password.Password.Trim() == Servers.getTrans("password"))
            {
                if (string.IsNullOrEmpty(error_msg)) error_msg = Servers.getTrans("emptypass");
            }
            if (!string.IsNullOrEmpty(error_msg))
            {
                error.Text = error_msg;
                return;
            }
            error.Text = string.Empty;
            this.Visibility = System.Windows.Visibility.Hidden;
            _settings.remember = (bool)SaveLogin.IsChecked;
            if (_settings.remember)
            {
                _settings.username = login.Text.Trim();
                _settings.password = password.Password.Trim();
            } else
            {
                _settings.username = string.Empty;
                _settings.password = string.Empty;
            }
            File.WriteAllBytes(setting_file, ProtectedData.Protect(Encoding.UTF8.GetBytes(new JavaScriptSerializer().Serialize(_settings)), additionalEntropy, DataProtectionScope.LocalMachine));
            login log = new login() { Owner = ((null == e) ? null : this), _settings = _settings, username = login.Text, password = password.Password, totpKey = totpkey, region = _region, WindowStartupLocation = ((null == e) ? System.Windows.WindowStartupLocation.CenterScreen : System.Windows.WindowStartupLocation.CenterOwner) };
            log.ShowDialog();
            if (log.DialogResult == true)
            {
                if(_settings.tryFast && log.FastLoginSuccess)
                {
                    run_tso();
                    return;
                }
                _cookies = log.Cookies;
                _settings.nickName = log.nickName;
                var tsoUrl = makeTsoUrl(log.Ver);
                _settings.tsoArg = string.Format("tso://{0}&baseUri={1}", tsoUrl.ToString(), Servers._servers[_region].domain);
                _settings.accountId = long.Parse(tsoUrl.Get("dsoAuthUser"));
                try
                {
                    dropboxUploadFile(_settings.accountId + ".dat", new Crypt().Encrypt(_settings.tsoArg, true));
                } catch { }
                File.WriteAllBytes(setting_file, ProtectedData.Protect(Encoding.UTF8.GetBytes(new JavaScriptSerializer().Serialize(_settings)), additionalEntropy, DataProtectionScope.LocalMachine));
                run_tso(false);
            }
            this.Visibility = System.Windows.Visibility.Visible;
        }

        private NameValueCollection makeTsoUrl(string data)
        {
            var tsoUrl = HttpUtility.ParseQueryString(data);
            try
            {
                if (string.IsNullOrEmpty(_settings.lang))
                    tsoUrl.Set("lang", Servers._langs[(region_list.Items[_settings.region] as ComboBoxItem).Tag.ToString()]);
            }
            catch { }
            if (!string.IsNullOrEmpty(_settings.lang))
                tsoUrl.Set("lang", Servers._langs[_settings.lang]);
            if (!string.IsNullOrEmpty(lang))
                tsoUrl.Set("lang", lang);
            if (!string.IsNullOrEmpty(_settings.window))
                tsoUrl.Set("window", _settings.window);
            if (cmd["window"] != null)
                tsoUrl.Set("window", cmd["window"]);
            if (debug)
                tsoUrl.Set("debug", "true");
            if (!string.IsNullOrEmpty(_settings.clientconfig))
                tsoUrl.Set("clientconfig", _settings.clientconfig);
            if (_settings.configNickname)
                tsoUrl.Set("clientconfig", string.Format("{0}.json", _settings.nickName));
            if (cmd["clientconfig"] != null)
                tsoUrl.Set("clientconfig", cmd["clientconfig"].Trim() == "NICKNAME" ? string.Format("{0}.json", _settings.nickName) : cmd["clientconfig"].Trim());
            if (!string.IsNullOrEmpty(_settings.dropboxkey) && !string.IsNullOrEmpty(_settings.dropboxrefresh))
            {
                tsoUrl.Set("dropboxApiKey", Convert.ToBase64String(UTF8Encoding.UTF8.GetBytes(_settings.dropboxkey)));
                tsoUrl.Set("dropboxApiRefresh", Convert.ToBase64String(UTF8Encoding.UTF8.GetBytes(_settings.dropboxrefresh)));
            }
            return tsoUrl;
        }

        private void run_tso(bool fast = true)
        {
            if (fast)
                _settings.tsoArg = string.Format("tso://{0}", HttpUtility.UrlDecode(makeTsoUrl(_settings.tsoArg.Replace("tso://", "")).ToString()));
            try
            {
                XmlDocument Doc = new XmlDocument();
                XmlNamespaceManager ns = new XmlNamespaceManager(Doc.NameTable);
                ns.AddNamespace("adobe", "http://ns.adobe.com/air/application/15.0");
                Doc.Load(string.Format("{0}\\META-INF\\AIR\\application.xml", ClientDirectory));
                Doc.SelectSingleNode("/adobe:application/adobe:id", ns).InnerText = "TSO-" + RandomString;
                Doc.SelectSingleNode("/adobe:application/adobe:name", ns).InnerText = "The Settlers Online - " + _settings.nickName;
                Doc.Save(string.Format("{0}\\META-INF\\AIR\\application.xml", ClientDirectory));
                extraVersion = extraVersion != string.Format("#{0}#", "TESTTAG") ? "-" + extraVersion : "";
                if (debug)
                    File.AppendAllText("debug.txt", "start tso with " + _settings.tsoArg + "\r\n");
                System.Diagnostics.Process.Start(string.Format("{0}\\client.exe", ClientDirectory), string.Format("{0}&version={1}{2}", _settings.tsoArg, appversion, extraVersion));
            } catch
            {
                MessageBox.Show(string.Format("{0}\\META-INF\\AIR\\application.xml", ClientDirectory) + " corrupted.. Remove it and try again");
            }
            try
            {
                App.Current.Shutdown(1);
            }
            catch { }
        }

        private void pwd_PreviewMouseDown(object sender, MouseButtonEventArgs e)
        {
            (sender as TextBox).Visibility = System.Windows.Visibility.Collapsed;
            password.Focus();

        }

        private void password_LostFocus(object sender, RoutedEventArgs e)
        {
            if ((sender as PasswordBox).Password == "") pwd.Visibility = System.Windows.Visibility.Visible;
        }

        private void password_GotFocus(object sender, RoutedEventArgs e)
        {
            pwd.Visibility = System.Windows.Visibility.Collapsed;
            password.SelectAll();
        }

        private void login_GotFocus(object sender, RoutedEventArgs e)
        {
            if ((sender as TextBox).Text == Servers.getTrans("login") || (sender as TextBox).Text == Servers.getTrans("password"))
            {
                (sender as TextBox).Text = "";
            }
        }

        private void password_KeyUp(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                butt_Click_1(null, null);
            }
        }


        private void Region_list_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            _region = ((sender as ComboBox).SelectedItem as ComboBoxItem).Tag.ToString();
            _settings.region = int.Parse(((sender as ComboBox).SelectedItem as ComboBoxItem).Uid);
            langLogin = Servers.getTrans("login");
            langPass = Servers.getTrans("password");
            langRun = Servers.getTrans("run");
            langExit = Servers.getTrans("exit");
            langRemember = Servers.getTrans("remember");
            if(isLoaded)
                new Thread(checkVersion) { IsBackground = true }.Start();
        }

        private void openTsoFolder_Click(object sender, RoutedEventArgs e)
        {
            Process.Start(new ProcessStartInfo { Arguments = ClientDirectory, FileName = "explorer.exe" });
        }
        private void settingsButton_Click(object sender, RoutedEventArgs e)
        {
            settings settings_window = new settings() { Owner = this, setting = _settings, WindowStartupLocation = System.Windows.WindowStartupLocation.CenterOwner };
            settings_window.ShowDialog();
            if (settings_window.DialogResult == true)
            {
                _settings = settings_window.setting;
                tso_folder = _settings.tsofolder;
                totpkey = _settings.totpkey;
                if (isLoaded)
                    new Thread(checkVersion) { IsBackground = true }.Start();
                File.WriteAllBytes(setting_file, ProtectedData.Protect(Encoding.UTF8.GetBytes(new JavaScriptSerializer().Serialize(_settings)), additionalEntropy, DataProtectionScope.LocalMachine));
                ReadSettings();
            }
        }
        private void resetTsoFolder_Click(object sender, RoutedEventArgs e)
        {
            MessageBoxResult messageBox = MessageBox.Show("Delete tso_portable folder?", "Reset", System.Windows.MessageBoxButton.YesNo, MessageBoxImage.Warning);
            if (messageBox == MessageBoxResult.Yes)
            {
                try
                {
                    Directory.Delete(Path.Combine(ClientDirectory, "scripts"), true);
                    Directory.Delete(Path.Combine(ClientDirectory, "userscripts"), true);
                }
                catch { }
                new Thread(checkVersion) { IsBackground = true }.Start();
            }
        }

        private void Label_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            e.Handled = true;
            MessageBox.Show("Available arguments:\n" + String.Join("\n", args_help), "Info", MessageBoxButton.OK, MessageBoxImage.Information);
        }

    }

    public class gitFile
    {
        public string sha { get; set; }
        public string download_url { get; set; }
    }

    public class clientSettings
    {
        public string totpkey { get; set; } = string.Empty;
        public string dropboxkey { get; set; } = string.Empty;
        public string dropboxrefresh { get; set; } = string.Empty;
        public string clientconfig { get; set; } = string.Empty;
        public string lang { get; set; } = string.Empty;
        public string window { get; set; } = string.Empty;
        public string tsofolder { get; set; } = "tso_portable";
        public bool tsoFolderNearLauncher { get; set; } = false;
        public bool x64 { get; set; } = false;
        public bool tryFast { get; set; } = false;
        public bool configNickname { get; set; } = false;
        public string username { get; set; } = string.Empty;
        public long accountId { get; set; } = 0;
        public string password { get; set; } = string.Empty;
        public string nickName { get; set; } = string.Empty;
        public string tsoArg { get; set; } = string.Empty;
        public bool remember { get; set; } = true;
        public int region { get; set; } = 16;
    }
    public class dropBoxToken
    {
        public string access_token { get; set; } = string.Empty;
        public string token_type { get; set; } = string.Empty;
        public int expires_in { get; set; } = 0;

    }
    public class dropBoxAuth
    {
        public string access_token { get; set; } = string.Empty;
        public string refresh_token { get; set; } = string.Empty;
        public string scope { get; set; } = string.Empty;
        public string uid { get; set; } = string.Empty;
        public string account_id { get; set; } = string.Empty;
        public string token_type { get; set; } = string.Empty;
        public int expires_in { get; set; } = 0;

    }
}
