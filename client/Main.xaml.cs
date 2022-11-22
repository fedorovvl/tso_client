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

namespace client
{
    /// <summary>
    /// Логика взаимодействия для Window1.xaml
    /// </summary>
    public partial class Main : Window, INotifyPropertyChanged
    {
        static byte[] additionalEntropy = { 2, 1, 8, 4, 2 };
        public static bool debug = false;
        public static string version = string.Empty;
        public static string setting_file = "settings.dat";
        public static string lang = string.Empty;
        public static bool auto = false;
        public static bool upstream_swf = false;
        public static CookieCollection _cookies;
        public static string _region = string.Empty;
        public static int http_timeout = 20000;
        public static bool is64 = System.Environment.Is64BitOperatingSystem;
        private int _regionUid;
        public static Arguments cmd;
        private string _langLogin;
        private string _langPass;
        private string _langRun;
        private string _langExit;
        private string _langRemember;
        public string appversion
        {
            get { return "1.5.3.0"; }
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
            "--login - set login",
            "--password - set password",
            "--collect - autoconfirm ubicolleck check",
            "--autologin - allows to start client with login/password from setting.dat",
            "--lang [de|us|en|fr|ru|pl|es2|es|nl|cz|pt|it|el|ro] - changes the game interface language.",
            "--window [fullscreen|maximized] - initital game window size",
            "--skip - allows to skip update checking of client.swf",
            "--http_timeout - set http requests timeout",
            "--debug - creates a debug.txt file with an error report in case of failure"
        };

        protected void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        public Main()
        {
            cmd = new Arguments(Environment.GetCommandLineArgs());
            if (cmd["lang"] != null && Servers._langs.ContainsKey(cmd["lang"]))
                lang = Servers._langs[cmd["lang"]];
            AppDomain.CurrentDomain.UnhandledException += new UnhandledExceptionEventHandler(CurrentDomain_UnhandledException);
            AppDomain.CurrentDomain.AssemblyResolve += new ResolveEventHandler(AssemblyResolve);
            System.Net.ServicePointManager.Expect100Continue = false;
            InitializeComponent();
            this.DataContext = this;
            Loaded += Main_Loaded;
        }
        Assembly AssemblyResolve(object sender, ResolveEventArgs args)
        {
            if (args.Name.Contains("AutoUpdater"))
            {
                Assembly assembly = null;
                using (Stream stream = Assembly.GetExecutingAssembly().GetManifestResourceStream("client.AutoUpdater.NET.dll"))
                {
                    byte[] buffer = new BinaryReader(stream).ReadBytes((int)stream.Length);
                    assembly = Assembly.Load(buffer);
                    return assembly;
                }
            }
            return null;
        }
        private void Main_Loaded(object sender, RoutedEventArgs e)
        {
            if (cmd["config"] != null && File.Exists(cmd["config"]))
                setting_file = cmd["config"];
            ReadSettings();
            if (cmd["debug"] != null)
                debug = true;
            if (cmd["http_timeout"] != null && IsNumeric(cmd["http_timeout"]))
                http_timeout = int.Parse(cmd["http_timeout"]);
            if (cmd["login"] != null && cmd["password"] != null)
            {
                login.Text = cmd["login"];
                password.Password = cmd["password"];
                pwd.Visibility = System.Windows.Visibility.Collapsed;
            }
            new Thread(checkVersion) { IsBackground = true }.Start();
        }

