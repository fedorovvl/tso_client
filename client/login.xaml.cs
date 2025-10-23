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
            if(Main.newAuth)
                authlogin = new Thread(CipAuth) { IsBackground = true };
            else
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
        public void CipAuth()
        {
            try
            {
                if (fastSuccess && _settings.tryFast && !string.IsNullOrEmpty(_settings.tsoArg))
                {
                    FastAuth();
                    return;
                }
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
                    Url = string.Format("{0}{1}", Servers._servers[region].domain, "/oauth/start"),
                    Type = PostSubmitter.PostTypeEnum.Get
                };
                res = post.Post(ref _cookies);
                if(!res.Contains("https"))
                {
                    AddToRich(Servers.getTrans("autherr"));
                    AddToRich(res);
                    return;
                }
                post = new PostSubmitter
                {
                    Url = res,
                    Type = PostSubmitter.PostTypeEnum.Get
                };
                AddToRich("Start oauth");
                Uri redirectUrl = new Uri(post.Post(ref _cookies));
                var redirectUrlOpts = HttpUtility.ParseQueryString(redirectUrl.Query);
                AddToRich("ClientId "+ redirectUrlOpts.Get("client_id"));
                AddToRich("Get access token");
                post = new PostSubmitter
                {
                    Url = "https://connect.ubisoft.com/v2/webauth/public/ubiservices/oauthToken",
                    Type = PostSubmitter.PostTypeEnum.Post
                };
                post.ContentType = "application/json";
                post.useBC = true;
                post.PostItems.Add("{\"headers\":{\"Content-Type\":\"application/json\",\"Accept\":\"application/json\"}}", string.Empty);
                res = post.Post(ref _cookies);
                if(res.Contains("ERROR"))
                {
                    AddToRich(Servers.getTrans("autherr"));
                    AddToRich(res);
                    return;
                }
                UbioAuth oAuthData = Deserialize<UbioAuth>(res);
                AddToRich("Get auth token");
                post = new PostSubmitter
                {
                    Url = "https://api.partners.ubisoft.com/v1/profiles/authentication/token",
                    Type = PostSubmitter.PostTypeEnum.Post
                };
                post.useBC = true;
                post.ContentType = "application/json";
                post.PostItems.Add("{\"rememberMe\":true}", string.Empty);
                post.HeaderItems.Add("Ubi-RequestedPlatformType", "uplay");
                post.HeaderItems.Add("Authorization", "Bearer " + oAuthData.accessToken);
                post.HeaderItems.Add("Ubi-Profile-Authorization", "Basic " + Convert.ToBase64String(UTF8Encoding.UTF8.GetBytes(string.Format("{0}:{1}", username.Trim(), password.Trim()))));
                res = post.Post(ref _cookies);
                if (res.Contains("ERROR"))
                {
                    AddToRich(Servers.getTrans("autherr"));
                    AddToRich(res);
                    return;
                }
                if (res.Contains("FAILED"))
                {
                    AddToRich(Servers.getTrans("loginerr"));
                    return;
                }
                UbiAuth AuthData = Deserialize<UbiAuth>(res);
                if (AuthData.twoFactorAuthenticationTicket != null)
                {
                    if (string.IsNullOrEmpty(totpKey))
                    {
                        AddToRich("2fa detected but no key present");
                        attepts = 6;
                        return;
                    }
                    Totp totp = new Totp(Base32.Base32Encoder.Decode(totpKey));
                    post = new PostSubmitter
                    {
                        Url = "https://api.partners.ubisoft.com/v1/profiles/authentication/token",
                        Type = PostSubmitter.PostTypeEnum.Post
                    };
                    post.useBC = true;
                    post.HeaderItems.Add("Ubi-Profile-Authorization", "ubi_2fa_v1 t=" + AuthData.twoFactorAuthenticationTicket);
                    post.HeaderItems.Add("Authorization", "Bearer " + oAuthData.accessToken);
                    post.ContentType = "application/json";
                    post.HeaderItems.Add("Ubi-2FACode", totp.ComputeTotp());
                    post.HeaderItems.Add("Ubi-RequestedPlatformType", "uplay");
                    post.PostItems.Add("{}", string.Empty);
                    res = post.Post(ref _cookies);
                    AddToRich(Servers.getTrans("auth") + " 2fa");
                    if (res.Contains("token"))
                    {
                        AddToRich(Servers.getTrans("authok"));
                        AuthData = Deserialize<UbiAuth>(res);
                    }
                    else
                    {
                        AddToRich(Servers.getTrans("autherr"));
                        return;
                    }
                }
                AddToRich(AuthData.token);
                redirectUrlOpts.Add("token", AuthData.token);
                post = new PostSubmitter
                {
                    Url = "https://api.partners.ubisoft.com/v1/oauth/authorize/callback",
                    Type = PostSubmitter.PostTypeEnum.Get
                };
                post.useBC = true;
                post.PostItems.Add(redirectUrlOpts.ToString(), string.Empty);
                AddToRich("Get profile_token");
                res = post.Post(ref _cookies);
                if (res.Contains("ERROR"))
                {
                    AddToRich(Servers.getTrans("autherr"));
                    AddToRich(res);
                    return;
                }
                var callbackOpts = HttpUtility.ParseQueryString(HttpUtility.ParseQueryString(new Uri(res).Query)["redirectUrl"]);
                AddToRich(callbackOpts.Get("profile_token"));
                redirectUrlOpts.Add("profile_token", callbackOpts.Get("profile_token"));
                redirectUrlOpts.Remove("token");
                post = new PostSubmitter
                {
                    Url = "https://api.partners.ubisoft.com/v1/oauth/consents",
                    Type = PostSubmitter.PostTypeEnum.Post
                };
                post.useBC = true;
                post.ContentType = "application/json";
                post.HeaderItems.Add("Ubi-RequestedPlatformType", "uplay");
                post.HeaderItems.Add("ClientId", redirectUrlOpts.Get("client_id"));
                post.PostItems.Add("{\"scopesConsented\":[\"offline_access\",\"openid\",\"profile\",\"email\"],\"isConsented\":true,\"redirectUrl\":\"https://api.partners.ubisoft.com/v1/oauth/authorize/callback?" + redirectUrlOpts.ToString() + "\"}", string.Empty);
                AddToRich("Get login url");
                res = post.Post(ref _cookies);
                post = new PostSubmitter
                {
                    Url = "https://api.partners.ubisoft.com/v1/oauth/authorize/callback",
                    Type = PostSubmitter.PostTypeEnum.Get
                };
                post.useBC = true;
                post.PostItems.Add(redirectUrlOpts.ToString(), string.Empty);
                res = post.Post(ref _cookies);

                post = new PostSubmitter
                {
                    Url = res.Replace("login", "login2"),
                    Type = PostSubmitter.PostTypeEnum.Get
                };
                AddToRich("Post login url");
                res = post.Post(ref _cookies);
                post = new PostSubmitter
                {
                    Url = res,
                    Type = PostSubmitter.PostTypeEnum.Get
                };
                AddToRich("Post login url");
                res = post.Post(ref _cookies);
                post = new PostSubmitter
                {
                    Url = string.Format("{0}{1}", Servers._servers[region].domain, Servers._servers[region].main),
                    Type = PostSubmitter.PostTypeEnum.Get
                };
                res = post.Post(ref _cookies);
                post = new PostSubmitter
                {
                    Url = string.Format("{0}{1}", Servers._servers[region].domain, Servers._servers[region].play),
                    Type = PostSubmitter.PostTypeEnum.Get
                };
                AddToRich(Servers.getTrans("getplay"));
                res = post.Post(ref _cookies);
                if (!PrepareFlash(res, res.Contains("thisProgram")))
                {
                    AddToRich(Servers.getTrans("paramserr"));
                    //CipAuth();
                }
            }
            catch (Exception e)
            {
                string msg = e.Message;
                if (Main.debug)
                    msg += e.StackTrace;
                AddToRich(Servers.getTrans("autherr") + msg);
                //CipAuth();
            }
            return;
        }
        public void MainAuth()
        {
            try
            {
                if(fastSuccess && _settings.tryFast && !string.IsNullOrEmpty(_settings.tsoArg))
                {
                    FastAuth();
                    return;
                }
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
                    Url = Servers.ubiServices,
                    Type = PostSubmitter.PostTypeEnum.Post
                };
                post.HeaderItems.Add("Authorization", "Basic " + Convert.ToBase64String(UTF8Encoding.UTF8.GetBytes(string.Format("{0}:{1}", username.Trim(), password.Trim()))));
                post.ContentType = "application/json";
                post.HeaderItems.Add("Ubi-AppId", "39164658-8187-4bf4-b46c-375f68356e3b");
                post.HeaderItems.Add("Ubi-RequestedPlatformType", "uplay");
                post.HeaderItems.Add("GenomeId", "978da00d-2533-4af4-a550-3ba09289084e");
                post.PostItems.Add("{\"rememberMe\":true}", string.Empty);
                res = post.Post(ref _cookies);
                AddToRich(Servers.getTrans("auth") + " ubi");
                if (res.Contains("sessionKey"))
                {
                    AddToRich(Servers.getTrans("authok"));
                    UbiSession sessionData = Deserialize<UbiSession>(res);
                    if (sessionData.twoFactorAuthenticationTicket != null)
                    {
                        if (string.IsNullOrEmpty(totpKey))
                        {
                            AddToRich("2fa detected but no key present");
                            attepts = 6;
                            return;
                        }
                        Totp totp = new Totp(Base32.Base32Encoder.Decode(totpKey));
                        post = new PostSubmitter
                        {
                            Url = Servers.ubiServices,
                            Type = PostSubmitter.PostTypeEnum.Post
                        };
                        post.HeaderItems.Add("Authorization", "ubi_2fa_v1 t=" + sessionData.twoFactorAuthenticationTicket);
                        post.ContentType = "application/json";
                        post.HeaderItems.Add("Ubi-2FACode", totp.ComputeTotp());
                        post.HeaderItems.Add("Ubi-AppId", "39164658-8187-4bf4-b46c-375f68356e3b");
                        post.HeaderItems.Add("Ubi-RequestedPlatformType", "uplay");
                        post.HeaderItems.Add("GenomeId", "978da00d-2533-4af4-a550-3ba09289084e");
                        post.PostItems.Add("{\"rememberMe\":true}", string.Empty);
                        res = post.Post(ref _cookies);
                        AddToRich(Servers.getTrans("auth") + " 2fa");
                        if (res.Contains("sessionKey"))
                        {
                            AddToRich(Servers.getTrans("authok"));
                            sessionData = Deserialize<UbiSession>(res);
                        } else
                        {
                            AddToRich(Servers.getTrans("autherr"));
                            return;
                        }
                    }
                    post = new PostSubmitter
                    {
                        Url = string.Format("{0}{1}", Servers._servers[region].domain, Servers._servers[region].uplay),
                        Type = PostSubmitter.PostTypeEnum.Post
                    };
                    DateTime dt = DateTime.Parse(sessionData.expiration).ToUniversalTime();
                    Int32 unixTimestamp = (Int32)(dt.Subtract(new DateTime(1970, 1, 1))).TotalSeconds;
                    post.PostItems.Add("id", sessionData.userId);
                    post.PostItems.Add("ticket", sessionData.ticket);
                    post.PostItems.Add("expiration", unixTimestamp.ToString());
                    post.PostItems.Add("undefined", sessionData.sessionId);
                    post.PostItems.Add("activated", "true");
                    post.useBC = true;
                    AddToRich(Servers.getTrans("auth") + " uplay");
                    res = post.Post(ref _cookies);
                    if (Main.debug)
                        File.AppendAllText("debug.txt", "recieved "+ res + "\n");
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
                        res = post.Post(ref _cookies);
                        post = new PostSubmitter
                        {
                            Url = string.Format("{0}{1}", Servers._servers[region].domain, Servers._servers[region].play),
                            Type = PostSubmitter.PostTypeEnum.Get
                        };
                        AddToRich(Servers.getTrans("getplay"));
                        post.useBC = true;
                        string token = post.Post(ref _cookies);
                        if (!token.Contains("thisProgram") && !token.Contains("return \"lang"))
                        {
                            AddToRich(Servers.getTrans("cookieerr"));
                            return;
                        }
                        if (!PrepareFlash(token, token.Contains("thisProgram")))
                        {
                            AddToRich(Servers.getTrans("paramserr"));
                            MainAuth();
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
                    }
                    else
                    {
                        checkForError(res);
                    }
                }
                else
                {
                    checkForError(res);
                }
            }
            catch (Exception e)
            {
                string msg = e.Message;
                if (Main.debug)
                    msg += e.StackTrace;
                AddToRich(Servers.getTrans("autherr") + msg);
                MainAuth();
            }
            return;
        }

        private void checkForError(string res)
        {
            if (res.Contains("FAILED"))
            {
                AddToRich(Servers.getTrans("loginerr"));
                return;
            }
            if (res.Contains(" CAPCHA "))
            {
                AddToRich(Servers.getTrans("captchaerr"));
                return;
            }
            if (res.Contains("UPLAY"))
            {
                AddToRich(Servers.getTrans("uplayerr"));
                MainAuth();
            }
            if (res.Contains("EXCEPTION"))
            {
                AddToRich(Servers.getTrans("authex"));
                MainAuth();
            }

            if (res.Trim() == "")
            {
                AddToRich(Servers.getTrans("emptyauth"));
            }
            else
            {
                AddToRich(Servers.getTrans("autherr") + res);
                MainAuth();
            }
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

    [DataContract]
    public class UbiSession
    {
        [DataMember(Name = "platformType")]
        public string platformType { get; set; }
        [DataMember(Name = "ticket")]
        public string ticket { get; set; }
        [DataMember(Name = "twoFactorAuthenticationTicket")]
        public string twoFactorAuthenticationTicket { get; set; }
        [DataMember(Name = "profileId")]
        public string profileId { get; set; }
        [DataMember(Name = "userId")]
        public string userId { get; set; }
        [DataMember(Name = "nameOnPlatform")]
        public string nameOnPlatform { get; set; }
        [DataMember(Name = "environment")]
        public string environment { get; set; }
        [DataMember(Name = "expiration")]
        public string expiration { get; set; }
        [DataMember(Name = "spaceId")]
        public string spaceId { get; set; }
        [DataMember(Name = "sessionId")]
        public string sessionId { get; set; }
        [DataMember(Name = "sessionKey")]
        public string sessionKey { get; set; }
        [DataMember(Name = "rememberMeTicket")]
        public string rememberMeTicket { get; set; }

    }
    [DataContract]
    public class UbiAuth
    {
        [DataMember(Name = "token")]
        public string token { get; set; }
        [DataMember(Name = "rememberDeviceTicket")]
        public string rememberDeviceTicket { get; set; }
        [DataMember(Name = "twoFactorAuthenticationTicket")]
        public string twoFactorAuthenticationTicket { get; set; }

    }
    [DataContract]
    public class UbioAuth
    {
        [DataMember(Name = "accessToken")]
        public string accessToken { get; set; }
    }
}
