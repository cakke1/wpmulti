#Persistent
#NoEnv
#SingleInstance Force

; AU - 1
; Ca - 2
; UK - 3
; US - 4

global instances = 3
global render_distance = 14 ; 32 - rd
delay = 15
global Sounds = true       

SetKeyDelay, delay
SetWinDelay, 100
SetTitleMatchMode, 2
 
global target_inst = 0
global current_instance = 1

global total_resets = 6900

global resetspath = "C:\Users\kiril\Desktop\__\MC\ahks\_WallReset\resets.txt"

FileRead, total_resets, %resetspath%

CreateWorld()
{
   send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter}
}

ExitWorld()
{         		
	Sound()
	SetKeyDelay, 5	
	send {Esc}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter} 
	SetKeyDelay, delay
	total_resets += 1
}

rddown()
{		
	SetKeyDelay, 0	
	send, {Blind}{RShift Down}{F3 down}{F 30}{D}{F3 up}{RShift Up}
	SetKeyDelay, delay
}

rdup()
{
	SetKeyDelay, 0	
	send, {Shift Up}{F3 down}{F %render_distance%}{D}{F3 up}
	SetKeyDelay, delay
}

Sound()
{  
   if (Sounds){
      SoundPlay, reset.wav
   }
}

SwitchWindow()
{ 	
	SetKeyDelay, 100
	if (current_instance = instances)
	{
	    current_instance := 1
	    send, {^Esc}
	    send, {LWin Down}{t}{LWin Up}{Enter}
	}
	 
	else if (current_instance < instances)
	{
	    current_instance += 1
	    send, {^Esc}
	    send, {LWin Down}{t %current_instance%}{LWin Up}{Enter}
	}
	SetKeyDelay, delay
}

ResetSwitch()
{
  ExitWorld()
  SwitchWindow()
}

{     
    U::
      ResetSwitch()
    return

    Y::
    	rddown()
    	rdup()
    return

    RAlt::
        MsgBox, %total_resets%
    return
    
    ^LAlt::
        Reload
    return
}