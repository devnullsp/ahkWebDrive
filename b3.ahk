global stop:= false

^F5::
loop 750
{
	IF(STOP){
		stop:=false
		return
	}
	send {Q DOWN}
	Sleep 100
	send {Q up}
	Sleep 100
}
return

^F9::
ExitApp
return
