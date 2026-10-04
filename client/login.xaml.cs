using System;
using System.Text;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Threading;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Runtime.Serialization.Json;
using System.Runtime.Serialization;
using System.Drawing;
using System.Windows.Media.Imaging;
using OtpSharp;
using System.Web;

namespace client
{
    /// <summary>
    /// Логика взаимодействия для login.xaml
    /// </summary>
    public partial class login : Window
    {
        public string username { get; set; }
        public string password { get; set; }
        public string region { get; set; }
        public string nickName { get; set; }
        public string totpKey { get; set; }
        public string Ver { get; set; }
        public string Session { get; set; }
        public clientSettings _settings { get; set; }
        public CookieCollection Cookies { get; set; }
        private Thread authlogin;
        private bool fastSuccess = true;
        public bool FastLoginSuccess { get { return fastSuccess; } set { } }

        public int attepts = 0;


        public login()
        {
            InitializeComponent();
            AppDomain.CurrentDomain.UnhandledException += new UnhandledExceptionEventHandler(CurrentDomain_UnhandledException);
            System.Net.ServicePointManager.ServerCertificateValidationCallback
                = delegate (object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
                {
                    return true;
                };
            System.Net.ServicePointManager.Expect100Continue = false;
            Closing += new System.ComponentModel.CancelEventHandler(login_Closing);
            Loaded += Login_Loaded;
        }

        private void Login_Loaded(object sender, RoutedEventArgs e)
        {
            langExit.Text = Servers.getTrans("exit");
            langAuth.Content = Servers.getTrans("auth");
            authlogin = new Thread(MainAuth) { IsBackground = true };
            authlogin.Start();
        }

        void CurrentDomain_UnhandledException(object sender, UnhandledExceptionEventArgs e)
        {
            ExceptionDumper.DumpException(e.ExceptionObject as Exception);
        }

        void login_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            try { authlogin.Abort(); }
            catch { }
            GC.Collect();
        }

        private void titleBar_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
        }

        public void AddToRich(string message)
        {
            Dispatcher.BeginInvoke(new ThreadStart(delegate
            {
                richTextBox1.AppendText(message + "\r");
            }));
        }

