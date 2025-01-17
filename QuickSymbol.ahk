/*
Description = 快速输出数字键对应的符号和F键
*/
#Requires AutoHotkey v2.0

#SingleInstance Force

CoordMode "ToolTip", "Screen"
CoordMode "Mouse", "Screen"

; SendMode "Event"
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

    if (Pressed) {
        return
    }

    Pressed := true
    startTime := A_TickCount + 400
    while startTime > A_TickCount
    {
        if GetKeyState("1", "P")
        {
            Send("{F1}")

            F12Over()
            return
        }
        if GetKeyState("2", "P")
        {
            Send("{F2}")

            F12Over()
            return
        }
        if GetKeyState("3", "P")
        {
            Send("{F3}")

            F12Over()
            return
        }
        if GetKeyState("4", "P")
        {
            Send("{F4}")

            F12Over()
            return
        }
        if GetKeyState("5", "P")
        {
            Send("{F5}")

            F12Over()
            return
        }
        if GetKeyState("6", "P")
        {
            Send("{F6}")

            F12Over()
            return
        }
        if GetKeyState("7", "P")
        {
            Send("{F7}")

            F12Over()
            return
        }
        if GetKeyState("8", "P")
        {
            Send("{F8}")

            F12Over()
            return
        }
        if GetKeyState("9", "P")
        {
            Send("{F9}")

            F12Over()
            return
        }
        if GetKeyState("0", "P")
        {
            Send("{F10}")

            F12Over()
            return
        }

        Sleep(10)
    }

    ; timeout, no target key pressed
    Send("{F12}")
    F12Over()
    return
}

