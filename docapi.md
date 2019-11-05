# AHKWebdriver API

Lo primero es crear una sessión. 

Al crear la sesión se abre un vetana del navegador nueva (esto puede tardar un poco). 

Todos los comandos afectan a la ventana "por defecto", o sea la actual. Podemos crear mas ventanas y activarlas cambiando la ventana actual para que las siguientes llamadas se ejecuten sobre la ventana elegida.

Una vez en la ventana podemos obtener cualquier elemento web, este elemento estará disponible mientras exista la session y la ventana que lo contenga no esté cerrada y aunque activemos otra ventana.

## new/delete Sesión

* new WDSession(location:="http://localhost:9515/", capabilities:=""): instancia una nueva sesión siendo location la dirección del Web Driver. opcionalmente se puede pasar un objeto con las capacidades que el driver pueda pedir.

* delete()

## Llamadas cuyo objetivo es la ventana actual

### Acciones
* url(url) navegar usando url a una pagina
* back()
* forward()
* refresh()
* newWindow(type)
* closeWindow()

* getUrl() obtener la url de la pagina actual
getTitle()
	getWindow()
	window(handle)
	getWindowHandles()
	windowMaximize()
	windowMinimize()
	windowFullscreen()
	getWindowRect()
	windowRect(x:="", y:="", width:="", height:="")
	frame(id:="")
	frameParent()
	getElementActive()
	element(selector, value)
	elements(selector, value)
	getSource()
	execute(script, args:="", sync:="sync")
	getAllCookies()
	getCookie(name)
	cookie(name,value,path:="",domain:="",secure:="",httpOnly:="",expiry:="")
	delCookie(name)
	delAllCookies()
	getScreenshot()
	alertDismiss()
	alertAccept()
	getAlertText()