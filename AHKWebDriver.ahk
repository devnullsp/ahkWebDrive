#include jxon.ahk
/*
procesaObj(a){
	for k,e in a
	{
		if(IsObject(e))
			if(e.HasKey(WDSession.WebElement.weID)){
				a[k]:=new WDSession.WebElement(e, "sesion")
			}else
				procesaObj(e)
	}
}

a:=["o1", {WDSession.WebElement.weID: "8888-13213-123-12313"}]
procesaObj(a)
for k,e in a
{
	if(e.uuid = WDSession.WebElement.weID){
		msgbox % "encontraodo we!!!" k  " " e.ref
	}
}
;---------------------------------------------------------------------
a:={valor: "o1"
			, obj: {WDSession.WebElement.weID: "2222-13213-123-12313"}
			, otr: {parm1: "hola"
			, parm2:{WDSession.WebElement.weID: "333333-13213-123-12313"}}}

procesaObj(a)

busca(a)

busca(a){
	for k,e in a
	{
		if(isobject(e))
			if(e.uuid = WDSession.WebElement.weID){
				msgbox % "encontraodo we!!!" k  " " e.ref
			}else
				busca(e)
	}
}

*/

fileread lv, %A_AppData%\..\Local\Google\Chrome\User Data\Last version

wd := new WDSession()
if(wd.rc.isError){
    msgbox % "Error:" wd.rc.error " " wd.rc.message
    ExitApp
}

/*
wd.url("https://autohotkey.com")
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
msgbox % "url: " (e:=wd.url("file:///C:/PRG/Selenium/test1.html")) "`n" e.rc.raw
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
*/
msgbox % "execute sync (multi, multi obj): "   (e := wd.execute("var r=confirm('mensaje'); return r;")) 
													. "`n=" wd.rc.value "`n" wd.rc.raw 

msgbox % "execute sync (multi, multi obj): "   (e := wd.execute("return {options: document.getElementsByTagName('option'), buttons: document.getElementsByTagName('button')}")) 
															. "`nobj=" wd.rc.value.ref "`n" wd.rc.raw 
msgbox % Jxon_Dump(wd.rc.value,,"`t")

msgbox % "execute async (multi, multi obj): "   (e := wd.execute("return arguments[2]({options: document.getElementsByTagName('option'), buttons: document.getElementsByTagName('button')}) ","", WDSession.Async)) 
															. "`nobj=" wd.rc.value.ref "`n" wd.rc.raw 
msgbox % Jxon_Dump(wd.rc.value,,"`t")


;msgbox % "execute async (obj): "   (e := wd.execute("return document","", WDSession.Async)) 
															. "`nobj=" wd.rc.value.ref "`n" wd.rc.raw 
;msgbox % Jxon_Dump(wd.rc.value)															

msgbox Delete session
wd.delete()
ExitAPP

;Este objeto corresponde a la sesion.
class WDSession{
	;-- Selectors -------------------------------------
	static CSS				:= "css selector"
	static LinkText 		:= "link text"
	static PartialLinkTExt  := "partial link text"
	static TagName			:= "tag name"
	static XPath			:= "xpath"
	static keys := {}
		keys.Unidentified 	:= chr(0xE000)
		keys.Cancel 		:= chr(0xE001)
		keys.Help			:= chr(0xE002)
		keys.Backspace 		:= chr(0xE003)
		keys.Tab 			:= chr(0xE004)
		keys.Clear 			:= chr(0xE005)
		keys.Return 		:= chr(0xE006)
		keys.Enter 			:= chr(0xE007)
		keys.Shift			:= chr(0xE008)
		keys.Control 		:= chr(0xE009)
		keys.Alt 			:= chr(0xE00A)
		keys.Pause 			:= chr(0xE00B)
		keys.Escape 		:= chr(0xE00C)
		keys.PageUp 		:= chr(0xE00E)
		keys.PageDown 		:= chr(0xE00F)
		keys.End 			:= chr(0xE010)
		keys.Home 			:= chr(0xE011)
		keys.ArrowLeft 		:= chr(0xE012)
		keys.ArrowUp 		:= chr(0xE013)
		keys.ArrowRight 	:= chr(0xE014)
		keys.ArrowDown 		:= chr(0xE015)
		keys.Insert 		:= chr(0xE016)
		keys.Delete 		:= chr(0xE017)
	static Async := "async"
	static Sync  := "sync"

