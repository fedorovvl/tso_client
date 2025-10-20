using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Threading;
using System.Net;
using System.Net.Security;
using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;
using System.ComponentModel;
using System.Web.Script.Serialization;
using System.Text;
using System.Diagnostics;
using System.Windows.Forms;

namespace client
{
    /// <summary>
    /// Логика взаимодействия для login.xaml
    /// </summary>
    public partial class settings : Window
    {
        public clientSettings setting { get; set; }

        public string langLang { get { return Servers.getTrans("langLang"); } set { } }
        public string langConf { get { return Servers.getTrans("langConf"); } set { } }
        public string langtsoFolder { get { return Servers.getTrans("langtsoFolder"); } set { } }
        public string langx64 { get { return Servers.getTrans("langx64"); } set { } }
        public string langWinSize { get { return Servers.getTrans("langWinSize"); } set { } }
        public string langTotp { get { return Servers.getTrans("langTotp"); } set { } }
        public string langExit { get { return Servers.getTrans("exit"); } set { } }
        public string langSave { get { return Servers.getTrans("langSave"); } set { } }
        public string langDef { get { return Servers.getTrans("langDef"); } set { } }
        public string langNickConfig { get { return Servers.getTrans("langNickConfig"); } set { } }
        public string langDropbox { get { return Servers.getTrans("langDropbox"); } set { } }
        public string langDropboxRefresh { get { return Servers.getTrans("langDropboxRefresh"); } set { } }
        public string langTestDropbox { get { return Servers.getTrans("langTestDropbox"); } set { } }
        public string langAuthDropbox { get { return Servers.getTrans("langAuthDropbox"); } set { } }
        public string langTryFast { get { return Servers.getTrans("langTryFast"); } set { } }
        public string[] winSizes = new string[] { "", "maximized", "minimized", "fullscreen" };
        public string[] langs = new string[] { "", "de", "us", "en", "fr", "ru", "pl", "es", "nl", "cz", "pt", "it", "el", "ro" };

        public settings()
        {
            InitializeComponent();
            Closing += new System.ComponentModel.CancelEventHandler(login_Closing);
            Loaded += settings_Loaded;
            this.DataContext = this;
        }
        private void settings_Loaded(object sender, RoutedEventArgs e)
        {
            game_lang_list.SelectedIndex = Array.IndexOf(langs, setting.lang);
            totpkey.Text = setting.totpkey;
            dropboxKey.Text = setting.dropboxkey;
            dropboxRefresh.Text = setting.dropboxrefresh;
            x64runtime.IsChecked = setting.x64;
            tsofolder.Text = setting.tsofolder;
            clientconfig.Text = setting.clientconfig;
            nicknameConfig.IsChecked = setting.configNickname;
            tsoFolderNearLauncher.IsChecked = setting.tsoFolderNearLauncher;
            tryFast.IsChecked = setting.tryFast;
            if (!string.IsNullOrEmpty(setting.window))
            {
                window_size.SelectedIndex = Array.IndexOf(winSizes, setting.window);
            }
        }

        void login_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            GC.Collect();
        }

        private void titleBar_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            this.DragMove();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            setting.lang = (game_lang_list.SelectedItem as ComboBoxItem).Tag.ToString();
            setting.totpkey = totpkey.Text.Trim();
            setting.dropboxkey = dropboxKey.Text.Trim();
            setting.dropboxrefresh = dropboxRefresh.Text.Trim();
            setting.x64 = (bool)x64runtime.IsChecked;
            setting.configNickname = (bool)nicknameConfig.IsChecked;
            setting.tryFast = (bool)tryFast.IsChecked;
            setting.tsofolder = tsofolder.Text.Trim();
            setting.clientconfig = clientconfig.Text.Trim();
            setting.window = winSizes[window_size.SelectedIndex];
            setting.lang = langs[game_lang_list.SelectedIndex];
            setting.tsoFolderNearLauncher = (bool)tsoFolderNearLauncher.IsChecked;
            this.DialogResult = true;
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            this.DialogResult = false;
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(dropboxKey.Text.Trim())) { return; }
            CookieCollection _cookies = new CookieCollection();
            PostSubmitter post = new PostSubmitter
            {
                Url = Servers.dropboxAPI + "/oauth2/token",
                Type = PostSubmitter.PostTypeEnum.Post
            };
            post.HeaderItems.Add("Authorization", "Basic " + Convert.ToBase64String(UTF8Encoding.UTF8.GetBytes(dropboxKey.Text.Trim())));
            post.PostItems.Add("grant_type", "refresh_token");
            post.PostItems.Add("refresh_token", dropboxRefresh.Text.Trim());
            string result = post.Post(ref _cookies);
            if (!result.Contains("access_token"))
            {
                System.Windows.MessageBox.Show(result);
                return;
            }
            System.Windows.MessageBox.Show("OK");
            return;
        }

        private void Button_Click_3(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(dropboxKey.Text.Trim()) || string.IsNullOrEmpty(dropboxRefresh.Text.Trim())) { return; }
            CookieCollection _cookies = new CookieCollection();
            PostSubmitter post = new PostSubmitter
            {
                Url = Servers.dropboxAPI + "/oauth2/token",
                Type = PostSubmitter.PostTypeEnum.Post
            };
            post.HeaderItems.Add("Authorization", "Basic " + Convert.ToBase64String(UTF8Encoding.UTF8.GetBytes(dropboxKey.Text.Trim())));
            post.PostItems.Add("grant_type", "authorization_code");
            post.PostItems.Add("code", dropboxRefresh.Text.Trim());
            string result = post.Post(ref _cookies);
            if (!result.Contains("access_token"))
            {
                System.Windows.MessageBox.Show(result);
                return;
            }
            dropBoxAuth authInfo = Main.Deserialize<dropBoxAuth>(result);
            dropboxRefresh.Text = authInfo.refresh_token;
            System.Windows.MessageBox.Show("OK");
            return;
        }
        private void Button_Click_4(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(dropboxKey.Text.Trim())) { return; }
            Process.Start(new ProcessStartInfo { FileName = string.Format("{0}/oauth2/authorize?client_id={1}&response_type=code&token_access_type=offline", Servers.dropbox, dropboxKey.Text.Trim().Split(':')[0]), UseShellExecute = true });
        }

        private void export_MouseDown(object sender, MouseButtonEventArgs e)
        {
            e.Handled = true;
            using (var fbd = new OpenFileDialog() { InitialDirectory = Environment.CurrentDirectory })
            {
                fbd.CheckFileExists = false;
                fbd.FileName = Main.setting_file + "_open";
                DialogResult result = fbd.ShowDialog();
                if (result == System.Windows.Forms.DialogResult.OK)
                {
                    File.WriteAllText(fbd.FileName, new JavaScriptSerializer().Serialize(setting));
                    System.Windows.MessageBox.Show("OK");
                }
            }
        }

        private void import_MouseDown(object sender, MouseButtonEventArgs e)
        {
            e.Handled = true;
            using (var fbd = new OpenFileDialog() { InitialDirectory = Environment.CurrentDirectory })
            {
                DialogResult result = fbd.ShowDialog();
                if (result == System.Windows.Forms.DialogResult.OK)
                {
                    try
                    {
                        string settings = File.ReadAllText(fbd.FileName);
                        setting = new JavaScriptSerializer().Deserialize<clientSettings>(settings);
                        System.Windows.MessageBox.Show("OK");
                        this.DialogResult = true;
                    } catch(Exception ex)
                    {
                        System.Windows.MessageBox.Show("FAIL "+ex.Message);
                    }
                }
            }
        }
    }
}