        public static string ClientDirectory
        {
            get
            {
                return System.IO.Path.Combine(System.IO.Path.GetTempPath(), "tso_portable");
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

        public static bool IsNumeric(object Expression)
        {
            double retNum;
            bool isNum = Double.TryParse(Convert.ToString(Expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
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
            try
            {
                foreach (string tmpDir in Directory.GetDirectories(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "TSO-*"))
                {
                    Directory.Delete(tmpDir, true);
                }
            }
            catch { }
            if (cmd["skip"] != null && File.Exists(Path.Combine(ClientDirectory, "client.swf")))
            {
                Dispatcher.BeginInvoke(new ThreadStart(delegate { error.Text = Servers.getTrans("letsplay"); butt.IsEnabled = true; }));
                if (cmd["autologin"] != null)
                {
                    Dispatcher.BeginInvoke(new ThreadStart(delegate { butt_Click_1(null, null); }));
                }
                return;
            }
            try
            {
                PostSubmitter post;
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
                string swf_filename = !upstream_swf ? "client.swf" : "client_upstream.swf";
                if (!string.IsNullOrEmpty(chksum))
                {
                    post = new PostSubmitter
                    {
                        Url = "https://api.github.com/repos/fedorovvl/tso_client/contents/" + swf_filename,
                        Type = PostSubmitter.PostTypeEnum.Get
                    };
                    string rchksum = post.Post(ref _cookies).Trim();
                    var json = new JavaScriptSerializer();
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

        private void populateSettings(string[] settings)
        {
            if (!string.IsNullOrEmpty(settings[0]))
            {
                login.Text = settings[0];
                password.Password = settings[1];
                pwd.Visibility = System.Windows.Visibility.Collapsed;
            }
            if (settings.Length > 3)
            {
                if(settings[2].Length > 1)
                {
                    settings[2] = Convert.ToInt16(bool.Parse(settings[2])).ToString();
                }
                swf_upsteam.IsChecked = upstream_swf = Convert.ToBoolean(Convert.ToInt16(settings[2]));
                try
                {
                    if (settings.Length > 5)
                    {
                        _regionUid = string.IsNullOrEmpty(settings[5]) ? 16 : int.Parse(settings[5].Trim());
                        region_list.SelectedIndex = _regionUid;
                        _region = (region_list.SelectedItem as ComboBoxItem).Tag.ToString();
                    }
                }
                catch { }
            }
        }

        // remove old crypt in next release
        public void ReadSettings()
        {
            string[] settings = null;
            if (File.Exists(setting_file))
            {
                try
                {
                    settings = Encoding.UTF8.GetString(ProtectedData.Unprotect(File.ReadAllBytes(setting_file), additionalEntropy, DataProtectionScope.LocalMachine)).Split(new[] { '|' }, StringSplitOptions.None);
                }
                catch
                {
                    try
                    {
                        settings = new Crypt().Decrypt(File.ReadAllText(setting_file), true).Split(new[] { '|' }, StringSplitOptions.None);
                    }
                    catch
                    {
                        File.Move(setting_file, string.Format("bad_{0}", setting_file));
                    }
                }
            }
            if(settings != null)
                populateSettings(settings);
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
            byte[] saveData = Encoding.UTF8.GetBytes(string.Format("{0}|{1}|{2}|{3}|{4}|{5}|", SaveLogin.IsChecked == true ? login.Text : "", SaveLogin.IsChecked == true ? password.Password : "", swf_upsteam.IsChecked == true ? 1 : 0, "0", "0", _regionUid));
            File.WriteAllBytes(setting_file, ProtectedData.Protect(saveData, additionalEntropy, DataProtectionScope.LocalMachine));
            this.Visibility = System.Windows.Visibility.Hidden;
            bool collections = (cmd["collect"] != null) ? true : false;
            if (!auto && Process.GetProcessesByName("UbiCollect").Length > 0 && !collections)
            {
                MessageBoxResult messageBoxResult = System.Windows.MessageBox.Show(Servers.getTrans("collecttip"), Servers.getTrans("collect"), System.Windows.MessageBoxButton.YesNo);
                if (messageBoxResult == MessageBoxResult.Yes)
                {
                    collections = true;
                }
            }
            login log = new login() { Owner = ((null == e) ? null : this), username = login.Text, password = password.Password, region = _region, WindowStartupLocation = ((null == e) ? System.Windows.WindowStartupLocation.CenterScreen : System.Windows.WindowStartupLocation.CenterOwner) };
            log.ShowDialog();
            if (log.DialogResult == true)
            {
                _cookies = log.Cookies;
                var tsoUrl = HttpUtility.ParseQueryString(log.Ver);
                if (collections)
                {
                    if (Process.GetProcessesByName("UbiCollect").Length == 0)
                    {
                        MessageBoxResult messageBox = MessageBox.Show("--collect provided but no active ubicollect.exe found. Enable anyway?", "Warning", MessageBoxButton.YesNo, MessageBoxImage.Warning);
                        if (messageBox == MessageBoxResult.Yes)
                        {
                            tsoUrl.Set("s", "http://127.0.0.1:9000/https://ubistatic-a.akamaihd.net/0018/live");
                        }
                    }
                    else
                    {
                        tsoUrl.Set("s", "http://127.0.0.1:9000/https://ubistatic-a.akamaihd.net/0018/live");
                    }
                }
                if (!string.IsNullOrEmpty(lang))
                    tsoUrl.Set("lang", lang);
                if (cmd["window"] != null)
                    tsoUrl.Set("window", cmd["window"]);
                if (debug)
                    tsoUrl.Set("debug", "true");
                tsoUrl.Set("version", appversion);
                string tsoArg = string.Format("tso://{0}&baseUri={1}", tsoUrl.ToString().Replace("bb=https", "bb=http").Replace(":443", ""), Servers._servers[_region].domain);
                XmlDocument Doc = new XmlDocument();
                XmlNamespaceManager ns = new XmlNamespaceManager(Doc.NameTable);
                ns.AddNamespace("adobe", "http://ns.adobe.com/air/application/15.0");
                Doc.Load(string.Format("{0}\\META-INF\\AIR\\application.xml", ClientDirectory));
                Doc.SelectSingleNode("/adobe:application/adobe:id", ns).InnerText = "TSO-" + RandomString;
                Doc.SelectSingleNode("/adobe:application/adobe:name", ns).InnerText = "The Settlers Online - " + log.nickName;
                Doc.Save(string.Format("{0}\\META-INF\\AIR\\application.xml", ClientDirectory));
                System.Diagnostics.Process.Start(string.Format("{0}\\client.exe", ClientDirectory), tsoArg);
                try
                {
                    App.Current.Shutdown(1);
                }
                catch { }
            }
            this.Visibility = System.Windows.Visibility.Visible;
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
            _regionUid = int.Parse(((sender as ComboBox).SelectedItem as ComboBoxItem).Uid);
            langLogin = Servers.getTrans("login");
            langPass = Servers.getTrans("password");
            langRun = Servers.getTrans("run");
            langExit = Servers.getTrans("exit");
            langRemember = Servers.getTrans("remember");
        }

        private void openTsoFolder_Click(object sender, RoutedEventArgs e)
        {
            Process.Start(new ProcessStartInfo { Arguments = ClientDirectory, FileName = "explorer.exe" });
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

        private void swf_upsteam_Click(object sender, RoutedEventArgs e)
        {
            upstream_swf = (bool)(sender as CheckBox).IsChecked;
            new Thread(checkVersion) { IsBackground = true }.Start();
        }
    }

    public class gitFile
    {
        public string sha { get; set; }
        public string download_url { get; set; }
    }
}