	;-- instance vars ---------------------------------
    sessionId := ""
    prefijo   := "http://localhost:9515/"
    rc        := ""
    __New(){
 	    local body := {}
        body.capabilities := {}
        this.rc := WDSession.__ws("POST", this.prefijo "session",jxon_Dump(body) )
        this.sessionId := this.rc.isError ? "" : this.rc.value.sessionId
        return  this
    }
    url(url){
        local body := {}
        body.url := url
        this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/url", jxon_Dump(body))
		return this.rc.isError
    }
	getUrl(){
		this.rc := WDSession.__ws("GET", this.prefijo "session/" this.sessionId "/url")
		return this.rc.value
	}
	back(){
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/back", "{}")
		return this.rc.isError
	}
	forward(){
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/forward", "{}")
		return this.rc.isError
	}
	refresh(){
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/refresh", "{}")
		return this.rc.isError
	}
    delete(){
        this.rc := WDSession.__ws("DELETE", this.prefijo "session/" this.sessionId)
		return this.rc.isError
    }
	getTitle(){
		this.rc := WDSession.__ws("GET", this.prefijo "session/" this.sessionId "/title")
		return this.rc.value
	}
	getWindow(){
		this.rc := WDSession.__ws("GET", this.prefijo "session/" this.sessionId "/window")
		return this.rc.value
	}
	window(handle){
        local body := {}
        body.handle := handle
        this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/window", jxon_Dump(body))
		return this.rc.isError
    }
	newWindow(type){
		local body := {}
        body.type := (type = "") ? "tab" : type
        this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/window/new", jxon_Dump(body))
		return this.rc.value.handle
	}
	closeWindow(){
    	this.rc := WDSession.__ws("DELETE", this.prefijo "session/" this.sessionId "/window")
		return this.rc.isError
    }	
	getWindowHandles(){
		this.rc := WDSession.__ws("GET", this.prefijo "session/" this.sessionId "/window/handles")
		return this.rc.value
	}
	windowMaximize(){
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/window/maximize", "{}")
		return this.rc.isError
	}
	windowMinimize(){
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/window/minimize", "{}")
		return this.rc.isError
	}
	windowFullscreen(){
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/window/fullscreen", "{}")
		return this.rc.isError
	}
	getWindowRect(){
		this.rc := WDSession.__ws("GET", this.prefijo "session/" this.sessionId "/window/rect")
		return this.rc.value
	}
	windowRect(x:="", y:="", width:="", height:=""){
		local body := {}
		if(IsObject(x))
			body := x
		else{
			if(x!="")
				body.x      := x
			if(y!="")
				body.y      := y
			if(width!="")
				body.width  := width
			if(height!="")
				body.height := height
		}
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/window/rect", jxon_Dump(body))
		return this.rc.isError
	}
	frame(id:=""){
		local body := {}
		if(id!="")
			body.id := id
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/frame", jxon_Dump(body)) 
		return this.rc.isError
	}
	frameParent(){
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/frame/parent", "{}")
		return this.rc.isError
	}
	getElementActive(){
		this.rc := WDSession.__ws("GET", this.prefijo "session/" this.sessionId "/element/active")
		if(this.rc.isError) 
			return ""
		return new WDSession.WebElement(this.rc.value, this)
	}
	element(selector, value){
		local body := {using: selector, value: value }
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/element", jxon_Dump(body))
		if(this.rc.isError) 
			return ""
		return new WDSession.WebElement(this.rc.value, this)
	}
	elements(selector, value){
		local body := {using: selector, value: value }
		local list,i,k
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/elements", jxon_Dump(body))
		if(this.rc.isError) 
			return ""
		list:=[]
		loop % this.rc.value.Count()
			list.push(new WDSession.WebElement(this.rc.value[A_index], this))
		return list
	}
	getSource(){
		this.rc := WDSession.__ws("GET", this.prefijo "session/" this.sessionId "/source")
		if(this.rc.isError) 
			return ""
		return this.rc.value
	}
	execute(script, args:="", sync:="sync"){
		local body := {}
		for x in args
			if(IsObject(args[x]))
				if(args[x].uuid = WDSession.WebElement.weID)
					args[x] := {WDSession.WebElement.weID: args[x].ref}
		body.script := script
		body.args:=(args="" || args=[]) ? ["default","default"] : args
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/execute/" sync, jxon_Dump(body)) 
		if(isObject(this.rc.value))
			if(this.rc.value.HasKey(WDSession.WebElement.weID))
					this.rc.value := new WDSession.WebElement(obj, this.sessionId)
			else
				this.__translateObj(this.rc.value)
		return this.rc.isError
	}
	__translateObj(obj){
		local key, value
		for key, value in obj
		{
			if(IsObject(value))
				if(value.hasKey(WDSession.WebElement.weID)){
					obj[key]:=new WDSession.WebElement(value, this.sessionId)
				}else
					this.__translateObj(value)
		}
	}


