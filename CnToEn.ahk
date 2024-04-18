/*
Description = 中英文符号互换
*/
; #Requires AutoHotkey v2.0

; #SingleInstance Force

; ; SendMode "Event"
; SetKeyDelay(-1, 0)
; A_MenuMaskKey := "vkFF"  ; vkFF 是未映射的

; 返回当前输入法的中英文状态
IsCnIME(WinTitle := "A")
{
    try {
        hWnd := WinGetID(WinTitle)
    } catch Error as err {
        ; ^Esc 开始菜单弹窗，会卡死在找不到当前窗口
        return
    }

    DetectHiddenWindows True
    result := SendMessage(
        0x283,  ; Message : WM_IME_CONTROL
        0x005,  ; wParam  : IMC_GETOPENSTATUS
        0,      ; lParam  ： (NoArgs)
        ,       ; Control ： (Window)
        "ahk_id " DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")
    )
    DetectHiddenWindows False

    ; 1 非英文状态
    ; 0 英文状态
    return result
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

:*?COZ:1. ::
:*?COZ:2. ::
:*?COZ:3. ::
:*?COZ:4. ::
:*?COZ:5. ::
:*?COZ:6. ::
:*?COZ:7. ::
:*?COZ:8. ::
:*?COZ:9. ::
:*?COZ:0. ::
{
    switch ThisHotkey {
        case ":*?COZ:1. ":
            Symbol := "1"
        case ":*?COZ:2. ":
            Symbol := "2"
        case ":*?COZ:3. ":
            Symbol := "3"
        case ":*?COZ:4. ":
            Symbol := "4"
        case ":*?COZ:5. ":
            Symbol := "5"
        case ":*?COZ:6. ":
            Symbol := "6"
        case ":*?COZ:7. ":
            Symbol := "7"
        case ":*?COZ:8. ":
            Symbol := "8"
        case ":*?COZ:9. ":
            Symbol := "9"
        case ":*?COZ:0. ":
            Symbol := "0"
    }

    SendInput(Symbol . "{U+002E}{Space}")
}

:*?COZ:.1::
:*?COZ:.2::
:*?COZ:.3::
:*?COZ:.4::
:*?COZ:.5::
:*?COZ:.6::
:*?COZ:.7::
:*?COZ:.8::
:*?COZ:.9::
:*?COZ:.0::
{
    switch ThisHotkey {
        case ":*?COZ:.1":
            Symbol := "1"
        case ":*?COZ:.2":
            Symbol := "2"
        case ":*?COZ:.3":
            Symbol := "3"
        case ":*?COZ:.4":
            Symbol := "4"
        case ":*?COZ:.5":
            Symbol := "5"
        case ":*?COZ:.6":
            Symbol := "6"
        case ":*?COZ:.7":
            Symbol := "7"
        case ":*?COZ:.8":
            Symbol := "8"
        case ":*?COZ:.9":
            Symbol := "9"
        case ":*?COZ:.0":
            Symbol := "0"
    }

    SendInput("{U+002E}" . Symbol)
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

F13:: {
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
