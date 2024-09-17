/*
Description = QMK OSD
*/
; #Requires AutoHotkey v2.0

; #SingleInstance Force

; ; SendMode "Event"
; SetKeyDelay(-1, 0)
; A_MenuMaskKey := "vkFF"  ; vkFF 是未映射的

;#region Status Gui

MyGui := Gui("+LastFound +AlwaysOnTop +ToolWindow -Caption +Border +E0x08000000", "qmk status")
MyGui.SetFont("s9 bold", "Microsoft YaHei")
MyGui.MarginX := 5
MyGui.MarginY := 3
MyGui.BackColor := "Black"
WinSetTransparent(130, MyGui)

Txt := MyGui.Add("Text", "cWhite", "")

; MyGui.Show("X50 Y30 NoActivate")

global Layer := ""
global Swap := ""
global OSM := Map(
    "LS", 0,
    "RS", 0,
    "LA", 0,
    "LC", 0,
    "LG", 0)

; layer 1
F15 & 1:: {
    global Layer

    Layer := ""
    Show()
}

; layer 2
F15 & 2:: {
    global Layer

    Layer := "F"
    Show()
}

; layer 3
F15 & 3:: {
    global Layer

    Layer := "Num"
    Show()
}

; Swap on
F15 & 9:: {
    global Swap

    Swap := "Swap"
    Show()
}

; Swap off
F15 & 0:: {
    global Swap

    Swap := ""
    Show()
}

;#region OSM

F16 & 1:: {
    global OSM

    OSM["LS"] := 1
    Show()
}

F16 & 2:: {
    global OSM

    OSM["LS"] := 0
    Show()
}

F16 & 3:: {
    global OSM

    OSM["RS"] := 1
    Show()
}

F16 & 4:: {
    global OSM

    OSM["RS"] := 0
    Show()
}

F16 & 5:: {
    global OSM

    OSM["LA"] := 1
    Show()
}

F16 & 6:: {
    global OSM

    OSM["LA"] := 0
    Show()
}

F16 & 7:: {
    global OSM

    OSM["LC"] := 1
    Show()
}

F16 & 8:: {
    global OSM

    OSM["LC"] := 0
    Show()
}

F16 & 9:: {
    global OSM

    OSM["LG"] := 1
    Show()
}

F16 & 0:: {
    global OSM

    OSM["LG"] := 0
    Show()
}

;#endregion

Show() {
    ;layer
    value := Layer

    ; typewriter
    if (Typewriter) {
        if (StrLen(value)) {
            value := "ON" . "`n" . value
        }
        else {
            value := "ON"
        }
    }

    ;swap
    if (StrLen(Swap)) {
        if (StrLen(value)) {
            value := value . "+"
        }
        value := value . Swap
    }

    ;OSM
    newline := ""
    for key, value in OSM {
        if (value) {
            newline := newline . "+" . key
        }
    }
    if (StrLen(newline)) {
        newline := Trim(newline, "+")
        if (StrLen(value)) {
            value := value . "`n" . newline
        }
        else {
            value := newline
        }
    }

    Txt.Text := value

    if (StrLen(value) = 0) {
        MyGui.Hide()
    }
    else {
        GetSize(&value, &w, &h)
        Txt.Move(, , w, h)
        Txt.Redraw()
        MyGui.Show("X50 Y30 AutoSize NoActivate")
    }
}

GetSize(&Content, &W, &H) {
    tmpGui := Gui()
    tmpGui.SetFont("s9 bold", "Microsoft YaHei")
    tmpGui.MarginX := 5
    tmpGui.MarginY := 3

    tmpTxt := tmpGui.AddText(, Content)

    tmpTxt.GetPos(&x, &y, &W, &H)
    tmpGui.Destroy()
}

;#endregion

;#region Visual Studio

global Typewriter := 0

; switch typewriter mode
Ctrl & F13:: {
    global Typewriter

    if (Typewriter) {
        Typewriter := 0
    }
    else {
        Typewriter := 1
    }

    Show()
}

#HotIf WinActive("ahk_exe devenv.exe")

global ActiveFiles := 0

; open active files
Ctrl & p:: {
    global ActiveFiles

    if (ActiveFiles) {
        return
    }

    KeyWait "Ctrl"

    ActiveFiles := 1

    Send "{Ctrl down}"
    Sleep 100
    Send "{Tab}"
    Sleep 50

    SetTimer ReleaseCtrl, 50
}

ReleaseCtrl()
{
    global ActiveFiles

    if (ActiveFiles && (GetKeyState("Enter", "P") || GetKeyState("Esc", "P") || GetKeyState("LButton", "P"))) {
        SetTimer , 0

        ActiveFiles := 0
        Send "{Ctrl up}"
    }
}

F13 & q:: {
    Send("^!n")
}

; 恢复 F13 功能
$F13:: {
    Send("{F13}")
}

$Enter:: {
    if (Typewriter) {
        Send("{Enter}")
        Send("{F13 2}")
    }
    else {
        Send("{Enter}")
    }
}

$Up:: {
    if (Typewriter) {
        Send("{Up}")
        Send("{F13 2}")
    }
    else {
        Send("{Up}")
    }
}

$Down:: {
    if (Typewriter) {
        Send("{Down}")
        Send("{F13 2}")
    }
    else {
        Send("{Down}")
    }
}
#HotIf

;#endregion

$!e:: Send "{Up}"
$!s:: Send "{Left}"
$!d:: Send "{Down}"
$!f:: Send "{Right}"

; suppress, same with winG
Ctrl & Esc:: {
    return
}
