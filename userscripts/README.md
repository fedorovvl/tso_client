# Custom user scripts

## Basics
Write your own script, add it to info.json and make pull request if you want to add it to default bundle

After code review it will be there :)

## Advanced
If you want to dynamically provide script info to the script manager (instead of `info.json`) add following code to your own custom script:

```js
    customScripts['user_myscript.js'] = { // <- script fliename 
        'name': 'My script', // <- script basic title
        'author': 'Your Name', // <- It's you
        'title': 'My awesome custom script', // <- short description
        'description': 'This script provides additional functionality to the TSO standalone client', // <- additional description for tooltip
        'url': 'https://github.com/fedorovvl/tso_client' // <- your custom URL
    };
```
