#include jxon.ahk

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
*/
msgbox % "input check: "   (e := wd.element(WDSession.XPath,"/html/body/p/input[2]")) "`n" (e="") " -> " e.ref "`n" wd.rc.raw
msgbox % "get selected (element): "   (f := e.getSelected())  "`n" e.rc.raw
msgbox % "get attribute (value): "   (f := e.getAttributed("name")) "`n" e.rc.raw


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

	;-- instance vars ---------------------------------
    sessionId := ""
    prefijo   := "http://localhost:9515/"
    rc        := ""
    
    __New(){
 	    local body := {}
        body.capabilities := {}
        this.rc := WSejecutar("POST", this.prefijo "session",jxon_Dump(body) )
        this.sessionId := this.rc.isError ? "" : this.rc.value.sessionId
        return  this
    }
    url(url){
        local body := {}
        body.url := url
        this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/url", jxon_Dump(body))
		return this.rc.isError
    }
	getUrl(){
		this.rc := WSejecutar("GET", this.prefijo "session/" this.sessionId "/url")
		return this.rc.value
	}
	back(){
		this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/back", "{}")
		return this.rc.isError
	}
	forward(){
		this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/forward", "{}")
		return this.rc.isError
	}
	refresh(){
		this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/refresh", "{}")
		return this.rc.isError
	}
    delete(){
        this.rc := WSejecutar("DELETE", this.prefijo "session/" this.sessionId)
		return this.rc.isError
    }
	getTitle(){
		this.rc := WSejecutar("GET", this.prefijo "session/" this.sessionId "/title")
		return this.rc.value
	}
	getWindow(){
		this.rc := WSejecutar("GET", this.prefijo "session/" this.sessionId "/window")
		return this.rc.value
	}
	window(handle){
        local body := {}
        body.handle := handle
        this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/window", jxon_Dump(body))
		return this.rc.isError
    }
	newWindow(type){
		local body := {}
        body.type := (type = "") ? "tab" : type
        this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/window/new", jxon_Dump(body))
		return this.rc.value.handle
	}
	closeWindow(){
    	this.rc := WSejecutar("DELETE", this.prefijo "session/" this.sessionId "/window")
		return this.rc.isError
    }	
	getWindowHandles(){
		this.rc := WSejecutar("GET", this.prefijo "session/" this.sessionId "/window/handles")
		return this.rc.value
	}
	windowMaximize(){
		this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/window/maximize", "{}")
		return this.rc.isError
	}
	windowMinimize(){
		this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/window/minimize", "{}")
		return this.rc.isError
	}
	windowFullscreen(){
		this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/window/fullscreen", "{}")
		return this.rc.isError
	}
	getWindowRect(){
		this.rc := WSejecutar("GET", this.prefijo "session/" this.sessionId "/window/rect")
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
		this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/window/rect", jxon_Dump(body))
		return this.rc.isError
	}
	frame(id:=""){
		local body := {}
		if(id!="")
			body.id := id
		this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/frame", jxon_Dump(body)) 
		return this.rc.isError
	}
	frameParent(){
		this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/frame/parent", "{}")
		return this.rc.isError
	}
	getElementActive(){
		this.rc := WSejecutar("GET", this.prefijo "session/" this.sessionId "/element/active")
		if(this.rc.isError) 
			return ""
		return new WDSession.WebElement(this.rc.value, this)
	}
	element(selector, value){
		local body := {using: selector, value: value }
		this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/element", jxon_Dump(body))
		if(this.rc.isError) 
			return ""
		return new WDSession.WebElement(this.rc.value, this)
	}
	elements(selector, value){
		local body := {using: selector, value: value }
		local list,i,k
		this.rc := WSejecutar("POST", this.prefijo "session/" this.sessionId "/elements", jxon_Dump(body))
		if(this.rc.isError) 
			return ""
		list:=[]
		loop % this.rc.value.Count()
			list.push(new WDSession.WebElement(this.rc.value[A_index], this))
		return list
	}

	class WebElement{
		ref        := ""
		objSession := ""
		rc 		   := ""
		__New(obj, objSession){
			this.ref 		:= obj["element-6066-11e4-a52e-4f735466cecf"]
			this.objSession := objSession
		}
		getSelected(){
			this.rc := WSejecutar("GET", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/selected")
			if(this.rc.isError) 
				return ""
			return this.rc.value
		}
		getAttribute(name){
			this.rc := WSejecutar("GET", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/attribute/" name)
			if(this.rc.isError) 
				return ""
			return this.rc.value
		}
	}

}

WSejecutar(metodo, url, cuerpo:=""){
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


dumpObj(obj, sep)
{
	static c
    for i,k in obj
    {
        c .= "`n" sep i ":"
        if(IsObject(k))
            dumpObj(k, sep "`t")
        else
            c .= k
    }
	return c
}
