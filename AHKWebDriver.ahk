#noenv
#include json.ahk

class WDSession{
	;-- Selectors -------------------------------------
	static CSS				:= "css selector"
	static LinkText 		:= "link text"
	static PartialLinkTExt  := "partial link text"
	static TagName			:= "tag name"
	static XPath			:= "xpath"
	;-- Key codes (UPV) -------------------------------
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
	;-- Sync modes -------------------------------
	static Async := "async"
	static Sync  := "sync"

	;-- instance vars ---------------------------------
    sessionId := ""
    prefijo   := ""
    rc        := ""
    __New(location:="http://localhost:9515/", capabilities:=""){
 	    local body := {}
		 if(capabilities != ""){
        	body.capabilities := capabilities
			body := JSON.Stringify(body)
		 }
		else 
			body := "{""capabilities"":{}}"
		this.prefijo:=location
        this.rc := WDSession.__ws("POST", this.prefijo "session",body )
        this.sessionId := this.rc.isError ? "" : this.rc.value.sessionId
        return  this
    }
    url(url){
        local body := {}
        body.url := url
        this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/url", JSON.Stringify(body))
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
        this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/window", JSON.Stringify(body))
		return this.rc.isError
    }
	newWindow(type){
		local body := {}
        body.type := (type = "") ? "tab" : type
        this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/window/new", JSON.Stringify(body))
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
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/window/rect", JSON.Stringify(body))
		return this.rc.isError
	}
	frame(id:=""){
		local body := "{""id"": "
		if(id=""){
			body .= "null}"
		}else if(RegExMatch(id,"^\d+$")){
				body .= id "}"
			  }else	if(isObject(id) && id.uuid = WDSession.WDElement.weID){
						body .= "{""" WDSession.WDElement.weID """: """ id.ref """}}"
					}
					else
						body .= """" id """}"
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/frame", body) 
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
		return new WDSession.WDElement(this.rc.value, this)
	}
	element(selector, value){
		local body := {using: selector, value: value }
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/element", JSON.Stringify(body))
		if(this.rc.isError) 
			return ""
		return new WDSession.WDElement(this.rc.value, this)
	}
	elements(selector, value){
		local body := {using: selector, value: value }
		local list,i,k
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/elements", JSON.Stringify(body))
		if(this.rc.isError) 
			return ""
		list:=[]
		loop % this.rc.value.Count()
			list.push(new WDSession.WDElement(this.rc.value[A_index], this))
		return list
	}
	getSource(){
		this.rc := WDSession.__ws("GET", this.prefijo "session/" this.sessionId "/source")
		if(this.rc.isError) 
			return ""
		return this.rc.value
	}
	execute(script, args:="", sync:="sync"){
		local body:={}
		local x,i
		body.script := script
		if(args="") 
			args:=[]
		else
			for x in args
				if(IsObject(args[x])){
					if(args[x].uuid = WDSession.WDElement.weID)
						args[x] := {WDSession.WDElement.weID: args[x].ref}
					else
						this.__dumpObj(args[x])				
				}
		body.args:=args
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/execute/" sync, JSON.Stringify(body)) 
		if(isObject(this.rc.value))
			if(this.rc.value.HasKey(WDSession.WDElement.weID))
				this.rc.value := new WDSession.WDElement(obj, this)
			else
				this.__translateObj(this.rc.value)
		return this.rc.isError
	}
	getAllCookies(){
		this.rc := WDSession.__ws("GET", this.prefijo "session/" this.sessionId "/cookie")
		if(this.rc.isError) 
			return ""
		return new WDSession.WDElement(this.rc.value, this)
	}
	getCookie(name){
		this.rc := WDSession.__ws("GET", this.prefijo "session/" this.sessionId "/cookie/" name)
		if(this.rc.isError) 
			return ""
		return new WDSession.WDElement(this.rc.value, this)
	}
	cookie(name,value,path:="",domain:="",secure:="",httpOnly:="",expiry:=""){
		local body:={}
		cookieObj:={} 
		cookieObj.name:=name
		cookieObj.value:=value
		if(isObject(path)){
			for k,v in path
				cookieObj[k]:=v
		}else{
			if(path!="") 
				cookieObj.path:=path
			if(domain!="") 
				cookieObj.domain:=domain
			if(secure!="") 
				cookieObj.secure:=secure
			if(httpOnly!="") 
				cookieObj.httpOnly:=httpOnly
			if(expiry!="") 
				cookieObj.expiry:=expiry
		}
		body.cookie:=cookieObj
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/cookie", JSON.Stringify(body))
		return this.rc.isError
	}
	delCookie(name){
		this.rc := WDSession.__ws("DELETE", this.prefijo "session/" this.sessionId "/cookie/" name)
		return this.rc.isError
	}
	delAllCookies(){
		this.rc := WDSession.__ws("DELETE", this.prefijo "session/" this.sessionId "/cookie")
		return this.rc.isError
	}
	getScreenshot(){
		this.rc := WDSession.__ws("GET", this.prefijo "session/" this.sessionId "/screenshot")
		if(this.rc.isError) 
			return ""
		return this.rc.value
	}
	alertDismiss(){
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/alert/dismiss", "{}")
		return this.rc.isError
	}
	alertAccept(){
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/alert/accept", "{}")
		return this.rc.isError
	}
	getAlertText(){
		this.rc := WDSession.__ws("GET", this.prefijo "session/" this.sessionId "/alert/text")
		return this.rc.value
	}
	; error in chromedriver: https://bugs.chromium.org/p/chromedriver/issues/detail?id=1120
	alertText(newText){
		local body:={}
		body.text:=newtext
		this.rc := WDSession.__ws("POST", this.prefijo "session/" this.sessionId "/alert/text", JSON.Stringify(body))
		return this.rc.isError
	}

