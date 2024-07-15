/*
Description = 中英文符号互换
*/
; #Requires AutoHotkey v2.0

; #SingleInstance Force

; ; SendMode "Event"
; SetKeyDelay(-1, 0)
; A_MenuMaskKey := "vkFF"  ; vkFF 是未映射的

global KeyboardLayoutId := Map(
    "cn", 134481924, ;微软拼音
    "en", 67699721, ;英文
)

; 返回当前输入法的中英文状态
IsCnIME(WinTitle := "A")
{
    try {
        hWnd := WinGetID(WinTitle)
    } catch Error as err {
        ; ^Esc 开始菜单弹窗，会卡死在找不到当前窗口
        return
    }

    origin_detect_hidden_window := A_DetectHiddenWindows
    DetectHiddenWindows(True)
    ThreadID := DllCall("GetWindowThreadProcessId", "UInt", hWnd, "UInt", 0)
    InputLocaleID := DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")

    result := SendMessage(
        0x283,  ; Message : WM_IME_CONTROL
        0x001,  ; wParam : IMC_GETCONVERSIONMODE
        ; 0x005,  ; wParam  : IMC_GETOPENSTATUS
        0,      ; lParam  ： (NoArgs)
        ,       ; Control ： (Window)
        "ahk_id " DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")
    )
    DetectHiddenWindows(origin_detect_hidden_window)

    ; 微软拼音（英-中）0/1024-1/1025
    ; 1 非英文状态
    ; 0 英文状态
    return (InputLocaleID == KeyboardLayoutId["cn"] and result == 1025)
}

#Hotstring EndChars `t

; , to ，
:?B0COZ:,:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+002C}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+FF0C}")
    }
}

; . to 。
:?B0COZ:.:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+002E}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+3002}")
    }
}

; <> to 《》
:?COZ:<>:: {
    if IsCnIME()
    {
        SendInput("{U+003C}{U+003E}{Left}")
    }
    else
    {
        ; only for cn to en
        SendInput("{U+003C}{U+003E}{Tab}")
        ; SendInput("{U+300A}{U+300B}{Left}")
    }
}

; 》》  to >>
:*?COZ:>> :: {
    if IsCnIME()
    {
        SendInput("{U+003E}{U+003E}{Space}")
    }
    else
    {
        ; only for cn to en
        SendInput("{U+003E}{U+003E}{Space}")
        ; SendInput("{U+300B}{U+300B}{Space}")
    }
}

; 》 to >
:*?COZ:> :: {
    if IsCnIME()
    {
        SendInput("{U+003E}{Space}")
    }
    else
    {
        ; only for cn to en
        SendInput("{U+003E}{Space}")
        ; SendInput("{U+300B}")
    }
}

; < to 《
:?B0COZ:<:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+003C}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+300A}")
    }
}

; > to 》
:?B0COZ:>:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+003E}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+300B}")
    }
}

; /// to 、、、
:?B0COZ:///:: {
    if IsCnIME()
    {
        SendInput("{Backspace 3}{U+002F}{U+002F}{U+002F}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+3001}")
    }
}

; // to 、、
:?B0COZ://:: {
    if IsCnIME()
    {
        SendInput("{Backspace 2}{U+002F}{U+002F}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+3001}")
    }
}

; / to 、
:?B0COZ:/:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+002F}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+3001}")
    }
}

; ? to ？
:?B0COZ:?:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+003F}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+FF1F}")
    }
}

; ; to ；
:?B0COZ:;:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+003B}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+FF1B}")
    }
}

; : to ：
:?B0COZ:`::: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+003A}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+FF1A}")
    }
}

; '' to ‘’
:?COZ:'':: {
    if IsCnIME()
    {
        SendInput("{U+0027}{U+0027}{Left}")
    }
    else
    {
        SendInput("{U+2018}{U+2019}{Left}")
    }
}

; "" to “”
:?B0COZ:"":: {
    if IsCnIME()
    {
        SendInput("{Backspace 2}{U+0022}{U+0022}{Left}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+201C}{U+201D}{Left}")
    }
}

; \ to 、
:?B0COZ:\:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+005C}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+3001}")
    }
}

; _ to ——
:?B0COZ:_:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+005F}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+2014}{U+2014}")
    }
}

; ! to ！
:?B0COZ:!:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+0021}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+FF01}")
    }
}

; $$ to ￥￥
:?B0COZ:$$:: {
    if IsCnIME()
    {
        SendInput("{Backspace 2}{U+0024}{U+0024}{Left}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+FFE5}")
    }
}

; $ to ￥
:?B0COZ:$:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+0024}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+FFE5}")
    }
}

; ^ to ……
:?B0COZ:^:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+005E}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+2026}{U+2026}")
    }
}

; () to （）
:?COZ:():: {
    if IsCnIME()
    {
        SendInput("{U+0028}{U+0029}{Left}")
    }
    else
    {
        SendInput("{U+FF08}{U+FF09}{Left}")
    }
}

; ( to （
:?B0COZ:(:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+0028}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+FF08}")
    }
}

; ) to ）
:?B0COZ:):: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+0029}")
    }
    else
    {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+FF09}")
    }
}

; `` to ··
:*?COZ:````:: {
    if IsCnIME()
    {
        SendInput("{U+0060}{U+0060}{Left}")
    }
    else {
        ; only for cn to en
        SendInput("{U+0060}{U+0060}{Left}")
    }
}

; ` to ·
:?COZ:``:: {
    if IsCnIME()
    {
        SendInput("{U+0060}")
    }
    else {
        ; only for cn to en
        SendInput("{U+0060}")
        ; SendInput("{U+00B7}")
    }
}

