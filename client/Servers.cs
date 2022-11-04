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
                { "auth", "Авторизация" },
                { "authok", "Успешная авторизация " },
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
                { "run", "ВХОД" },
                { "exit", "закрыть" },
                { "remember", "Запомнить" },
             }
            },
            { "en-uk", new Dictionary<string, string>() {
                { "login", "E-mail" },
                { "password", "Password" },
                { "letsplay", "lets play" },
                { "checking", "Checking client" },
                { "downloading", "Downloading.." },
                { "emptypass", "Empty password." },
                { "emptylogin", "Empty login." },
                { "collect", "Highlight" },
                { "collecttip", "Want to use highlight feature?\nPress \"yes\" only after start UbiCollect.exe!" },
                { "tryauth", "Login attempt #" },
                { "nomoretry", "Enough.. i'm tired :)" },
                { "auth", "Authentication" },
                { "authok", "Successful authentication " },
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
                { "run", "PLAY" },
                { "exit", "exit" },
                { "remember", "Remember" },
             }
            },
            { "fr-fr", new Dictionary<string, string>() {
                { "login", "E-mail" },
                { "password", "Mot de passe" },
                { "letsplay", "Jouons" },
                { "checking", "Vérification client" },
                { "downloading", "Téléchargement.." },
                { "emptypass", "Mot de passe vide." },
                { "emptylogin", "Login vide." },
                { "collect", "Marquage objet" },
                { "collecttip", "Voulez vous utiliser le marquage des objets?\nPress \"oui\" si UbiCollect.exe a été lancé !" },
                { "tryauth", "Attente d'authentification #" },
                { "nomoretry", "Cela suffit, je suis fatigué..." },
                { "auth", "Authentification" },
                { "authok", "Authentification réussi" },
                { "getplay", "Demande de page de jeu" },
                { "cookieerr", "Impossible de saisir les cookies :'(" },
                { "paramserr", "Erreur dans les paramètres" },
                { "autherr", "Erreur d'authentification. response - " },
                { "loginerr", "E-mail ou mot de passe incorrecte." },
                { "captchaerr", "Demande captcha, réessayer plus tard." },
                { "uplayerr", "UPLAY ne répond pas." },
                { "authex", "Exception de la page d'autorisation." },
                { "emptyauth", "Réponse vide... c'est bizarre." },
                { "getparams", "Demande de paramètre." },
                { "tsourlerr", "Obtenir une erreur tsoUrl paramètre." },
                { "nick", "Pseudonyme - " },
                { "launch", "Lancement client..." },
                { "run", "JOUER" },
                { "exit", "fermer" },
                { "remember", "Retenir" },
              }
           },
           { "pl-pl", new Dictionary<string, string>() {
                { "login", "E-mail" },
                { "password", "Hasło" },
                { "letsplay", "Rozgrywka możliwa" },
                { "checking", "Sprawdzam klienta" },
                { "downloading", "Pobieranie..." },
                { "emptypass", "Puste hasło." },
                { "emptylogin", "Pusty login." },
                { "collect", "Podświetlenie" },
                { "collecttip", "Chcesz użyć funkcji podświetlania?\nNaciśnij \"tak\" tylko jeśli uruchomiony jest UbiCollect.exe!" },
                { "tryauth", "Próba logowania #" },
                { "nomoretry", "Wystarczy... jestem zmęczony :)" },
                { "auth", "Uwierzytelnianie" },
                { "authok", "Udane uwierzytelnienie " },
                { "getplay", "Żądanie o stronę gry" },
                { "cookieerr", "Nie mogę pobrać ciasteczek :'(" },
                { "paramserr", "Uzyskaj parametr błędu" },
                { "autherr", "Błąd uwierzytelniania - " },
                { "loginerr", "E-mail lub hasło nieprawidłowe." },
                { "captchaerr", "Uzyskanie Captha.. spróbuj później." },
                { "uplayerr", "UPLAY nie odpowiada." },
                { "authex", "Wyjątek strony uwierzytelniania." },
                { "emptyauth", "Pusta odpowiedź... to dziwne " },
                { "getparams", "Uzyskaj parametry." },
                { "tsourlerr", "Błąd pobierania parametru tsoUrl." },
                { "nick", "Nick - " },
                { "launch", "Uruchom klienta..." },
                { "run", "GRAJ" },
                { "exit", "Wyjście" },
                { "remember", "Zapamiętaj" },
             }
           },
           { "de-de", new Dictionary<string, string>() {
                { "login", "E-Mail-Adresse" },
                { "password", "Passwort" },
                { "letsplay", "du kannst spielen" },
                { "checking", "Überprüfen des Clients" },
                { "downloading", "Downloading.." },
                { "emptypass", "Passwort ist leer." },
                { "emptylogin", "Login ist leer." },
                { "collect", "Hervorheben" },
                { "collecttip", "Hervorhebung von Sammlungen verwenden?\nDrücken Sie \"Ja\" nur, wenn UbiCollect.exe ausgeführt wird!" },
                { "tryauth", "Autorisierung versuch #" },
                { "nomoretry", "Hör auf zu versuchen :)" },
                { "auth", "Autorisierung" },
                { "authok", "Erfolgreiche Autorisierung" },
                { "getplay", "Seitenanforderung abspielen" },
                { "cookieerr", "Cookies konnten nicht abgerufen werden :'(" },
                { "paramserr", "Fehler beim Abrufen der Parameter" },
                { "autherr", "Authorization error. response - " },
                { "loginerr", "Benutzername/Passwort ist falsch." },
                { "captchaerr", "Captcha abgefangen. Versuchen Sie es später noch einmal." },
                { "uplayerr", "UPLAY antwortet nicht." },
                { "authex", "Fehler auf der Anmeldeseite." },
                { "emptyauth", "Hmm, leere Antwort ... seltsam" },
                { "getparams", "Parameter abrufen." },
                { "tsourlerr", "Fehler beim Abrufen des Codes." },
                { "nick", "Spitzname des Spielers - " },
                { "launch", "Client starten..." },
                { "run", "SPIELEN" },
                { "exit", "schließen" },
                { "remember", "Erinnern" },
              }
           },
           { "pt-br", new Dictionary<string, string>() {
                { "login", "E-mail" },
                { "password", "Senha" },
                { "letsplay", "Jogar" },
                { "checking", "Verificando o cliente" },
                { "downloading", "Baixando.." },
                { "emptypass", "Senha vazia." },
                { "emptylogin", "E-Mail vazio." },
                { "collect", "Colecionaveis" },
                { "collecttip", "Quer usar o marcador de colecionaveis?\nApertar \"yes\" somente apos ativar o UbiCollect.exe!" },
                { "tryauth", "Tentativa de login #" },
                { "nomoretry", "ja foi.. cansei :)" },
                { "auth", "Autenticando" },
                { "authok", "Autenticado com sucesso " },
                { "getplay", "Pedindo pagina inicial" },
                { "cookieerr", "Não consigo achar os cookies :'(" },
                { "paramserr", "Erro ao obter os parametros" },
                { "autherr", "Erro de autenticação. resposta - " },
                { "loginerr", "E-mail ou senha errada." },
                { "captchaerr", "Recebí o Captha.. tenta mais tarde." },
                { "uplayerr", "UPLAY não responde." },
                { "authex", "Exceção na pagina de autenticação." },
                { "emptyauth", "Resposta vazia .. isso é estranho " },
                { "getparams", "Obtendo parametros." },
                { "tsourlerr", "Erro ao obter o parâmetro tsoUrl." },
                { "nick", "Apelido - " },
                { "launch", "Iniciar cliente..." },
                { "run", "JOGAR" },
                { "exit", "sair" },
                { "remember", "Lembrar" },
              }
           },
           { "es-es", new Dictionary<string, string>() {
                { "login", "E-Mail" },
                { "password", "Contraseña" },
                { "letsplay", "Listo para jugar" },
                { "checking", "Verificando el cliente..." },
                { "downloading", "Descargando..." },
                { "emptypass", "Contraseña vacía." },
                { "emptylogin", "E-Mail vacío." },
                { "collect", "Coleccionables" },
                { "collecttip", "¿Quieres usar el marcador de coleccionables?\n¡Aperta \"yes\" solo después de abrir UbiCollect.exe!" },
                { "tryauth", "Intento de inicio de sesión #" },
                { "nomoretry", "Suficiente... Me cansé :)" },
                { "auth", "Autentificando..." },
                { "authok", "Autentificado con éxito" },
                { "getplay", "Cargando página inicial..." },
                { "cookieerr", "No conseguí agarrar las cookies :'(" },
                { "paramserr", "Error de parámetros" },
                { "autherr", "Error de autentificación. Respuesta - " },
                { "loginerr", "E-mail o contraseña errada." },
                { "captchaerr", "Recibí un Captcha... Intenta más tarde." },
                { "uplayerr", "UPLAY no responde." },
                { "authex", "Excepción en la página de autentificación." },
                { "emptyauth", "Respuesta vacía... Esto es extraño." },
                { "getparams", "Obteniendo parámetros..." },
                { "tsourlerr", "Error de parámetro tsoUrl." },
                { "nick", "Nick - " },
                { "launch", "Iniciando cliente..." },
                { "run", "JUGAR" },
                { "exit", "salir" },
                { "remember", "Recordar" },
              }
           }
        };

        public static string getRandReferer()
        {
            Random rand = new Random();
            return _servers.ElementAt(rand.Next(0, _servers.Count)).Value.domain;
        }
        public static string getTrans(string value)
        {
            string lang = string.IsNullOrEmpty(Main.lang) ? Main._region : Main.cmd["lang"];
            if (!trans.ContainsKey(_langs[lang]))
                return trans["en-uk"][value];
            return trans[_langs[lang]][value];
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
