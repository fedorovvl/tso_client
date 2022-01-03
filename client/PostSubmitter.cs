using System;
using System.Collections.Specialized;
using System.IO;
using System.Net;
using System.Text;
using System.Threading;
using System.Web;
using System.Security.Authentication;

namespace client
{
    class PostSubmitter
    {
        public enum PostTypeEnum
        {
            /// <summary>
            ///   Does a get against the source.
            /// </summary>
            Get,
            /// <summary>
            ///   Does a post against the source.
            /// </summary>
            Post,
            Head
        }

        private string _mUrl = string.Empty;
        private NameValueCollection _mValues = new NameValueCollection();
        private NameValueCollection _hValues = new NameValueCollection();
        public const SslProtocols _Tls12 = (SslProtocols)0x00000C00;
        public const SecurityProtocolType Tls12 = (SecurityProtocolType)_Tls12;
        private PostTypeEnum _mType = PostTypeEnum.Get;
        private int attempts = 0;
        private string contentType = "application/x-www-form-urlencoded";

        /// <summary>
        ///   Default constructor.
        /// </summary>
        public PostSubmitter()
        {
        }

        /// <summary>
        ///   Constructor that accepts a url as a parameter
        /// </summary>
        /// <param name = "url">The url where the post will be submitted to.</param>
        public PostSubmitter(string url)
            : this()
        {
            _mUrl = url;
        }

        /// <summary>
        ///   Constructor allowing the setting of the url and items to post.
        /// </summary>
        /// <param name = "url">the url for the post.</param>
        /// <param name = "values">The values for the post.</param>
        public PostSubmitter(string url,
                             NameValueCollection values)
            : this(url)
        {
            _mValues = values;
        }

        /// <summary>
        ///   Gets or sets the url to submit the post to.
        /// </summary>
        public string Url
        {
            get { return _mUrl; }
            set { _mUrl = value; }
        }
        public string ContentType
        {
            get { return contentType; }
            set { contentType = value; }
        }

        /// <summary>
        ///   Gets or sets the name value collection of items to post.
        /// </summary>
        public NameValueCollection PostItems
        {
            get { return _mValues; }
            set { _mValues = value; }
        }
        public NameValueCollection HeaderItems
        {
            get { return _hValues; }
            set { _hValues = value; }
        }

        /// <summary>
        ///   Gets or sets the type of action to perform against the url.
        /// </summary>
        public PostTypeEnum Type
        {
            get { return _mType; }
            set { _mType = value; }
        }

        /// <summary>
        ///   Posts the supplied data to specified url.
        /// </summary>
        /// <returns>a string containing the result of the post.</returns>
        public string Post(ref CookieCollection cookieCollection)
        {
            Cookies = cookieCollection;

            if (null == Cookies)
            {
                Cookies = new CookieCollection();
            }

            var parameters = new StringBuilder();
            for (var i = 0; i < _mValues.Count; i++)
            {
                EncodeAndAddItem(ref parameters,
                                 _mValues.GetKey(i),
                                 _mValues[i]);
            }
            cookieCollection = Cookies;
            var result = PostData(_mUrl,
                                  parameters.ToString());

            return result;
        }

        public CookieCollection Cookies { get; set; }