	__dumpObj(obj){
		local key, value
		for key, value in obj
		{
			if(isObject(value)){
				if( value.uuid=WDSession.WDElement.weID )
					obj[key] := {WDSession.WDElement.weID: value.ref}
				else
					this.__dumpObj(value)
			}
		}
	}

	__translateObj(obj){
		local key, value
		for key, value in obj
		{
			if(IsObject(value))
				if(value.hasKey(WDSession.WDElement.weID)){
					obj[key]:=new WDSession.WDElement(value, this)
				}else
					this.__translateObj(value)
		}
	}


	;..............................................................................................................
	class WDElement{
		static weID := "element-6066-11e4-a52e-4f735466cecf"
		uuid	   := WDSession.WDElement.weId
		ref        := ""
		objSession := ""
		rc 		   := ""
		__New(obj, objSession){
			this.ref 		:= obj[WDSession.WDElement.weID]
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
			this.rc := WDSession.__ws("POST", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/value", JSON.Stringify({text: keys}))
			return this.rc.isError
		}
		getScreenshot(){
			this.rc := WDSession.__ws("GET", this.objSession.prefijo "session/" this.objSession.sessionId "/element/" this.ref "/screenshot")
			if(this.rc.isError) 
				return ""
			return this.rc.value
		}
	}

