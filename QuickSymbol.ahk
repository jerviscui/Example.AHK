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
time := 180

DoubleClick(VK)
{
    ; ToolTip(A_TimeSincePriorHotkey)
    if (A_PriorHotKey = A_ThisHotkey && A_TimeSincePriorHotkey > 100 && A_TimeSincePriorHotkey < time)
    {
        ; Send("{Backspace}+" . VK)
        Send("{Backspace}")
        
        if (VK = "1") {
            Send("{U+0021}")
        }
        else if (VK = "2") {
            Send("{U+0040}")
        }
        else if (VK = "3") {
            Send("{U+0023}")
        }
        else if (VK = "4") {
            Send("{U+0024}")
        }
        else if (VK = "5") {
            Send("{U+0025}")
        }
        else if (VK = "6") {
            Send("{U+005E}")
        }
        else if (VK = "7") {
            Send("{U+0026}")
        }
        else if (VK = "8") {
            Send("{U+002A}")
        }
        else if (VK = "9") {
            Send("{U+0028}")
        }
        else if (VK = "0") {
            Send("{U+0029}")
        }

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
            if (k = "k") {
                Send("^k")
                Send("^k")
                return true
            }

            ;todo 会先发送k再发送Ctrlk，如何吞掉k，或者考虑使用 InputHook
            Send("^k")
            ; Send("^" . k)
            return true
        }
    }

    return false
}

; $^j:: {
; ih := InputHook("L1", "{LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{CapsLock}{NumLock}{PrintScreen}{Pause}")
; ih := InputHook("L1", "{a}{b}{j}")
; ih.Start()
; ToolTip("start")

; ih.Wait()
; ToolTip("wait")

; ih.Stop()

; ToolTip("stop")
; ToolTip(ih.EndReason . " k:" . ih.EndKey)
; EndKey Max

;     Options := ""
;     ih := InputHook(Options)
;     if !InStr(Options, "V")
;         ih.VisibleNonText := false
;     ih.KeyOpt("{All}", "E")  ; 结束
;     ; Exclude the modifiers
;     ih.KeyOpt("{LCtrl}{RCtrl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}", "-E")
;     ih.Start()
;     ih.Wait()
;     ToolTip(ih.EndReason . " k:" . ih.EndKey)
; }

;#region markdown
$^k:: {
    ; if (!WinActive("A")) {
    ;     return
    ; }

    KeyWait "k"

    startTime := A_TickCount + 400
    Keys := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    while startTime > A_TickCount
    {
        Sleep(20)

        if KeyPressed(Keys)
        {
            ; ToolTip("break")
            return
        }
    }

    Old := A_Clipboard
    A_Clipboard := ""
    Txt := ""

    Send("^c")

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