	;..............................................................................................................
	class WebElement{
		static weID := "element-6066-11e4-a52e-4f735466cecf"
		uuid	   := WDSession.WebElement.weId
		ref        := ""
		objSession := ""
		rc 		   := ""
		__New(obj, objSession){
			this.ref 		:= obj[WDSession.WebElement.weID]
			this.objSession := objSession
		}
		getSelected(){
			this.rc := WDSession.__ws("GET", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/selected")
			if(this.rc.isError) 
				return ""
			return this.rc.value
		}
		getAttribute(name){
			this.rc := WDSession.__ws("GET", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/attribute/" name)
			if(this.rc.isError) 
				return ""
			return this.rc.value
		}
		getProperty(name){
			this.rc := WDSession.__ws("GET", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/property/" name)
			if(this.rc.isError) 
				return ""
			return this.rc.value
		}
		getCSS(propertyName){
			this.rc := WDSession.__ws("GET", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/css/" propertyName)
			if(this.rc.isError) 
				return ""
			return this.rc.value
		}
		getText(){
			this.rc := WDSession.__ws("GET", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/text")
			if(this.rc.isError) 
				return ""
			return this.rc.value
		}
		getName(){
			this.rc := WDSession.__ws("GET", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/name")
			if(this.rc.isError) 
				return ""
			return this.rc.value
		}
		getRect(){
			this.rc := WDSession.__ws("GET", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/rect")
			if(this.rc.isError) 
				return ""
			return this.rc.value
		}
		getEnabled(){
			this.rc := WDSession.__ws("GET", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/enabled")
			if(this.rc.isError) 
				return ""
			return this.rc.value
		} 
		click(){
			this.rc := WDSession.__ws("POST", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/click", "{}")
			return this.rc.isError
		}
		clear(){
			this.rc := WDSession.__ws("POST", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/clear", "{}")
			return this.rc.isError
		}
		value(keys){
			this.rc := WDSession.__ws("POST", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/value", jxon_Dump({text: keys}))
			return this.rc.isError
		}
		getScreenshot(){
			this.rc := WDSession.__ws("GET", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/screenshot")
			if(this.rc.isError) 
				return ""
			return this.rc.value
		}
	}
	__ws(metodo, url, cuerpo:=""){
		static WS_SERVIDOR := ComObjCreate("Msxml2.XMLHTTP")
		local rc:={}
		WS_SERVIDOR.Open(metodo,url, false)
		WS_SERVIDOR.setRequestHeader("Content-Type","application/json; charset=UTF-8")
		WS_SERVIDOR.Send(cuerpo)
		rc.status      := WS_SERVIDOR.Status
		rc.isErrorWeb  := (WS_SERVIDOR.Status < 200 or WS_SERVIDOR.Status > 299)
		rc.raw         := WS_SERVIDOR.ResponseText
		rc.json        := ""
		rc.isError     :=  rc.isErrorWeb
		if(!rc.isErrorWeb){
			rc.json    := jxon_Load(rc.raw)
			rc.value   := rc.json.value
			rc.isError := rc.value.hasKey("error")
			if(rc.isError){
				rc.error := rc.value.error
				rc.message := rc.value.message
			}
		}
		return rc
	}
}
/*
{"value":
    {
        "capabilities":{
            "acceptInsecureCerts":false,
            "browserName":"chrome",
            "browserVersion":"77.0.3865.120",
            "chrome":{"chromedriverVersion":"77.0.3865.40 (f484704e052e0b556f8030b65b953dce96503217-refs/branch-heads/3865@{#442})",
            "userDataDir":"C:\\Users\\devnu\\AppData\\Local\\Temp\\scoped_dir13836_1519564804"},
            "goog:chromeOptions":{"debuggerAddress":"localhost:54290"},
            "networkConnectionEnabled":false,
            "pageLoadStrategy":"normal",
            "platformName":"windows nt",
            "proxy":{},
            "setWindowRect":true,
            "strictFileInteractability":false,
            "timeouts":{"implicit":0,"pageLoad":300000,"script":30000},
            "unhandledPromptBehavior":"dismiss and notify"
        },
            "sessionId":"bf39f8f8ea5174cb0c6d928039bb0981"
    }
}
*/