F12Over() {
    global Pressed
    global Count

    Count := 0
    Pressed := false
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
$-:: {
    if Pressed
    {
        return
    }

    DoubleClick("-")
}
;#endregion

;#region markdown
; KeyPressed(Keys) {
;     for k in Keys
;     {
;         if GetKeyState(k, "P")
;         {
;             ; ToolTip(k)

;             Send("^k")
;             Sleep(20)
;             Send("^" . k)

;             return true
;         }
;     }

;     return false
; }

; global Keys := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
; global CtrKPressed := false

; $^k:: {
;     global CtrKPressed

;     if CtrKPressed
;     {
;         ; ToolTip("^k return")
;         return
;     }

;     CtrKPressed := true
;     KeyWait "k"
;     SetTimer After250, -1
; }

; $^c::
; $^u::
; $^i::
; $^s::
; $^p::
; $^l::
; {
;     global CtrKPressed

;     ; ToolTip(A_PriorHotKey . " " . A_ThisHotkey . " " . ThisHotkey)

;     if CtrKPressed
;     {
;         ; ToolTip("CtrKPressed")
;         return
;     }

;     Key := A_ThisHotkey
;     Key := LTrim(Key, "$")

;     Send(Key)
; }

; After250() {
;     global Keys
;     global CtrKPressed

;     Old := A_Clipboard
;     A_Clipboard := ""
;     Txt := ""

;     startTime := A_TickCount + 250
;     while startTime > A_TickCount
;     {
;         Sleep(20)

;         if KeyPressed(Keys)
;         {
;             ; ToolTip("break")
;             goto over
;         }
;     }

;     Line := ""
;     Select := false

;     Send("^c")
;     if ClipWait(0.1)
;     {
;         ; Obsidian 不带\r\n
;         ; VS Code 带\r\n

;         Txt := A_Clipboard
;         ; ToolTip(Txt)

;         Pos := InStr(Txt, "`n", 0, 1)
;         if (Pos = 0) ; 单行
;         {
;             ; 1. 选中内容复制
;             ; 2. 整行复制
;             A_Clipboard := ""
;             SendInput("{End 2}+{Home 2}") ; fix 单行文本折叠成多行
;             Send("^c")
;             if ClipWait(0.1)
;             {
;                 Line := A_Clipboard
;             }
;             SendInput("{End 2}")
;             ; 3. 比较，不相等，存在选中
;             if (InStr(Txt, "* ", 0, 1) = 1) {
;                 Select := false
;             }
;             else if (InStr(Txt, ". ", 0, 1) = 2) {
;                 Select := false
;             }
;             else if (Line != Txt) {
;                 Select := true
;             }
;         }
;     }
;     else { ; 未选中或者不能复制行
;         ; UE ""
;         ; ToolTip("no select")

;         SendInput("+{Home}")
;         Send("^c")
;         if ClipWait(0.1)
;         {
;             Txt := A_Clipboard
;         }
;     }

;     Txt := RTrim(Txt, "`r`n")

;     if (Txt != "") {
;         Pos := InStr(Txt, "`n", 0, 1)
;         Len := StrLen(Txt)

;         if (Pos = 0) ; 单行
;         {
;             if (Select) {
;                 SendInput("+{Home 2}{BackSpace}")

;                 ; 4. 选中则替换选中内容
;                 Replace := "``" . Txt . "``"
;                 Txt := StrReplace(Line, Txt, Replace)
;                 ; ToolTip(Txt)
;             }
;             else { ; 结尾触发
;                 Space := InStr(Txt, " ", 0, -1)
;                 if (Space = Len) { ; 空格结尾``
;                     SendInput("{End}{U+0060}{U+0060}{Left}")
;                     goto over
;                 }
;                 else if (Space = 0) { ; 没有空格
;                     goto over

;                     ; SendInput("+{Home}{BackSpace}")
;                     ; Txt := "``" . Txt . "``"
;                 }
;                 else { ; 中间有空格
;                     LeftCount := Len - Space
;                     SendInput("+{Left " . LeftCount . "}" . "{BackSpace}")

;                     Txt := "``" . SubStr(Txt, Space + 1) . "``"
;                 }
;             }
;         }
;         else { ; 多行
;             Txt := LTrim(Txt, "`r`n")
;             Txt := "``````" . "`n" . Txt . "`n" . "``````"
;         }

;         A_Clipboard := Txt
;         ClipWait
;         Send("^v")

;         Sleep(50)
;     }
;     else {
;         SendInput("{U+0060}{U+0060}{U+0060}{Enter}{U+0060}{U+0060}{U+0060}{Up}")
;     }

; over:
;     Txt := ""
;     A_Clipboard := Old
;     Old := ""
;     SetTimer , 0  ; 即此处计时器关闭自己.
;     CtrKPressed := false
; }

#HotIf WinActive("ahk_exe Obsidian.exe")
$^k:: {
    Obsidian_After250()
}

Obsidian_After250() {
    old := A_Clipboard
    A_Clipboard := ""
    txt := ""
    line := ""
    select := false

    Send("^c")
    KeyWait "k"
    if ClipWait(0.250)
    {
        ; Obsidian 不带\r\n
        txt := A_Clipboard
        A_Clipboard := ""
        ; ToolTip(txt)
        ; Sleep(1000)

        len := StrLen(txt)
        pos := InStr(txt, "`n", 0, 1)

        if (pos > 0) ; 多行
        {
            txt := LTrim(txt, "`r`n")
            txt := "``````" . "`n" . txt . "`n" . "``````"

            A_Clipboard := txt
            ClipWait
            Send("^v")
            Sleep(50)

            CtrlKOver(&txt, &old)
            return
        }
        ; else 单行
        if (InStr(txt, "* ", 0, 1) > 0) {
            select := false
        }
        else if (InStr(txt, ". ", 0, 1) > 0) {
            select := false
        }
        else {
            right := ""

            SendInput("{Right}")
            SendInput("+{End 2}") ; 复制光标之后，兼容单行文本折叠成多行
            Send("^c")
            if ClipWait(0.100)
            {
                line := A_Clipboard
                A_Clipboard := ""
                right := line
                ; ToolTip("line: " . line)
                ; Sleep(1000)

                ; line end or start
                if (len = StrLen(line) && line = txt) {
                    SendInput("{Left 2}")
                    SendInput("+{Home 2}")
                    Send("^c")
                    if ClipWait(1) {
                        last := A_Clipboard
                        A_Clipboard := ""
                        ; ToolTip("Last: " . last)
                        ; Sleep(1000)

                        ; line start
                        if (len = StrLen(last)) {
                            ; ToolTip("start: " . last)
                            ; Sleep(1000)

                            select := false
                        }
                        ; at last one char
                        else {
                            ; ToolTip("end: " . last)
                            ; Sleep(1000)

                            SendInput("{Right 2}")
                            select := false
                        }
                    }
                    else {
                        CtrlKOver(&txt, &old)
                        return
                    }
                }
                ; line middle
                else {
                    SendInput("{Left}")
                    Send("^c")
                    if ClipWait(1)
                    {
                        line := A_Clipboard
                        A_Clipboard := ""
                        ; no select
                        if (len = StrLen(line)) {
                            ; ToolTip("no: " . line)
                            ; Sleep(1000)

                            SendInput("{Left}")
                            select := false
                        }
                        else {
                            select := true

                            ; at last one char
                            if (line = right) {
                                SendInput("{Right}")
                                right := ""
                            }

                            SendInput("{Left " . len . "}")
                            SendInput("+{End 2}")
                            Sleep(len * 3)

                            txt := "``" . txt . "``" . right
                            ; ToolTip("Txt: " . txt, , 10, 2)
                            A_Clipboard := txt
                            if ClipWait() {
                                ; ToolTip("A_Clipboard: " . A_Clipboard, , 40, 3)
                                Send("^v")
                                ; ToolTip("pasted", , 60, 1)
                                ; Sleep(len * 10)
                                Sleep(200)
                            }
                            else {
                                ToolTip("error: " . A_Clipboard, , 40, 3)
                            }
                        }
                    }
                    else {
                        CtrlKOver(&txt, &old)
                        return
                    }
                }
            }
            else {
                ; line end
                SendInput("{Left}")
                select := false
            }
        }

        if select = false
        {
            ; 光标加行内标记
            SendInput("{U+0060}{U+0060}{Left}")
        }
    }
    ; empty line
    else {
        SendInput("{U+0060}{U+0060}{U+0060}{Enter}{U+0060}{U+0060}{U+0060}{Up}")
        SendInput("{U+0063}{U+0073}{U+0068}{U+0061}{U+0072}{U+0070}+{Left 6}")
    }

    CtrlKOver(&txt, &old)
    return
}

CtrlKOver(&Txt, &Old) {
    Txt := ""
    A_Clipboard := old
    Old := ""
}
#HotIf
;#endregion

#Include <GetCaretPosEx>

;#region Visual Studio

#HotIf WinActive("ahk_exe devenv.exe")

; ~Alt::vkFF  ; 左边的Alt键弹起时，自动按下Eas键

$!o:: {
    KeyWait "Alt"

    Click "Right"
}

$!u:: {
    KeyWait "Alt"

    if GetCaretPosEx(&left, &top, &right, &bottom) {
        Click (left + right) / 2, (top + bottom) / 2, "Left", 2
    }
}

global ActiveFiles := 0

; open active files
; $^p:: {
;     global ActiveFiles

;     if (ActiveFiles) {
;         return
;     }

;     KeyWait "Ctrl"

;     ActiveFiles := 1

;     Send "{Ctrl down}"
;     Sleep 100
;     Send "{Tab}"
;     Sleep 100

;     SetTimer ReleaseCtrl, 50
; }

ReleaseCtrl()
{
    global ActiveFiles

    if (ActiveFiles && (GetKeyState("Enter", "P") || GetKeyState("Esc", "P") || GetKeyState("LButton", "P"))) {
        SetTimer , 0

        ActiveFiles := 0
        Send "{Ctrl up}"
    }
}
#HotIf
;#endregion

$!e:: Send "{Up}"
$!s:: Send "{Left}"
$!d:: Send "{Down}"
$!f:: Send "{Right}"

$!o:: {
    Click "Right"
}

$!u:: {
    if GetCaretPosEx(&left, &top, &right, &bottom) {
        Click (left + right) / 2, (top + bottom) / 2, "Left", 2
    }
}

; suppress, same with winG
Ctrl & Esc:: {
    return
}

; move mouse to center
$!c:: {
    if (!WinActive("A")) {
        return
    }

    WinGetPos(&X, &Y, &W, &H)
    MoveMouseToCenter(-9999, -9999, X, Y, W, H)
}

+Delete:: {
    Send "{BackSpace}"
}

;#region AltTabMenu
GroupAdd "AltTabWindow", "ahk_class MultitaskingViewFrame"  ; Windows 10
GroupAdd "AltTabWindow", "ahk_class TaskSwitcherWnd"  ; Windows Vista, 7, 8.1
GroupAdd "AltTabWindow", "ahk_class #32771"  ; 更早的系统, 或启用了经典的 alt-tab

#HotIf GetKeyState("Ctrl", "P")
*!Tab:: {
    KeyWait "Alt"

    Send "^!{Tab}"
    Sleep 100
    ; if (WinExist("ahk_group AltTabWindow")) {
    ;     ToolTip "AltTabWindow"
    ; }

    SetTimer AltTabMenuClose, 50
}

AltTabMenuClose()
{
    if (GetKeyState("Esc", "P")) {
        SetTimer , 0

        return
    }

    if (GetKeyState("Enter", "P")) {
        SetTimer , 0

        ActiveHwnd := WinActive("A")
        ; ActiveHwnd := WinActive("A", , "ahk_group AltTabWindow") ; Visual Studio 检测不到
        ; ToolTip "1 " . ActiveHwnd
        if (!ActiveHwnd) {
            Sleep 200
            ActiveHwnd := WinActive("A")
            ; ActiveHwnd := WinActive("A", , "ahk_group AltTabWindow") ; Visual Studio 检测不到
            ; ToolTip "2 " . ActiveHwnd
            if (!ActiveHwnd) {
                return
            }
        }

        MouseGetPos(&HX, &HY)
        WinGetPos(&X, &Y, &W, &H)
        MoveMouseToCenter(HX, HY, X, Y, W, H)
    }
}
#HotIf

#HotIf not WinExist("ahk_group AltTabWindow")
$!Tab:: {
    KeyWait "Alt"

    Send "!{Tab}"
    Sleep 300

    ActiveHwnd := WinActive("A")
    ; ActiveHwnd := WinActive("A", , "ahk_group AltTabWindow") ; Visual Studio 检测不到
    ; ToolTip "1 " . ActiveHwnd
    if (!ActiveHwnd) {
        Sleep 200
        ActiveHwnd := WinActive("A")
        ; ActiveHwnd := WinActive("A", , "ahk_group AltTabWindow") ; Visual Studio 检测不到
        ; ToolTip "2 " . ActiveHwnd
        if (!ActiveHwnd) {
            return
        }
    }

    ; this_class := WinGetClass(ActiveHwnd)
    ; this_title := WinGetTitle(ActiveHwnd)

    MouseGetPos(&HX, &HY)
    WinGetPos(&X, &Y, &W, &H)
    MoveMouseToCenter(HX, HY, X, Y, W, H)
}
#HotIf

MoveMouseToCenter(HX, HY, X, Y, W, H)
{
    MoveAble := false
    if (HX <= X || HX >= X + W || HY <= Y || HY >= Y + H) {
        MoveAble := true
    }

    if (MoveAble) {
        Click X + W / 2, Y + H / 2, 0
    }
}

; MButton::AltTabMenu
; WheelDown::AltTab
; WheelUp::ShiftAltTab

;#endregion