; 【【 to [[]]
:*?COZ:[[:: {
    if IsCnIME()
    {
        SendInput("{U+005B}{U+005B}{U+005D}{U+005D}{Left 2}")
    }
    else {
        ; todo: some app use SendInput("{U+005B}{U+005B}{U+005D}{U+005D}{Left 2}")
        SendInput("{U+005B}{U+005B}")
    }
}

; [] to 【】
:?B0COZ:[]:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{Backspace}{U+005B}{U+005D}{Left}")
    }
    else {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+3010}")
    }
}

; [ to 【
:?B0COZ:[:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+005B}")
    }
    else {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+3010}")
    }
}

; ]; to 】
:?B0COZ:]:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+005D}")
    }
    else {
        ; only for cn to en
        SendInput("{Tab}")
        ; SendInput("{U+3011}")
    }
}

:*?B0COZ:1. ::
:*?B0COZ:2. ::
:*?B0COZ:3. ::
:*?B0COZ:4. ::
:*?B0COZ:5. ::
:*?B0COZ:6. ::
:*?B0COZ:7. ::
:*?B0COZ:8. ::
:*?B0COZ:9. ::
:*?B0COZ:0. ::
{
    if IsCnIME()
    {
        ToolTip("中文输入法")

        SendInput("{BackSpace 1}")

        Old := A_Clipboard
        A_Clipboard := ""

        SendInput("+{Left}")
        Send("^c")
        if ClipWait(0.100)
        {
            Txt := A_Clipboard
            A_Clipboard := ""

            switch Txt {
                case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0":
                    SendInput("{Right}{U+002E}{Space}")
                default:
                    SendInput("{Right}{U+3002}")
            }
        }
        else
        {
            SendInput("{Right}")
        }

        A_Clipboard := Old
    }
    else
    {
        SendInput("{Space}")
    }
}

:*?COZ:1.1::
:*?COZ:2.1::
:*?COZ:3.1::
:*?COZ:4.1::
:*?COZ:5.1::
:*?COZ:6.1::
:*?COZ:7.1::
:*?COZ:8.1::
:*?COZ:9.1::
:*?COZ:0.1::
:*?COZ:1.2::
:*?COZ:2.2::
:*?COZ:3.2::
:*?COZ:4.2::
:*?COZ:5.2::
:*?COZ:6.2::
:*?COZ:7.2::
:*?COZ:8.2::
:*?COZ:9.2::
:*?COZ:0.2::
:*?COZ:1.3::
:*?COZ:2.3::
:*?COZ:3.3::
:*?COZ:4.3::
:*?COZ:5.3::
:*?COZ:6.3::
:*?COZ:7.3::
:*?COZ:8.3::
:*?COZ:9.3::
:*?COZ:0.3::
:*?COZ:1.4::
:*?COZ:2.4::
:*?COZ:3.4::
:*?COZ:4.4::
:*?COZ:5.4::
:*?COZ:6.4::
:*?COZ:7.4::
:*?COZ:8.4::
:*?COZ:9.4::
:*?COZ:0.4::
:*?COZ:1.5::
:*?COZ:2.5::
:*?COZ:3.5::
:*?COZ:4.5::
:*?COZ:5.5::
:*?COZ:6.5::
:*?COZ:7.5::
:*?COZ:8.5::
:*?COZ:9.5::
:*?COZ:0.5::
:*?COZ:1.6::
:*?COZ:2.6::
:*?COZ:3.6::
:*?COZ:4.6::
:*?COZ:5.6::
:*?COZ:6.6::
:*?COZ:7.6::
:*?COZ:8.6::
:*?COZ:9.6::
:*?COZ:0.6::
:*?COZ:1.7::
:*?COZ:2.7::
:*?COZ:3.7::
:*?COZ:4.7::
:*?COZ:5.7::
:*?COZ:6.7::
:*?COZ:7.7::
:*?COZ:8.7::
:*?COZ:9.7::
:*?COZ:0.7::
:*?COZ:1.8::
:*?COZ:2.8::
:*?COZ:3.8::
:*?COZ:4.8::
:*?COZ:5.8::
:*?COZ:6.8::
:*?COZ:7.8::
:*?COZ:8.8::
:*?COZ:9.8::
:*?COZ:0.8::
:*?COZ:1.9::
:*?COZ:2.9::
:*?COZ:3.9::
:*?COZ:4.9::
:*?COZ:5.9::
:*?COZ:6.9::
:*?COZ:7.9::
:*?COZ:8.9::
:*?COZ:9.9::
:*?COZ:0.9::
:*?COZ:1.0::
:*?COZ:2.0::
:*?COZ:3.0::
:*?COZ:4.0::
:*?COZ:5.0::
:*?COZ:6.0::
:*?COZ:7.0::
:*?COZ:8.0::
:*?COZ:9.0::
:*?COZ:0.0::
{
    ; :*?COZ:0.0
    Str := ThisHotkey

    Arr := StrSplit(Str, ".")
    ; ToolTip(Arr[2])
    switch Arr[2] {
        case "1":
            Symbol := "1"
        case "2":
            Symbol := "2"
        case "3":
            Symbol := "3"
        case "4":
            Symbol := "4"
        case "5":
            Symbol := "5"
        case "6":
            Symbol := "6"
        case "7":
            Symbol := "7"
        case "8":
            Symbol := "8"
        case "9":
            Symbol := "9"
        case "0":
            Symbol := "0"
    }

    ; :*?COZ:0
    PreArr := StrSplit(Arr[1], ":")
    ; ToolTip(PreArr[3])
    switch PreArr[3] {
        case "1":
            Pre := "1"
        case "2":
            Pre := "2"
        case "3":
            Pre := "3"
        case "4":
            Pre := "4"
        case "5":
            Pre := "5"
        case "6":
            Pre := "6"
        case "7":
            Pre := "7"
        case "8":
            Pre := "8"
        case "9":
            Pre := "9"
        case "0":
            Pre := "0"
    }

    SendInput(Pre . "{U+002E}" . Symbol)
}