        /// <summary>
        ///   Posts data to a specified url. Note that this assumes that you have already url encoded the post data.
        /// </summary>
        /// <param name = "postData">The data to post.</param>
        /// <param name = "url">the url to post to.</param>
        /// <returns>Returns the result of the post.</returns>
        private string PostData(string url,
                                string postData)
        {

            if (Main.debug)
                File.AppendAllText("debug.txt", "begin request " + url + "\n");
            var result = string.Empty;
            try
            {
                HttpWebRequest request = null;

                if (_mType == PostTypeEnum.Post)
                {
                    var uri = new Uri(url);
                    request = (HttpWebRequest)WebRequest.Create(uri);
                    //ServicePointManager.SecurityProtocol = Tls12;
                    request.Method = "POST";
                    request.UserAgent = "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.12 (KHTML, like Gecko) Chrome/9.0.570.0 Safari/534.12";
                    
                    if (postData.Contains("reporting"))
                    {
                        contentType = "text/xml";
                        request.Accept = "*/*";
                        request.Headers.Add("x-flash-version: 11,4,402,287");
                        request.Headers.Add("Accept-Encoding: gzip, deflate");
                    }
                    request.ContentType = contentType;
                    request.Timeout = 10000;
                    request.Referer = "http://game-cdn.thesettlersonline.net/prestaging/PS5724/SWMMO/debug/SWMMO.swf";
                    request.CookieContainer = new CookieContainer();
                    if ((null != Cookies) && (0 != Cookies.Count))
                    {
                        request.CookieContainer.Add(Cookies);
                    }
                    var encoding = new UTF8Encoding();
                    var bytes = encoding.GetBytes(postData);
                    request.ContentLength = bytes.Length;
                    for (var i = 0; i < _hValues.Count; i++)
                    {
                        if (null == request.Headers[_hValues.GetKey(i)])
                            request.Headers.Add(_hValues.GetKey(i), _hValues[i]);
                        else
                            request.Headers.Set(_hValues.GetKey(i), _hValues[i]);
                    }
                    using (var writeStream = request.GetRequestStream())
                    {
                        
                        
                        writeStream.Write(bytes,
                                          0,
                                          bytes.Length);
                    }
                }
                else
                {
                    var uri = new Uri(url + "?" + postData);
                    request = (HttpWebRequest)WebRequest.Create(uri);
                    request.UserAgent = "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.12 (KHTML, like Gecko) Chrome/9.0.570.0 Safari/534.12";
                    request.Referer = "http://game-cdn.thesettlersonline.net/prestaging/PS5724/SWMMO/debug/SWMMO.swf";
                    request.CookieContainer = new CookieContainer();

                    if ((null != Cookies) && (0 != Cookies.Count))
                    {
                        request.CookieContainer.Add(Cookies);
                    }
                    
                    request.Method = _mType.ToString();
                }
                if (Main.debug)
                    File.AppendAllText("debug.txt", "request send ok " + url + "\n");

                request.AllowAutoRedirect = false;
                var isResponceRecieved = false;

                while (false == isResponceRecieved)
                {
                    try
                    {
                        using (var response = (HttpWebResponse)request.GetResponse())
                        {
                            //System.Windows.MessageBox.Show(response.ContentLength.ToString());
                            if (_mType == PostTypeEnum.Post)
                            {
                                foreach (Cookie cookie in response.Cookies)
                                {
                                    var isMatch = false;
                                    for (var ii = 0; ii < Cookies.Count; ii++)
                                    {
                                        if (Cookies[ii].Name == cookie.Name)
                                        {
                                            Cookies[ii].Value = cookie.Value;
                                            Cookies[ii].Expires = cookie.Expires;
                                            isMatch = true;
                                        }
                                    }

                                    if (false == isMatch)
                                    {
                                        Cookies.Add(cookie);
                                    }
                                }
                            }


                            using (var responseStream = response.GetResponseStream())
                            {
                                using (var readStream = new StreamReader(responseStream,
                                                                         Encoding.UTF8))
                                {
                                    result = readStream.ReadToEnd();
                                }
                            }
                            if (_mType == PostTypeEnum.Head)
                            {
                                result = response.ContentLength.ToString();
                            }
                        }
                        isResponceRecieved = true;
                    }
                    catch(WebException e) {
                        if(Main.debug)
                            File.AppendAllText("debug.txt", url + e.Message + e.Status.ToString() + e.StackTrace + "\n");
                        if (e.Status == WebExceptionStatus.ProtocolError)
                        {
                            HttpWebResponse httpResponse = (HttpWebResponse)e.Response;
                            if (httpResponse.StatusCode == HttpStatusCode.Conflict)
                            {
                                result = " CAPCHA ";
                            }
                            if (httpResponse.StatusCode == HttpStatusCode.Unauthorized)
                            {
                                result = " FAILED ";
                            }
                            isResponceRecieved = true;
                        }
                        else
                        {
                            isResponceRecieved = false;
                        }
                    }

                    if (attempts > 20)
                        return "";
                    if (false == isResponceRecieved)
                    {
                        attempts++;
                        Thread.Sleep(
                            new Random().Next(
                                Convert.ToInt32(
                                    100),
                                Convert.ToInt32(
                                   300)));
                    }
                }
            }
            catch(Exception ex)
            {
                if (Main.debug)
                    File.AppendAllText("debug.txt", url + ex.Message + ex.StackTrace + "\n");
            }
            return result;
        }

        /// <summary>
        ///   Encodes an item and ads it to the string.
        /// </summary>
        /// <param name = "baseRequest">The previously encoded data.</param>
        /// <param name = "dataItem">The data to encode.</param>
        /// <returns>A string containing the old data and the previously encoded data.</returns>
        private void EncodeAndAddItem(ref StringBuilder baseRequest,
                                      string key,
                                      string dataItem)
        {
            if (baseRequest == null)
            {
                baseRequest = new StringBuilder();
            }
            if (baseRequest.Length != 0)
            {
                baseRequest.Append("&");
            }
            if(key != "raw") baseRequest.Append(key);

            if (string.Empty != dataItem)
            {
                if (key != "raw")
                {
                    baseRequest.Append("=");
                    baseRequest.Append(HttpUtility.UrlEncode(dataItem));
                }
                else
                {
                    baseRequest.Append(dataItem);
                }
            }
        }
    }
}
