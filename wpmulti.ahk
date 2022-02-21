#Persistent
#NoEnv
#SingleInstance Force

; Setup

; mods
; world preview
; auto reset
; fast reset
; krypton
; lazy dfu
; lithium
; sodium
; starlight

; multi instance pack
; language   instance  
; AU - 			1
; Ca - 			2
; UK - 			3
; US - 			4

; start every instance and move them to the left side of the taskbar
; enable the "Automatically hide the taskbar" option
; change resetspath 
; don't mess with win delay

global instances = 3 ; instance number
global render_distance = 14 
delay = 15
global Sounds = true ; reset sounds    

SetKeyDelay, delay
SetWinDelay, 100
SetTitleMatchMode, 2
 
global target_inst = 0
global current_instance = 1

global total_resets = 6900

global resetspath = "C:\Users\___"

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
	; reset current instance and switch 
    U::
      ResetSwitch()
    return

    ; show the resets counter
    RAlt::
        MsgBox, %total_resets%
    return
    
    ; reload the macro - Ctrl + Alt
    ^LAlt::
        Reload
    return
}