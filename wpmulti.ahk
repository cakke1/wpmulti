#NoEnv
#SingleInstance Force
SetKeyDelay, delay
SetWinDelay, 150
SetTitleMatchMode, 2

global curr_inst := 1
global instances := 3

global PID_1 := 0
global PID_2 := 0
global PID_3 := 0
global PID_4 := 0

global freeze_hotkey := "j"

global delay := 30

global instWidth := Floor(A_ScreenWidth / 2)
global instHeight := Floor(A_ScreenHeight / 2)

GetPids()

Freeze_Inst(i)
{
    pid := % PID_%i% 
    ControlSend, ahk_parent, {F3 down}{Esc}{F3 up}{%freeze_hotkey%}
}

ToWall()
{
    WinMinimize, A
    WinActivate, Fullscreen Projector
}

GetTargetInstance()
{
    MouseGetPos, mX, mY
    return (Floor(mY / instHeight) * 2) + Floor(mX / instWidth) + 1
}
 
GetPids()
{
    SetKeyDelay, 250
    send, {LWin Down}{t}{LWin Up}{Enter}
    Sleep, 500
    WinGet, PID_1, PID, A

    send, {LWin Down}{t 2}{LWin Up}{Enter}
    Sleep, 500
    WinGet, PID_2, PID, A

    send, {LWin Down}{t 3}{LWin Up}{Enter}
    Sleep, 500
    WinGet, PID_3, PID, A

    send, {LWin Down}{t 4}{LWin Up}{Enter}
    Sleep, 500
    WinGet, PID_4, PID, A

    SetKeyDelay, delay
}

ResetInstance(i)
{      
    pid := % PID_%i% 
    SetKeyDelay, 10
    WinGetTitle, title, ahk_pid %pid%  
    if (InStr(title, " - "))  
    {   
        WinActivate, Fullscreen Projector
        ControlSend, ahk_parent, {Tab 8}{Enter}, ahk_pid %pid%
    }
    else
    {
        WinActivate, Fullscreen Projector
        ControlSend, ahk_parent, {Tab 8}{Enter}, ahk_pid %pid%
    }
    SetKeyDelay, delay
}

SwitchInstance(i)
{
    pid := % PID_%i%
    WinActivate, ahk_pid %pid%
}

P::
        ToWall()
    return
#IfWinActive, Projector
{
    U::
        ResetInstance(GetTargetInstance())
    return

    Y::
        SwitchInstance(GetTargetInstance())
    return

    1::
        ResetInstance(1)
    return
    2::
        ResetInstance(2)
    return
    3::
        ResetInstance(3)
    return
    4::
        ResetInstance(4)
    return


    +1::
        SwitchInstance(1)
    return
    +2::
        SwitchInstance(2)
    return
    +3::
        SwitchInstance(3)
    return
    +4::
        SwitchInstance(4)
    return
}