	;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	__ws(metodo, url, cuerpo:=""){
		static WS_SERVIDOR := ComObjCreate("Msxml2.XMLHTTP")
		local rc:={}
		msgbox % metodo " " url "`ncuerpo: " cuerpo
		WS_SERVIDOR.Open(metodo,url, false)
		WS_SERVIDOR.setRequestHeader("Content-Type","application/json; charset=UTF-8")
		WS_SERVIDOR.Send(cuerpo)
		rc.status      := WS_SERVIDOR.Status
		rc.isErrorWeb  := (WS_SERVIDOR.Status < 200 or WS_SERVIDOR.Status > 299)
		rc.raw         := WS_SERVIDOR.ResponseText
		rc.json        := ""
		rc.isError     :=  rc.isErrorWeb
		if(!rc.isErrorWeb){
			rc.json    := JSON.Parse(rc.raw)
			rc.value   := rc.json.value
			rc.isError := rc.value.hasKey("error")
			if(rc.isError){
				rc.error   := rc.value.error
				rc.message := rc.value.message
			}
		}
		return rc
	}
}
/* sample chorme capabilities
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


ObjDump(obj,ByRef var:="",mode:=0){
  If IsObject(var){ ; FileAppend mode
    If FileExist(obj){
      FileDelete,%obj%
      If ErrorLevel
        return
    }
    f:=FileOpen(obj,"rw-rwd","CP0"),VarSetCapacity(v,sz:=RawObjectSize(var,mode)+8,0)
    ,RawObject(var,NumPut(sz-8,0+(ptr:=&v),"Int64"),mode),count:=sz//65536
    Loop % count
      f.RawWrite(ptr+0,65536),ptr+=65536
    return sz,f.RawWrite(ptr+0,Mod(sz,65536)),f.Close()
  } else if !IsByRef(var)
		return RawObjectSize(obj,mode)+8
  else return sz,VarSetCapacity(var,sz:=RawObjectSize(obj,mode)+8,0),RawObject(obj,NumPut(sz-8,&var,"Int64"),mode)
}
RawObject(obj,addr,buf:=0,objects:=0){
  ; Type.Enum:    Char.1 UChar.2 Short.3 UShort.4 Int.5 UInt.6 Int64.7 UInt64.8 Double.9 String.10 Object.11
  ; Negative for keys and positive for values
  if !objects
    objects:={(""):0,(obj):0}
  else objects[obj]:=(++objects[""])
  for k,v in obj
  { ; 9 = Int64 for size and Char for type
    If !(kIsString:=0)&&IsObject(k){
      If objects.HasKey(k)
        NumPut(-12,addr+0,"Char"),NumPut(objects[k],addr+1,"Int64"),addr+=9
      else NumPut(-11,addr+0,"Char"),NumPut(sz:=RawObjectSize(k,buf),addr+1,"Int64"),RawObject(k,addr+9,buf,objects),addr+=sz+9
    }else if (k+0=""||k ""!=k+0||k~="\s")
      kIsString:=true,NumPut(-10,addr+0,"Char"),NumPut(sz:=StrPut(k,addr+9)*2,addr+1,"Int64"),addr+=sz+9
    else NumPut( InStr(k,".")?-9:k>4294967295?-8:k>65535?-6:k>255?-4:k>-1?-2:k>-129?-1:k>-32769?-3:k>-2147483649?-5:-7,addr+0,"Char")
        ,NumPut(k,addr+1,InStr(k,".")?"Double":k>4294967295?"UInt64":k>65535?"UInt":k>255?"UShort":k>-1?"UChar":k>-129?"Char":k>-32769?"Short":k>-2147483649?"Int":"Int64")
        ,addr+=InStr(k,".")||k>4294967295?9:k>65535?5:k>255?3:k>-129?2:k>-32769?3:k>-2147483649?5:9
    If IsObject(v){
      if objects.HasKey(v)
        NumPut( 12,addr+0,"Char"),NumPut(objects[v],addr+1,"Int64"),addr+=9
      else NumPut( 11,addr+0,"Char"),NumPut(sz:=RawObjectSize(v,buf),addr+1,"Int64"),RawObject(v,addr+9,buf,objects),addr+=sz+9
    }else if (v+0=""||v ""!=v+0||v~="\s")
      NumPut( 10,addr+0,"Char"),NumPut(sz:=buf?obj.GetCapacity(kIsString?"" k:k):StrPut(v)*2,addr+1,"Int64"),DllCall("RtlMoveMemory","PTR",addr+9,"PTR",buf?obj.GetAddress(kIsString?"" k:k):&v,"PTR",sz),addr+=sz+9
    else NumPut(InStr(v,".")?9:v>4294967295?8:v>65535?6:v>255?4:v>-1?2:v>-129?1:v>-32769?3:v>-2147483649?5:7,addr+0,"Char")
        ,NumPut(v,addr+1,InStr(v,".")?"Double":v>4294967295?"UInt64":v>65535?"UInt":v>255?"UShort":v>-1?"UChar":v>-129?"Char":v>-32769?"Short":v>-2147483649?"Int":"Int64")
        ,addr+=InStr(v,".")||v>4294967295?9:v>65535?5:v>255?3:v>-129?2:v>-32769?3:v>-2147483649?5:9
  }
}
RawObjectSize(obj,buf:=0,objects:=0){
  if !objects
    objects:={(obj):1}
  else if !objects.HasKey(obj)
    objects[obj]:=1
  sz:=0
  for k,v in obj
  {
    If !(kIsString:=0)&&IsObject(k)
      sz+=objects.HasKey(k)?9:RawObjectSize(k,buf,objects)+9
    else if (k+0=""||k ""!=k+0||k~="\s")
      kIsString:=true,sz+=StrPut(k)*2+9
    else sz+=InStr(k,".")||k>4294967295?9:k>65535?5:k>255?3:k>-129?2:k>-32769?3:k>-2147483649?5:9
    If IsObject(v)
      sz+=objects.HasKey(v)?9:RawObjectSize(v,buf,objects)+9
    else if (v+0=""||v ""!=v+0||v~="\s")
      sz+=(buf?obj.GetCapacity(kIsString?"" k:k):StrPut(v)*2)+9
    else sz+=InStr(v,".")||v>4294967295?9:v>65535?5:v>255?3:v>-129?2:v>-32769?3:v>-2147483649?5:9
  }
  return sz
}