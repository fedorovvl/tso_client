using System;
using System.IO;
using System.Net;
using System.Reflection;
using System.Text;
using System.Windows;
using Microsoft.Web.WebView2.Core;

namespace client
{
    public partial class CaptchaWindow : Window
    {
        private static readonly object loaderLock = new object();
        private static bool loaderReady;
        private readonly Uri pageUri;
        private readonly string siteKey;
        private readonly string captchaLanguage;

        public string ResponseToken { get; private set; }

        public CaptchaWindow(string pageUrl, string captchaSiteKey, string language)
        {
            InitializeComponent();
            pageUri = new Uri(pageUrl);
            siteKey = captchaSiteKey;
            captchaLanguage = language;
            instructions.Text = Servers.getTrans("captchaPrompt");
            cancelButton.Content = Servers.getTrans("captchaCancel");
            Loaded += CaptchaWindow_Loaded;
        }

        private async void CaptchaWindow_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                PrepareWebView2Loader();
                await browser.EnsureCoreWebView2Async();
                browser.CoreWebView2.WebMessageReceived += Browser_WebMessageReceived;
                browser.CoreWebView2.AddWebResourceRequestedFilter(
                    pageUri.AbsoluteUri,
                    CoreWebView2WebResourceContext.Document);
                browser.CoreWebView2.WebResourceRequested += Browser_WebResourceRequested;
                browser.Source = pageUri;
            }
            catch (Exception ex)
            {
                status.Text = Servers.getTrans("captchaOpenError") + ex.Message;
            }
        }

        internal static void PrepareWebView2Loader()
        {
            lock (loaderLock)
            {
                if (loaderReady) return;

                string loaderDirectory = Path.Combine(Path.GetTempPath(), "tso-client-webview2", "x86");
                string loaderPath = Path.Combine(loaderDirectory, "WebView2Loader.dll");
                Directory.CreateDirectory(loaderDirectory);

                using (Stream resource = Assembly.GetExecutingAssembly().GetManifestResourceStream("WebView2Loader.dll"))
                {
                    if (resource == null)
                        throw new InvalidOperationException("Embedded WebView2Loader.dll was not found.");

                    if (!File.Exists(loaderPath) || new FileInfo(loaderPath).Length != resource.Length)
                    {
                        using (FileStream output = new FileStream(loaderPath, FileMode.Create, FileAccess.Write, FileShare.Read))
                            resource.CopyTo(output);
                    }
                }

                CoreWebView2Environment.SetLoaderDllFolderPath(loaderDirectory);
                loaderReady = true;
            }
        }

        private void Browser_WebResourceRequested(object sender, CoreWebView2WebResourceRequestedEventArgs e)
        {
            try
            {
                if (!string.Equals(e.Request.Uri, pageUri.AbsoluteUri, StringComparison.OrdinalIgnoreCase))
                    return;

                string expired = Servers.getTrans("captchaExpired");
                string failed = Servers.getTrans("captchaLoadError");
                string html = "<!doctype html><html><head>" +
                    "<meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">" +
                    "<style>html,body{margin:0;min-height:100%;background:#242424;color:#fff;font:14px Arial}" +
                    "body{display:flex;flex-direction:column;align-items:center;padding-top:20px;box-sizing:border-box}" +
                    "#status{margin-top:12px;text-align:center}</style>" +
                    "<script src=\"https://www.google.com/recaptcha/api.js?hl=" + captchaLanguage + "&onload=renderCaptcha&render=explicit\" async defer></script>" +
                    "<script>function renderCaptcha(){grecaptcha.render('captcha-root',{sitekey:'" + JavaScriptEncode(siteKey) +
                    "',callback:function(token){chrome.webview.postMessage(token)},'expired-callback':function(){document.getElementById('status').textContent='" +
                    JavaScriptEncode(expired) + "'},'error-callback':function(){document.getElementById('status').textContent='" +
                    JavaScriptEncode(failed) + "'}})}</script></head>" +
                    "<body><div id=\"captcha-root\"></div><div id=\"status\"></div></body></html>";
                MemoryStream content = new MemoryStream(Encoding.UTF8.GetBytes(html));
                e.Response = browser.CoreWebView2.Environment.CreateWebResourceResponse(
                    content,
                    200,
                    "OK",
                    "Content-Type: text/html; charset=utf-8\r\nCache-Control: no-store");
            }
            catch (Exception ex)
            {
                status.Text = Servers.getTrans("captchaDisplayError") + ex.Message;
            }
        }

        private void Browser_WebMessageReceived(object sender, CoreWebView2WebMessageReceivedEventArgs e)
        {
            string token = e.TryGetWebMessageAsString();
            if (string.IsNullOrWhiteSpace(token)) return;
            ResponseToken = token;
            DialogResult = true;
        }

        private static string JavaScriptEncode(string value)
        {
            return (value ?? string.Empty)
                .Replace("\\", "\\\\")
                .Replace("'", "\\'")
                .Replace("\r", "\\r")
                .Replace("\n", "\\n");
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
        }
    }
}
