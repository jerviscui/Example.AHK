/*
Description = 中英文符号互换
*/
#Requires AutoHotkey v2.0

#SingleInstance Force

SendMode "Event"
SetKeyDelay(-1, 0)
A_MenuMaskKey := "vkFF"  ; vkFF 是未映射的

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
:?COZ:,:: {
    if IsCnIME()
    {
        SendInput("{U+002C}")
    }
    else
    {
        SendInput("{U+FF0C}")
    }
}

; . to 。
:?COZ:.:: {
    if IsCnIME()
    {
        SendInput("{U+002E}")
    }
    else
    {
        SendInput("{U+3002}")
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
        SendInput("{U+300A}{U+300B}{Left}")
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
        return
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
        return
        ; SendInput("{U+300B}")
    }
}

; < to 《
:?COZ:<:: {
    if IsCnIME()
    {
        SendInput("{U+003C}")
    }
    else
    {
        SendInput("{U+300A}")
    }
}

; 》 > to > 
:?COZ:>:: {
    if IsCnIME()
    {
        SendInput("{U+003E}")
    }
    else
    {
        SendInput("{U+300B}")
    }
}

; / to 、
:?COZ:/:: {
    if IsCnIME()
    {
        SendInput("{U+002F}")
    }
    else
    {
        SendInput("{U+3001}")
    }
}

; ? to ？
:?COZ:?:: {
    if IsCnIME()
    {
        SendInput("{U+003F}")
    }
    else
    {
        SendInput("{U+FF1F}")
    }
}

; ; to ；
:?COZ:;:: {
    if IsCnIME()
    {
        SendInput("{U+003B}")
    }
    else
    {
        SendInput("{U+FF1B}")
    }
}

; : to ：
:?COZ:`::: {
    if IsCnIME()
    {
        SendInput("{U+003A}")
    }
    else
    {
        SendInput("{U+FF1A}")
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
:?COZ:"":: {
    if IsCnIME()
    {
        SendInput("{U+0022}{U+0022}{Left}")
    }
    else
    {
        SendInput("{U+201C}{U+201D}{Left}")
    }
}

; \ to 、
:?COZ:\:: {
    if IsCnIME()
    {
        SendInput("{U+005C}")
    }
    else
    {
        SendInput("{U+3001}")
    }
}

; _ to ——
:?COZ:_:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+005F}")
    }
    else
    {
        SendInput("{U+2014}{U+2014}")
    }
}

; ! to ！
:?COZ:!:: {
    if IsCnIME()
    {
        SendInput("{U+0021}")
    }
    else
    {
        SendInput("{U+FF01}")
    }
}

; $ to ￥
:?COZ:$:: {
    if IsCnIME()
    {
        SendInput("{U+0024}")
    }
    else
    {
        SendInput("{U+FFE5}")
    }
}

; ^ to ……
:?COZ:^:: {
    if IsCnIME()
    {
        SendInput("{Backspace}{U+005E}")
    }
    else
    {
        SendInput("{U+2026}{U+2026}")
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
:?COZ:(:: {
    if IsCnIME()
    {
        SendInput("{U+0028}")
    }
    else
    {
        SendInput("{U+FF08}")
    }
}

; ) to ）
:?COZ:):: {
    if IsCnIME()
    {
        SendInput("{U+0029}")
    }
    else
    {
        SendInput("{U+FF09}")
    }
}

; ` to ·
:?COZ:``:: {
    if IsCnIME()
    {
        SendInput("{U+0060}")
    }
    else {
        SendInput("{U+00B7}")
    }
}

; 【【 to [[]]
:*?COZ:[[:: {
    if IsCnIME()
    {
        SendInput("{U+005B}{U+005B}{U+005D}{U+005D}{Left 2}")
    }
    else {
        return
        ; SendInput("{U+3010}{U+3010}{U+3011}{U+3011}{Left 2}")
    }
}

; [ to 【】
:?COZ:[:: {
    if IsCnIME()
    {
        SendInput("{U+005B}")
    }
    else {
        SendInput("{U+3010}")
    }
}

; ]; to 】
:?COZ:]:: {
    if IsCnIME()
    {
        SendInput("{U+005D}")
    }
    else {
        SendInput("{U+3011}")
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

    if IsCnIME()
    {
        SendInput(Symbol . "{U+002E}{Space}")
    }
    else {
        return
        ; SendInput(Symbol . "{U+3002}{Space}")
    }
}
