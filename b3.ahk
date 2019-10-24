global stop:= false

^F5::
loop 3000
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

^F9::
ExitApp
return
