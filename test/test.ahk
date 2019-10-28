#noenv
#include AHKWebDriver.ahk

fileread lv, %A_AppData%\..\Local\Google\Chrome\User Data\Last version

wd := new WDSession()
if(wd.rc.isError){
    msgbox % "Error:" wd.rc.error " " wd.rc.message
    ExitApp
}


; wd.url("https://autohotkey.com")
; wd.element(WDSession.XPath,"//*[@id=""menu-0""]/div/div/div/div[3]/nav/div/ul/li[2]/a").click()


;wd.url("https://autohotkey.com")
; click over documentation
; we := wd.element(WDSession.XPath,"//*[@id=""menu-0""]/div/div/div/div[3]/nav/div/ul/li[2]/a")
; msgbox % wd.rc.raw
; wd.execute("arguments[0].click();",[ we ])
;:wd.execute("arguments[0].boton.click(); alert('arguments[0].datos')",[{datos:"Closeme before continue!", boton: we}])

wd.url("file:///" A_ScriptDir "/test1.html")
we := wd.element(WDSession.XPath,"//*[@id=""botonMsg""]")
wd.execute("alerta(arguments[0].datos,arguments[0].boton)",[{datos:"Closeme before continue!", boton: we}])
msgbox % wd.isError " " wd.error " " wd.message "`n" wd.rc.raw

 msgbox pause

