using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace client
{
    class Servers
    {
        public static Dictionary<string, Server> _servers = new Dictionary<string, Server>()
        {
            { "de", new Server(){ domain = "https://www.diesiedleronline.de", uplay = "/de/api/user/uplay", main = "/de/startseite", play = "/de/spielen" } },
            { "us", new Server(){ domain = "https://www.thesettlersonline.net", uplay = "/en/api/user/uplay", main = "/en/homepage", play = "/en/play" } },
            { "en", new Server(){ domain = "https://www.thesettlersonline.com", uplay = "/en/api/user/uplay", main = "/en/homepage", play = "/en/play" } },
            { "fr", new Server(){ domain = "https://www.thesettlersonline.fr", uplay = "/fr/api/user/uplay", main = "/fr/page-de-d%C3%A9marrage", play = "/fr/jouer" } },
            { "ru", new Server(){ domain = "https://www.thesettlersonline.ru", uplay = "/ru/api/user/uplay", main = "/ru/%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%B0%D1%8F-%D1%81%D1%82%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D0%B0", play = "/ru/play" } },
            { "pl", new Server(){ domain = "https://www.thesettlersonline.pl", uplay = "/pl/api/user/uplay", main = "/pl/strona-g%C5%82%C3%B3wna", play = "/pl/graj" } },
            { "es2", new Server(){ domain = "https://www.thesettlersonline.es", uplay = "/es/api/user/uplay", main = "/es/p%C3%A1gina-de-inicio", play = "/es/jugar" } },
            { "es", new Server(){ domain = "https://juego-thesettlersonline.com", uplay = "/es/api/user/uplay", main = "/es/p%C3%A1gina-de-inicio", play = "/es/jugar" } },
            { "nl", new Server(){ domain = "https://www.thesettlersonline.nl", uplay = "/nl/api/user/uplay", main = "/nl/homepage", play = "/nl/play" } },
            { "cz", new Server(){ domain = "https://www.thesettlersonline.cz", uplay = "/cz/api/user/uplay", main = "/cs/domovsk%C3%A1-str%C3%A1nka", play = "/cs/play" } },
            { "pt", new Server(){ domain = "https://www.thesettlersonline.com.br", uplay = "/pt/api/user/uplay", main = "/pt/p%C3%A1gina-inicial", play = "/pt/jogar" } },
            { "it", new Server(){ domain = "https://www.thesettlersonline.it", uplay = "/it/api/user/uplay", main = "/it/homepage", play = "/it/gioca" } },
            { "el", new Server(){ domain = "https://www.thesettlersonline.gr", uplay = "/el/api/user/uplay", main = "/el/%CE%B1%CF%81%CF%87%CE%B9%CE%BA%CE%AE-%CF%83%CE%B5%CE%BB%CE%AF%CE%B4%CE%B1", play = "/el/play" } },
            { "ro", new Server(){ domain = "https://www.thesettlersonline.ro", uplay = "/ro/api/user/uplay", main = "/ro/pagina-de-start", play = "/ro/play" } },
        };

        public static Dictionary<string, string> _langs = new Dictionary<string, string>()
        {
            {  "de", "de-de" },
            {  "us", "en-us" },
            {  "en", "en-uk" },
            {  "fr", "fr-fr" },
            {  "ru", "ru-ru" },
            {  "pl", "pl-pl" },
            {  "es2", "es-es" },
            {  "es", "es-es" },
            {  "nl", "nl-nl" },
            {  "cz", "cz-cz" },
            {  "pt", "pt-br" },
            {  "it", "it-it" },
            {  "el", "el-gr" },
            {  "ro", "ro-ro" }
        };

        public static Dictionary<string, Dictionary<string, string>> trans = new Dictionary<string, Dictionary<string, string>>()
        {
            { "ru-ru", new Dictionary<string, string>() {
                { "login", "Электронный адрес" },
                { "password", "Пароль" },
                { "letsplay", "можно играть" },
                { "checking", "Проверяем клиент" },
                { "downloading", "Скачиваем.." },
                { "emptypass", "Пароль пуст." },
                { "emptylogin", "Логин пуст." },
                { "collect", "Подсветка" },
                { "collecttip", "Использовать подсветку коллекций?\nНажимайте \"да\" только если у вас запущен UbiCollect.exe!" },
                { "tryauth", "Попытка авторизации #" },
                { "nomoretry", "Хватит пытаться :)" },
                { "ubiauth", "Авторизация ubi" },
                { "authok", "Успешная авторизация " },
                { "uplayauth", "Авторизация uplay" },
                { "getplay", "Запрос страницы play" },
                { "cookieerr", "Не смогли получить печеньки :'(" },
                { "paramserr", "Ошибка получения параметров" },
                { "autherr", "Ошибка авторизации. ответ - " },
                { "loginerr", "Логин/пароль неверны." },
                { "captchaerr", "Поймали капчу.. попробуйте позже." },
                { "uplayerr", "UPLAY не отвечает." },
                { "authex", "Ошибка на странице авторизации." },
                { "emptyauth", "Хм, пустой ответ.. странно " },
                { "getparams", "Получаем параметры." },
                { "tsourlerr", "Ошибка получения кода." },
                { "nick", "Ник игрока - " },
                { "launch", "Запускаем клиент..." },
             }
            },
            { "en-uk", new Dictionary<string, string>() {
                { "login", "E-mail" },
                { "password", "Password" },
                { "letsplay", "lets play" },
                { "checking", "Cheking client" },
                { "downloading", "Downloading.." },
                { "emptypass", "Empty password." },
                { "emptylogin", "Empty login." },
                { "collect", "Highlight" },
                { "collecttip", "Want to use highlight feature?\nPress \"yes\" only after start UbiCollect.exe!" },
                { "tryauth", "Login attempt #" },
                { "nomoretry", "Enough.. i'm tired :)" },
                { "ubiauth", "Authentication ubi" },
                { "authok", "Successful authentication " },
                { "uplayauth", "Authentication uplay" },
                { "getplay", "Request play page" },
                { "cookieerr", "Can't grab cookies :'(" },
                { "paramserr", "Get params error" },
                { "autherr", "Authentication error. response - " },
                { "loginerr", "E-mail or password not correct." },
                { "captchaerr", "Got Captha.. try later." },
                { "uplayerr", "UPLAY not responding." },
                { "authex", "Auth page exception." },
                { "emptyauth", "Empty response.. thats wierd " },
                { "getparams", "Get params." },
                { "tsourlerr", "Error getting tsoUrl param." },
                { "nick", "Nickname - " },
                { "launch", "Launch client..." },
              }
            }
        };

        public static string getTrans(string value)
        {
            if (!trans.ContainsKey(_langs[Main._region]))
                return trans["en-uk"][value];
            return trans[_langs[Main._region]][value];
        }
    }

    class Server
    {
        public string domain { get; set; }
        public string uplay { get; set; }
        public string main { get; set; }
        public string play { get; set; }
    }
}
