tso windows portable client

### 1. Initial start.
Elements on the start screen: 
'Select' listbox - the list of available game worlds.

'login/password' - the input boxes for login/password typing

'Start' - the button for start connection

'Ready' - the info line with current status of client. To start the connection, wait for the message shown on the screen - можно играть'. If the message is different, the client will not start.

![start_win](https://user-images.githubusercontent.com/76757249/177488543-8ba0fb9e-eaaf-491c-9bdf-a5a3a5de53f2.png)

After starting the client, a window will appear asking if you want to use UbiCollect for collectible item highlights. Only click **Yes** (left button) if Ubicollect is running. If you do not know what it is, press **No** (right button).  
![ubcollect_screen](https://user-images.githubusercontent.com/76757249/177491934-e89a5901-5a01-4e93-bd73-10c5a03e0010.png)


### 2. After start.
Below are some connection error screens.
_Wrong login/password_

![logpass](https://user-images.githubusercontent.com/76757249/177497246-8e4c0589-eb2a-48d5-b7cb-bb20d61c087a.png)

This error can assign when 2FA is enabled.  Client does not support 2FA, you need to switch off it.

_Empty response_ 

![image](https://user-images.githubusercontent.com/76757249/177489927-4445f5d5-e57c-49ef-88a6-97a83df91794.png)

or 
_5 unsuccessful authorization attempts_

![image](https://user-images.githubusercontent.com/76757249/177493405-af398920-a1b1-4f15-95ca-56ca9d5197b0.png)

The reasons for these errors can be different: weak connection, maintenance work, temporary problems with the game servers etc. Try again after a few minutes.

### 3. Startup parameters 
You can use some parameters below for client shortcut. 

`client.exe --debug` - creates a debug.txt file with an error report in case of failure 

`client.exe --lang [de|us|en|fr|ru|pl|es2|es|nl|cz|pt|it|el|ro]` - changes the game interface language. 
For ex.,  `client.exe --lang de` allows to play with German on EU server

`client.exe --skip ` - allows to skip up to date checking of client.swf (this parameter will be useful in any problems with sirris.tsomaps.com). **Warning!** To update client.swf you will need to remove it after maintenance.

`client.exe --autologin ` - allows to start client with login/password from setting.dat file automatically without Ubicollect question screen and without collectible item highlights. 

`client.exe --autologin --collect` - same as the previous one, but with collectible item highlights. **Warning!**  UbiCollect should be running!

`client.exe --window [fullscreen|maximized]` - start game fullscreen or in maximized window

Read more at https://settlersonlinewiki.eu/en/playing-on-unity-by-the-client/


 