/*
msgbox % "get url: " 			wd.getUrl()
msgbox % "back: " 				wd.back()
msgbox % "forward: " 			wd.forward() 
msgbox % "refresh: " 			wd.refresh() 
msgbox % "get title: " 			wd.getTitle() 
msgbox % "get Window: " 		(h1:=wd.getWindow())
msgbox % "new window: "			h2:=wd.newWindow("tab")
msgbox % "window 2: " 			wd.window(h2)
msgbox % "url : "     			wd.url("https://autohotkey.com")
msgbox % "window 1: "			wd.window(h1)
msgbox % "window 2: " 			wd.window(h2)
msgbox % "get window handles: " wd.getWindowHandles() "`n" wd.rc.value.length() "`n"  wd.rc.value[2]
msgbox % "windowMaximize: " 	wd.windowMaximize()
msgbox % "windowMinimize: " 	wd.windowMinimize()
msgbox % "windowFullscreen: " 	wd.windowFullscreen()
msgbox % "windowRestore: "	 	wd.windowRect({})
msgbox % "window close: "		wd.closeWindow()
msgbox % "window 1: "			wd.window(h1)
msgbox % "Window Rect: "		wd.windowRect({x:100, y:100})
msgbox % "get window rect: "   (rect:=wd.getWindowRect()) "`n" "x: " rect.x " y: " rect.y " width: " rect.width " height: " rect.height
msgbox % "getElementActive: "   (e := wd.getElementActive()) "`n" e.ref " -> " e.sessionId "`n" wd.rc.raw
msgbox % "element: "   (e := wd.element(WDSession.CSS,"#downloadLink")) "`n" (e="") " -> " e.ref "`n" wd.rc.raw
msgbox % "elements: "   (e := wd.elements(WDSession.TagName,"Link")) "`n" e.Count() " -> " e[1].ref "`n" wd.rc.raw
*/
e:=""
f:=""
;msgbox % "url: " (e:=wd.url("file:///C:/PRG/Selenium/test1.html")) "`n" e.rc.raw
/*
msgbox % "element option: "   (e := wd.element(WDSession.XPath,"/html/body/select/option[1]")) "`n" (e="") " -> " e.ref "`n" wd.rc.raw
msgbox % "get selected (element): "   (f := e.getSelected()) "`n" f "`n" e.rc.raw
msgbox % "input check: "   					(e := wd.element(WDSession.XPath,"/html/body/p/input[2]")) "`n" (e="") " -> " e.ref "`n" wd.rc.raw
msgbox % "get selected (element): " 		(f := e.getSelected())  "`n" e.rc.raw
msgbox % "get attribute (value): "  		(f := e.getAttribute("name")) "`n" e.rc.raw
msgbox % "get attribute (esteNoExiste): "   (f := e.getAttribute("esteNoExiste")) "`n" e.rc.raw
msgbox % "get property (value): "   		(f := e.getProperty("name")) "`n" e.rc.raw
msgbox % "get property (esteNoExiste): "   	(f := e.getProperty("esteNoExiste")) "`n" e.rc.raw
msgbox % "get CSS (color): "   				(f := e.getCSS("color")) "`n" e.rc.raw
msgbox % "get text: "	  	 				(f := e.getText()) "`n" e.rc.raw
msgbox % "element xpath id=total: "  			(e := wd.element(WDSession.XPath,"//*[@id='total']")) "`n" (e="") " -> " e.ref "`n" wd.rc.raw
msgbox % "get text: "	  	 				(f := e.getText()) "`n" e.rc.raw
msgbox % "element xpath id=opc1: "  			(e := wd.element(WDSession.XPath,"//*[@id='opc1']")) "`n" (e="") " -> " e.ref "`n" wd.rc.raw
msgbox % "get text: "	  	 				(f := e.getText()) "`n" e.rc.raw
msgbox % "element xpath id=total: "  			(e := wd.element(WDSession.XPath,"//*[@id='total']")) "`n" (e="") " -> " e.ref "`n" wd.rc.raw
msgbox % "get name: "		  	 				(f := e.getName()) "`n" e.rc.raw
msgbox % "get rect: "	  		 				(f := e.getRect()) "`n"  f.height " " f.width " " f.x " " f.y "`n" e.rc.raw
msgbox % "get enabled: "	  	 				(f := e.getEnabled())  "`n" e.rc.raw
msgbox % "element xpath id=boton: "  			(e := wd.element(WDSession.XPath,"//*[@id='boton']")) "`n" (e="") " -> " e.ref "`n" wd.rc.raw
msgbox % "element click: "  					(f := e.click()) "`n" e.rc.raw
msgbox % "element xpath id=borrar: "  			(e := wd.element(WDSession.XPath,"//*[@id='borrar']")) "`n" (e="") " -> " e.ref "`n" wd.rc.raw
msgbox % "get attribute (innerHTML): "  		(f := e.getAttribute("innerHTML")) "`n" e.rc.raw
msgbox % "element clear: "  					(f := e.clear()) "`n" e.rc.raw
msgbox % "element xpath id=campo: "  			(e := wd.element(WDSession.XPath,"//*[@id='campo']")) "`n" (e="") " -> " e.ref "`n" wd.rc.raw
msgbox % "get attribute (innerHTML): "  		(f := e.getAttribute("innerHTML")) "`n" e.rc.raw
msgbox % "element clear: "  					(f := e.clear()) "`n" e.rc.raw
msgbox % "element click (foco): "  				(f := e.click()) "`n" e.rc.raw
msgbox % "element value poniendo texto: " 		(f := e.value("prueba"  "ñ"  WDSession.keys.Backspace chr(0x26d4) WDSession.keys.ArrowLeft " ")) "`n" e.rc.raw
msgbox % "element screenshot: "  				(f := e.getScreenshot()) "`n" e.rc.raw
Clipboard := f
msgbox % "element value Ctrl+izq: " 			(f := e.value(WDSession.keys.Control WDSession.keys.ArrowLeft)) "`n" e.rc.raw
msgbox % "element value Ctrl+Shif+end: " 		(f := e.value(WDSession.keys.Control WDSession.keys.Shift WDSession.keys.End)) "`n" e.rc.raw
msgbox % "element value Ctrl+Shif+end: " 		(f := e.value(WDSession.keys.End)) "`n" e.rc.raw
msgbox % "element value Ctrl+Shif+end: " 		(f := e.value(WDSession.keys.Backspace)) "`n" e.rc.raw
msgbox % "element value Ctrl+z: "  				(f := e.value(WDSession.keys.Control "Z")) "`n" e.rc.raw
msgbox % "get Source: "  		(f := wd.getSource()) "`n" wd.rc.raw
msgbox % "execute sync (no retorno): "  (e := wd.executeSync("alerta(arguments[0])","")) "`n" wd.rc.raw
msgbox % "execute sync (ret. elem): "   (e := wd.executeSync("return document.getElementById('total')","")) 
															. "`nobj=" wd.rc.value.ref "`n" wd.rc.raw
msgbox % "execute sync (ret. string): " (e := wd.executeSync("return 'datos'","")) "`n" wd.rc.value "`n" wd.rc.raw
msgbox % "execute sync (ret. numero): " (e := wd.executeSync("return 5","")) "`n" wd.rc.value "`n" wd.rc.raw
msgbox % "execute sync (ret. obj): "    (e := wd.executeSync("return {nombre: 'yo', ape: 'tu'}","")) 
															. "`n" wd.rc.value.nombre " " wd.rc.value.ape "`n" wd.rc.raw
ctrl:=wd.element(WDSession.XPath,"//*[@id='boton']")														
msgbox % "execute sync args: "  
			. ( e := wd.executeSync("alerta(arguments[0]+' '+arguments[1]+' '+arguments[2].obj); arguments[3].click() "
									, ["parm1", 4, {obj: "valor"}, ctrl] ) ) 
									;, ["parm1", 4, {obj: "valor"}, { WDSession.WebElement.weID: ctrl.ref}] ) ) 
			. "`n" wd.rc.raw
msgbox % "execute sync (multi elem): "   (e := wd.executeSync("return document.getElementsByTagName('option')","")) 
															. "`nobj=" wd.rc.value.ref "`n" wd.rc.raw 
msgbox % dumpObj(wd.rc.value,"`t")															
msgbox % "execute sync (multi, multi obj): "   (e := wd.execute("var r=confirm('mensaje'); return r;")) 
													. "`n=" wd.rc.value "`n" wd.rc.raw 

msgbox % "execute sync (multi, multi obj): "   (e := wd.execute("return {options: document.getElementsByTagName('option'), buttons: document.getElementsByTagName('button')}")) 
															. "`nobj=" wd.rc.value.ref "`n" wd.rc.raw 
msgbox % Jxon_Dump(wd.rc.value,,"`t")

msgbox % "execute async (multi, multi obj): "   (e := wd.execute("return arguments[2]({options: document.getElementsByTagName('option'), buttons: document.getElementsByTagName('button')}) ","", WDSession.Async)) 
															. "`nobj=" wd.rc.value.ref "`n" wd.rc.raw 
msgbox % Jxon_Dump(wd.rc.value,,"`t")
msgbox % "execute async (obj): "   (e := wd.execute("return document","", WDSession.Async)) 
															. "`nobj=" wd.rc.value.ref "`n" wd.rc.raw 
msgbox % Jxon_Dump(wd.rc.value)															
msgbox % "execute: sin args "		(e := wd.execute("alert('hola')")) "`n" wd.rc.raw 
msgbox % "execute: 1 arg " 			(e := wd.execute("alert(arguments[0])",["valor"],WDSession.Sync)) "`n" wd.rc.raw 
msgbox % "execute: async 0 args " 	(e := wd.execute("alert('esto');arguments[0]();","",WDSession.Async)) "`n" wd.rc.raw 
msgbox % "url: " (e:=wd.url("https://stackoverflow.com")) "`n" wd.rc.raw
msgbox % "getCookie: _gat " 	(e := wd.getCookie("_gat")) "`n" wd.rc.value.domain "`n" wd.rc.raw
msgbox % "cookie nombre: " 	(e := wd.cookie("nombre","gonzalo")) "`n" wd.rc.value.domain "`n" wd.rc.raw
msgbox % "getCookie nombre: " 	(e := wd.getCookie("nombre")) "`n" wd.rc.value.domain "`n" wd.rc.raw
msgbox % "delCookie nombre: " 	(e := wd.delCookie("nombre")) "`n" wd.rc.value.domain "`n" wd.rc.raw
msgbox % "getCookie nombre: " 	(e := wd.getCookie("nombre")) "`n" wd.rc.value.domain "`n" wd.rc.raw
msgbox % "getAllCookies: " 	(e := wd.getAllCookies()) "`n" wd.rc.value.count() "`n" wd.rc.raw
msgbox % "delAllCookies nombre: " 	(e := wd.delAllCookies()) "`n" wd.rc.isError "`n" wd.rc.raw
msgbox % "getAllCookies: " 	(e := wd.getAllCookies()) "`n" wd.rc.value.count() "`n" wd.rc.raw
msgbox % "getScreenShot: " 	(e := wd.getScreenShot())  "`n" wd.rc.raw
clipboard:=e
 msgbox % "execute alert"		(e := wd.execute("alert('hola 1')")) "`n" wd.rc.raw 
 msgbox % "alertAccept: "		(e := wd.alertAccept())  "`n" wd.rc.raw
 msgbox % "execute alert"		(e := wd.execute("alert('hola 2')")) "`n" wd.rc.raw 
 msgbox % "getAlertText: " 		(e := wd.getAlertText())  "`n" wd.rc.raw
 msgbox % "alertDismiss: "		(e := wd.alertDismiss())  "`n" wd.rc.raw
msgbox % "execute alert"		(e := wd.execute("prompt('pulse algo','valor')")) "`n" wd.rc.raw 
msgbox % "alertText: "			(e := wd.alertText("texto cambiado"))  "`n" wd.rc.raw
msgbox % "getAlertText: " 		(e := wd.getAlertText())  "`n" wd.rc.raw
msgbox % "url: " (e:=wd.url("file:///C:/PRG/Selenium/test1.html")) "`n" e.rc.raw
msgbox % "get window handles 1: " wd.getWindowHandles() "`n" wd.rc.value.count() "`n"  wd.rc.raw
msgbox % "get window handles 2: " wd.getWindowHandles() "`n" wd.rc.value.count() "`n"  wd.rc.raw
msgbox % "get window handles 3: " wd.getWindowHandles() "`n" wd.rc.value.count() "`n"  wd.rc.raw
msgbox % "url: " (e:=wd.url("file:///C:/PRG/Selenium/test1.html")) "`n" e.rc.raw
msgbox % "get body: "  (e := wd.element(WDSession.TagName,"body")) "`n" wd.rc.raw
msgbox % "get body (innerHTML): " (f := e.getProperty("innerHTML")) "`n" e.rc.raw
msgbox % "frame xpath: " (e := wd.element(WDSession.XPath,"//*[@id=""frame1""]")) "`n" wd.rc.raw
msgbox % "frame 1: "  	 (e := wd.frame(e)) "`n" wd.rc.raw
msgbox % "get body: "    (e := wd.element(WDSession.TagName,"body")) "`n" wd.rc.raw
msgbox % "get body (innerHTML): "  (f := e.getProperty("innerHTML")) "`n" e.rc.raw
msgbox % "frame parent: "  	 (e := wd.frameParent()) "`n" wd.rc.raw
msgbox % "get body: "  (e := wd.element(WDSession.TagName,"body")) "`n" wd.rc.raw
msgbox % "get body (innerHTML): " (f := e.getProperty("innerHTML")) "`n" e.rc.raw
msgbox % "url: " (e:=wd.url("file:///" A_ScriptDir "/test1.html")) "`n" e.rc.raw
msgbox % "frame 1: "  	 (e := wd.frame(0)) "`n" wd.rc.raw
msgbox % "get body: "    (e := wd.element(WDSession.TagName,"body")) "`n" wd.rc.raw
msgbox % "get body (innerHTML): "  (f := e.getProperty("innerHTML")) "`n" e.rc.raw
*/

msgbox Delete session
wd.delete()
ExitAPP
