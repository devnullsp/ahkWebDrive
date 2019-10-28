# AHKWebSession

> __IMPORTANT NOTES__

>__¡¡This is not a Selenium port!!__

>__¡¡I used a modified Jxon library (jxonMod.ahk)!!__

## What is this

Is a Autohotkey native web client protocol.

__Url API definition:__ https://w3c.github.io/webdriver

this V1.0 inlude all functions but no actions, im working in this api.

Rename maping between W3C api and AHKWebSession:

They are only two objects:

- __WDSession__ representing one connection to WebDriver driver, attributes and functions
- __WDSession.WDElement__ wraping one Web Element attributes and their functions

WDSession.WDElement are not require to construct explicity (i think).

The functions, defined by W3Cm, are organized by this two objects and the map is (in general):

- Functions called with GET use _getNameFunciton_
- Functions called with DELETE use _delNameFunction_
- Functions called with POST are not rename, use _nameFunction_
- Functions with 2 token (window, frame, etc) use _[prefix]NameToken1NameToken2_

## Using

First you need download one webdriver midleware for your browser (and version).
- Google Chorme: https://chromedriver.chromium.org/
- Mozilla: https://github.com/mozilla/geckodriver/releases
- IExplorer: https://github.com/SeleniumHQ/selenium/wiki/InternetExplorerDriver
- Edge: https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/#downloads

Run it. Read webdriver documentation to know what port its open and other run parameters if you need.

This sample show the minimun code need for get one connection. Webdriver its open in localhost and port 9515 (standard for Google Chrome WebDrive), finally you delete the session for disconnect.

```
#include AHKWebDriver.ahk

wd := new WDSession("http://localhost:9515")
if(wd.rc.isError){
    msgbox % "Error:" wd.rc.error " " wd.rc.message
    ExitApp
}
[... you code here ..]
wd.delete()
```

All time, when you execute one call to WDSession, they are one object storing all data to know what is doing:

__wd.rc__ its one object maping all data returning:

most important:
- __wd.rc.isError__: true/false if they are one 
error.
- __wd.rc.value__: response object

for debug or extend information:

- __wd.rc.status__: http status from webdriver.
- __wd.rc.isErrorWeb__: true/false if they are error communicating with webdriver.
- __wd.rc.raw__: raw data returning from webdriver.
- __wd.rc.json__: json from wd.rc.raw.
- __wd.rc.error__: if isError this is the error text.
- __wd.rc.message__: if isError this is the error message text.

One time you are connected and get one WDSession, you would use the api, for example click documentation link in autohotkey page:

```
; get Session
wd := new WDSession("http://localhost:9515")
; navigate to new site
wd.url("https://autohotkey.com")
; click over documentation
wd.element(WDSession.XPath,"//*[@id=""menu-0""]/div/div/div/div[3]/nav/div/ul/li[2]/a").click()
```

This demostrate the use of element object in javascript call
parameters:
```
; get Session
wd := new WDSession("http://localhost:9515")
; navigate to new site
wd.url("https://autohotkey.com")
; click over documentation
we := wd.element(WDSession.XPath,"//*[@id=""menu-0""]/div/div/div/div[3]/nav/div/ul/li[2]/a")
wd.execute("arguments[0].click()",[we])) 
```

One more, plus complex. Using an element object into other general object. This example move to Document page and show one alert (but not in this order ;) ).

```
; get Session
wd := new WDSession("http://localhost:9515")
; navigate to new site
wd.url("https://autohotkey.com")
; click over documentation
we := wd.element(WDSession.XPath,"//*[@id=""menu-0""]/div/div/div/div[3]/nav/div/ul/li[2]/a")
wd.execute("arguments[0].boton.click(); alert('arguments[0].datos')",[{datos:"Close me before continue!", boton: we}])
```