        private void richTextBox1_TextChanged(object sender, TextChangedEventArgs e)
        {
            richTextBox1.ScrollToEnd();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            try { authlogin.Abort(); }
            catch { }
            DialogResult = false;
        }
        public T Deserialize<T>(string aJSON) where T : new()
        {
            T deserializedObj = new T();
            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(aJSON));
            DataContractJsonSerializer ser = new DataContractJsonSerializer(deserializedObj.GetType());
            deserializedObj = (T)ser.ReadObject(ms);
            ms.Close();
            return deserializedObj;
        }
        private void FastAuth()
        {
            if(Main.forceFullAuth)
            {
                fastSuccess = false;
                MainAuth();
                return;
            }
            var tsoUrl = HttpUtility.ParseQueryString(_settings.tsoArg);
            AddToRich("Try fastlogin");
            CookieCollection _cookies = new CookieCollection();
            PostSubmitter post = new PostSubmitter
            {
                Url = tsoUrl.Get("bb") + "authenticate",
                Type = PostSubmitter.PostTypeEnum.Post
            };
            post.PostItems.Add("DSOAUTHUSER", tsoUrl.Get("dsoAuthUser"));
            post.PostItems.Add("DSOAUTHTOKEN", tsoUrl.Get("dsoAuthToken"));
            string res = post.Post(ref _cookies);
            if (res.Contains("ERROR"))
            {
                AddToRich("Fastlogin failed. Back to normal auth");
                fastSuccess = false;
                MainAuth();
                return;
            }
            AddToRich(Servers.getTrans("launch"));
            Dispatcher.BeginInvoke(new ThreadStart(delegate
            {
                try
                {
                    DialogResult = true;
                }
                catch { }
            }));
            return;
        }
        public void MainAuth()
        {
            if (fastSuccess && _settings.tryFast && !string.IsNullOrEmpty(_settings.tsoArg))
            {
                FastAuth();
                return;
            }
            try
            {
                PostSubmitter post;
                string res;
                CookieCollection _cookies = new CookieCollection();
                if (attepts > 5)
                {
                    AddToRich(Servers.getTrans("nomoretry"));
                    return;
                }
                AddToRich(Servers.getTrans("tryauth") + attepts++);
                post = new PostSubmitter
                {
                    Url = string.Format("{0}{1}", Servers._servers[region].domain, Servers._servers[region].uplay.Replace("uplay", "login")),
                    Type = PostSubmitter.PostTypeEnum.Post
                };
                post.useBC = true;
                post.PostItems.Add("name", username.Trim());
                post.PostItems.Add("password", password.Trim());
                res = post.Post(ref _cookies);
                if (res.Contains("OKAY"))
                {
                    AddToRich(Servers.getTrans("authok"));
                    post = new PostSubmitter
                    {
                        Url = string.Format("{0}{1}", Servers._servers[region].domain, Servers._servers[region].main),
                        Type = PostSubmitter.PostTypeEnum.Post
                    };
                    post.PostItems.Add("start", "1");
                    post.useBC = true;
                    AddToRich("Get main page");
                    res = post.Post(ref _cookies);
                    post = new PostSubmitter
                    {
                        Url = string.Format("{0}{1}", Servers._servers[region].domain, Servers._servers[region].play),
                        Type = PostSubmitter.PostTypeEnum.Get
                    };
                    AddToRich(Servers.getTrans("getplay"));
                    post.useBC = true;
                    string token = post.Post(ref _cookies);
                    if (!PrepareFlash(token, token.Contains("thisProgram")))
                    {
                        AddToRich(Servers.getTrans("paramserr"));
                        if (token.StartsWith("https://"))
                        {
                            AddToRich("Redirect detected. Maintenance?");
                        }
                    }
                    foreach (Cookie cook in _cookies)
                    {
                        if (cook.Name.Contains("SESS"))
                        {
                            Session = cook.Value;
                            break;
                        }
                    }
                    Cookies = _cookies;
                    return;
                } else
                {
                    if (res.Contains("Captcha incorrect") || res.Contains("Captcha required"))
                    {
                        AddToRich(Servers.getTrans("captchaerr"));
                        return;
                    }
                    if (res.Contains("Login failed"))
                    {
                        AddToRich(Servers.getTrans("loginerr"));
                        return;
                    }
                    AddToRich(Servers.getTrans("autherr") + Regex.Unescape(res));
                }
            }
            catch (Exception e)
            {
                string msg = e.Message;
                if (Main.debug)
                    msg += e.StackTrace;
                AddToRich(Servers.getTrans("autherr") + msg);
            }
            return;
        }

        public bool PrepareFlash(string htmlPage, bool old_auth)
        {
            AddToRich(Servers.getTrans("getparams"));
            Match match = Regex.Match(htmlPage, (old_auth ? "thisProgram:" : "return") + " \"(?<tso>lang.*)\"", RegexOptions.IgnoreCase);
            if (!match.Success)
            {
                AddToRich(Servers.getTrans("tsourlerr"));
                return false;
            }
            else
            {
                Ver = match.Groups["tso"].Value.Trim();
            }
            match = Regex.Match(htmlPage, "loggedInUserName = '([А-Яа-яёЁйЙA-Za-z0-9_-]+)';", RegexOptions.IgnoreCase);
            nickName = username;
            if (match.Success)
            {
                nickName = match.Groups[1].Value.Trim();
                AddToRich(Servers.getTrans("nick") + nickName);
            }
            AddToRich(Servers.getTrans("launch"));
            Thread.Sleep(1000);
            Dispatcher.BeginInvoke(new ThreadStart(delegate
            {
                try
                {
                    DialogResult = true;
                }
                catch { }
            }));
            return true;

        }
    }

}
