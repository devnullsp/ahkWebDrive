# AHKWebdriver API

Lo primero es crear una sessión. 

Al crear la sesión se abre un vetana del navegador nueva (esto puede tardar un poco). 

Todos los comandos afectan a la ventana "por defecto", o sea la actual. Podemos crear mas ventanas y activarlas cambiando la ventana actual para que las siguientes llamadas se ejecuten sobre la ventana elegida.

Una vez en la ventana podemos obtener cualquier elemento web, este elemento estará disponible mientras exista la session y la ventana que lo contenga no esté cerrada y aunque activemos otra ventana.

## new/delete Sesión

* new WDSession(location:="http://localhost:9515/", capabilities:=""): instancia una nueva sesión siendo location la dirección del Web Driver. opcionalmente se puede pasar un objeto con las capacidades que el driver pueda pedir.
* delete()

## Llamadas concernientes a la "ventana del navegador"

### Navegar
* __url(url)__: Cargar a una url nueva en la ventana actual. __url__: String conteniendo la dirección. 
* __getUrl()__: Deveulve la _url_ de la pagina actual.
* __getTitle()__: Obtiene el _título_ de la ventana actual.

### Crear, obtener ventans
* __newWindow(type)__: Añade una ventana de navegador nueva a la sesión. __type__: "tab" (por defecto) crea una nueva hoja. "window" crea una nueva ventana. tab/window dependerán de la implementación del driver. Devuelve un __hadle__ de ventana.
* __window(handle)__:  Activa una ventana de navegador. __handle__ es un valor devuelto por _getWidnowHandles_ o _newWindow_
* __getWindow()__: Obtiene el _handle_ de la ventana actual.
* __getWindowHandles()__: Devuelve un array (autohotkey) con todos los _handle_ de las ventanas de la sesión.
* __closeWindow()__: Cierra la ventana actual.

### Tamaño y posición
* __getWindowRect()__: El objeto rc.value devuelto contiene los atributos x,y,width y height. __x__,__y__ coordenadas del origen, __width__,__height__ ancho y alto de la ventana (en pixeles).
* __windowMaximize()/windowMinimize()/windowFullscreen()__: Maximiza, minimiza o pasa a pantalla completa la ventana actual.
* __windowRect(x:="", y:="", width:="", height:="")__: Asigna posición y/o tamaño a la ventana actual. __x__,__y__ coordenadas del origen, __width__,__height__ ancho y alto de la ventana (en pixelse).

### Historial
* __back()__: Carga la pagina anterior del historial.
* __forward()__: Carga la pagina siguiente del historial.
* __refresh()__: Refresca la ventana actual.

### Frames
* __frame(id:="")__: Activa un frame en la ventana actual. __id__ si es "" activa el frame top. si es un numero, activa dicho frame. En caso de que sea un Web Elemento activa dicho elemento (si es frame o iframe).
* __frameParent()__: Activa el frame padre del actual.

### Javascript
* __execute(script, args:="", sync:="sync")__: Ejecuta el cotenido de _script_ usnado un array de _args_ que luego estarán disponibles en el código como _arguments[0..n]_. El modo por defecto es _WDSession.sync_, aunque se puede ejecutar asyncronamente pasando como valor de sync _WDSession.async_.



* __getElementActive()__:
* __element(selector, value)__:
* __elements(selector, value)__:
* __getSource()__:
* __getAllCookies()__:
* __getCookie(name)__:
* __cookie(name,value,path:="",domain:="",secure:="",httpOnly:="",expiry:="")__:
* __delCookie(name)__:
* __delAllCookies()__:
* __getScreenshot()__:
* __alertDismiss()__:
* __alertAccept()__:
* __getAlertText()__:_