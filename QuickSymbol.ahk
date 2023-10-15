/*
Description = 快速输出数字键对应的符号和F键
*/
#Requires AutoHotkey v2.0

#SingleInstance Force

CoordMode "ToolTip", "Screen"

SendMode "Event"
SetKeyDelay(-1, 0)
A_MenuMaskKey := "vkFF"  ; vkFF 是未映射的

;#region Number output Numeric symbol and F1~F10
; time := DllCall("GetDoubleClickTime")
time := 230

DoubleClick(VK)
{
    ; ToolTip(A_TimeSincePriorHotkey)
    if (A_PriorHotKey = A_ThisHotkey && A_TimeSincePriorHotkey > 100 && A_TimeSincePriorHotkey < time)
    {
        Send("{Backspace}+" . VK)

        return
    }

    Send(VK)
}

global Pressed := false
global Count := 0

#MaxThreadsPerHotkey 2
$F12:: {
    global Pressed
    global Count

    Count := Count + 1

    if (Count >= 2) {
        Count := 0
        Pressed := false
        Send("{F13}")
        return
    }

    Pressed := true
    startTime := A_TickCount + 400
    while startTime > A_TickCount
    {
        if (Count = 0) {
            return
        }

        if GetKeyState("1", "P")
        {
            Count := 0
            Pressed := false
            Send("{F1}")
            return
        }
        if GetKeyState("2", "P")
        {
            Count := 0
            Pressed := false
            Send("{F2}")
            return
        }
        if GetKeyState("3", "P")
        {
            Count := 0
            Pressed := false
            Send("{F3}")
            return
        }
        if GetKeyState("4", "P")
        {
            Count := 0
            Pressed := false
            Send("{F4}")
            return
        }
        if GetKeyState("5", "P")
        {
            Count := 0
            Pressed := false
            Send("{F5}")
            return
        }
        if GetKeyState("6", "P")
        {
            Count := 0
            Pressed := false
            Send("{F6}")
            return
        }
        if GetKeyState("7", "P")
        {
            Count := 0
            Pressed := false
            Send("{F7}")
            return
        }
        if GetKeyState("8", "P")
        {
            Count := 0
            Pressed := false
            Send("{F8}")
            return
        }
        if GetKeyState("9", "P")
        {
            Count := 0
            Pressed := false
            Send("{F9}")
            return
        }
        if GetKeyState("0", "P")
        {
            Count := 0
            Pressed := false
            Send("{F10}")
            return
        }

        Sleep(10)
    }

    if (Count != 1) {
        return
    }

    Count := 0
    Pressed := false
    Send("{F12}")
}
#MaxThreadsPerHotkey 1

$1:: {
    if Pressed
    {
        return
    }

    DoubleClick("1")
}
$2:: {
    if Pressed
    {
        return
    }

    DoubleClick("2")
}
$3:: {
    if Pressed
    {
        return
    }

    DoubleClick("3")
}
$4:: {
    if Pressed
    {
        return
    }

    DoubleClick("4")
}
$5:: {
    if Pressed
    {
        return
    }

    DoubleClick("5")
}
$6:: {
    if Pressed
    {
        return
    }

    DoubleClick("6")
}
$7:: {
    if Pressed
    {
        return
    }

    DoubleClick("7")
}
$8:: {
    if Pressed
    {
        return
    }

    DoubleClick("8")
}
$9:: {
    if Pressed
    {
        return
    }

    DoubleClick("9")
}
$0:: {
    if Pressed
    {
        return
    }

    DoubleClick("0")
}
;#endregion

KeyPressed(Keys) {
    for k in Keys
    {
        if GetKeyState(k, "P")
        {
            ; ToolTip(k)
            return true
        }
    }
}

;#region markdown
$^k:: {
    if (!WinActive("A")) {
        return
    }

    Old := A_Clipboard
    A_Clipboard := ""
    Txt := ""

    Send("^c")
    KeyWait "k"

    startTime := A_TickCount + 400
    Keys := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    while startTime > A_TickCount
    {
        Sleep(20)

        if KeyPressed(Keys)
        {
            ; ToolTip("break")
            goto over
        }
    }

    if ClipWait(0.2)
    {
        Txt := A_Clipboard
        ; ToolTip(Txt)
    }
    else {
        ; UE ""
        ; Obsidian 不带\r\n
        ; VS Code 带\r\n
    }

    if (Txt != "") {
        Txt := RTrim(Txt, "`r`n")
        Txt := RTrim(Txt, "`n")

        Pos := InStr(Txt, "`n", 0, 1)
        Len := StrLen(Txt)

        if (Pos = 0)
        {
            if (InStr(Txt, " ", 0, -1) = Len) {
                SendInput("{U+0060}{U+0060}{Left}")
                goto over
            }
            else {
                Txt := "``" . Txt . "``"
            }
        }
        else {
            Txt := "``````" . "`n" . Txt . "`n" . "``````"
        }

        A_Clipboard := Txt
        ClipWait
        Send("^v")

        Sleep(200)
    }
    else {
        SendInput("{U+0060}{U+0060}{Left}")
    }

over:
    Txt := ""
    A_Clipboard := Old
    Old := ""
}
;#endregion