:?B0COZ:cui2:: {
    if IsCnIME()
    {
        Send("{BackSpace 1}")
        SendInput("cuijervis@126.com")
    }
    else {
        Send("{BackSpace 3}")
        SendInput("cuijervis@126.com")
    }
}

:?COZ:sj:: {
    TimeString := FormatTime(, "yyyy-MM-dd hh:mm:ss")
    ; ToolTip(TimeString)
    if IsCnIME()
    {
        TimeString := StrReplace(TimeString, ":", "{U+003A}")
    }
    SendInput(TimeString)
}

:?COZ:rq:: {
    TimeString := FormatTime(, "yyyy-MM-dd")
    SendInput(TimeString)
}

;#region select text to convert en punctuation
ToFullWidth := Map(
    ",", "，",
    ".", "。",
    "?", "？",
    ";", "；",
    ":", "：",
    "!", "！",
    "<", "《",
    ">", "》",
    "/", "、",
    "(", "（",
    ")", "）",
    "[", "【",
    "]", "】"
)

ToHalfWidth := Map(
    "，", ",",
    "。", ".",
    "？", "?",
    "；", ";",
    "：", ":",
    "！", "!",
    "《", "<",
    "》", ">",
    "、", ",",
    "（", "(",
    "）", ")",
    "【", "[",
    "】", "]",
    "‘", "'",
    "’", "'",
    "“", "`"",
    "”", "`""
)

F14:: {
    Old := A_Clipboard
    A_Clipboard := ""

    Sleep(10)
    Send("^c")

    if ClipWait(1)
    {
        Txt := A_Clipboard
        ; ToolTip(Txt)

        if IsCnIME()
        {
            for k, v in ToFullWidth
            {
                Txt := StrReplace(Txt, k, v)
            }

            Txt := RegExReplace(Txt, "S)'(.*)'", "‘$1’")
            Txt := RegExReplace(Txt, "S)`"(.*)`"", "“$1”")
            ; clear space
            Txt := RegExReplace(Txt, "S)[\t ]*([，。？；：！《》、（）【】‘’“”])[\t ]*", "$1")
        }
        else
        {
            for k, v in ToHalfWidth
            {
                Txt := StrReplace(Txt, k, v)
            }

            ; clear space
            Txt := RegExReplace(Txt, "S)[\t ]*([\,\.\?\;\:\!\<\>\(\)\[\]'`"])[\t ]*", "$1")
            ; add precede space
            Txt := RegExReplace(Txt, "('.+?')", " $1 ")
            Txt := RegExReplace(Txt, "S)(`".+?`")", " $1 ")
            Txt := RegExReplace(Txt, "S)([\(\[]+)[\t ]*", " $1")
            ; add follwed space
            Txt := RegExReplace(Txt, "S)[\t ]*([\)\]]+)", "$1 ")
            Txt := RegExReplace(Txt, "S)[\t ]*([\,\.\?\;\:\!])[\t ]*", "$1 ")
        }

        A_Clipboard := Txt
        ClipWait
        Send("^v")

        Sleep(1000)

        A_Clipboard := ""
        Txt := ""
    }

    A_Clipboard := Old
    Old := ""
}
;#endregion
