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
        else if (VK = "-") {
            Send("{U+005F}")
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

    ; if (Count >= 2) {
    ;     Count := 0
    ;     Pressed := false
    ;     Send("{F14}")
    ;     return
    ; }

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

$F13:: {
    Send("^!n}")
}

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
$-:: {
    if Pressed
    {
        return
    }

    DoubleClick("-")
}
;#endregion

;#region markdown
KeyPressed(Keys) {
    for k in Keys
    {
        if GetKeyState(k, "P")
        {
            ; ToolTip(k)

            Send("^k")
            Sleep(20)
            Send("^" . k)

            return true
        }
    }

    return false
}

global Keys := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
global CtrKPressed := false

$^k:: {
    ; if (!WinActive("A")) {
    ;     return
    ; }

    global CtrKPressed

    if CtrKPressed
    {
        ; ToolTip("^k return")
        return
    }

    CtrKPressed := true
    KeyWait "k"
    SetTimer After250, -1
}

$^s::
$^p::
$^l::
{
    global CtrKPressed

    ; ToolTip(A_PriorHotKey . " " . A_ThisHotkey . " " . ThisHotkey)

    if CtrKPressed
    {
        ; ToolTip("CtrKPressed")
        return
    }

    Key := A_ThisHotkey
    Key := LTrim(Key, "$")

    Send(Key)
}

After250() {
    global Keys
    global CtrKPressed

    Old := A_Clipboard
    A_Clipboard := ""
    Txt := ""

    startTime := A_TickCount + 250
    while startTime > A_TickCount
    {
        Sleep(20)

        if KeyPressed(Keys)
        {
            ; ToolTip("break")
            goto over
        }
    }

    Line := ""
    Select := false

    Send("^c")
    if ClipWait(0.1)
    {
        ; Obsidian 不带\r\n
        ; VS Code 带\r\n

        Txt := A_Clipboard
        ; ToolTip(Txt)

        Pos := InStr(Txt, "`n", 0, 1)
        if (Pos = 0) ; 单行
        {
            ; 1. 选中内容复制
            ; 2. 整行复制
            A_Clipboard := ""
            SendInput("{End 2}+{Home 2}") ; fix 单行文本折叠成多行
            Send("^c")
            if ClipWait(0.1)
            {
                Line := A_Clipboard
            }
            SendInput("{End 2}")
            ; 3. 比较，不相等，存在选中
            if (InStr(Txt, "* ", 0, 1) = 1) {
                Select := false
            }
            else if (InStr(Txt, ". ", 0, 1) = 2) {
                Select := false
            }
            else if (Line != Txt) {
                Select := true
            }
        }
    }
    else { ; 未选中或者不能复制行
        ; UE ""
        ; ToolTip("no select")

        SendInput("+{Home}")
        Send("^c")
        if ClipWait(0.1)
        {
            Txt := A_Clipboard
        }
    }

    Txt := RTrim(Txt, "`r`n")

    if (Txt != "") {
        Pos := InStr(Txt, "`n", 0, 1)
        Len := StrLen(Txt)

        if (Pos = 0) ; 单行
        {
            if (Select) {
                SendInput("+{Home 2}{BackSpace}")

                ; 4. 选中则替换选中内容
                Replace := "``" . Txt . "``"
                Txt := StrReplace(Line, Txt, Replace)
                ; ToolTip(Txt)
            }
            else { ; 结尾触发
                Space := InStr(Txt, " ", 0, -1)
                if (Space = Len) { ; 空格结尾``
                    SendInput("{End}{U+0060}{U+0060}{Left}")
                    goto over
                }
                else if (Space = 0) { ; 没有空格
                    goto over

                    ; SendInput("+{Home}{BackSpace}")
                    ; Txt := "``" . Txt . "``"
                }
                else { ; 中间有空格
                    LeftCount := Len - Space
                    SendInput("+{Left " . LeftCount . "}" . "{BackSpace}")

                    Txt := "``" . SubStr(Txt, Space + 1) . "``"
                }
            }
        }
        else { ; 多行
            Txt := LTrim(Txt, "`r`n")
            Txt := "``````" . "`n" . Txt . "`n" . "``````"
        }

        A_Clipboard := Txt
        ClipWait
        Send("^v")

        Sleep(50)
    }
    else {
        SendInput("{U+0060}{U+0060}{U+0060}{Enter}{U+0060}{U+0060}{U+0060}{Up}")
    }

over:
    Txt := ""
    A_Clipboard := Old
    Old := ""
    SetTimer , 0  ; 即此处计时器关闭自己.
    CtrKPressed := false
}
;#endregion
