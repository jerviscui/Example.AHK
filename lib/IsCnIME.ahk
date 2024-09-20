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

    AhkId := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")

    result := GetImeState(hWnd, AhkId)
    ; cn 微软拼音
    ; * 非英文状态：1025
    ; * 英文状态：0
    ; en
    ; * 英文状态：1025
    return (result.Id == KeyboardLayoutId["cn"] and result.Mod == 1025)
}

GetImeState(hWnd, AhkId)
{
    ThreadID := DllCall("GetWindowThreadProcessId", "UInt", hWnd, "UInt", 0)
    InputLocaleID := DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")

    origin_detect_hidden_window := A_DetectHiddenWindows
    DetectHiddenWindows(True)
    mod := SendMessage(
        0x283,  ; Message : WM_IME_CONTROL
        0x001,  ; wParam : IMC_GETCONVERSIONMODE
        ; 0x005,  ; wParam  : IMC_GETOPENSTATUS
        0,      ; lParam  ： (NoArgs)
        ,       ; Control ： (Window)
        "ahk_id " AhkId
    )
    DetectHiddenWindows(origin_detect_hidden_window)

    Result := { Id: InputLocaleID, Mod: mod }

    return Result
}

SwitchToCn(WinTitle := "A")
{
    try {
        hWnd := WinGetID(WinTitle)
    } catch Error as err {
        ; ^Esc 开始菜单弹窗，会卡死在找不到当前窗口
        return
    }

    AhkId := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")

    result := GetImeState(hWnd, AhkId)

    if (result.Id == KeyboardLayoutId["cn"] and result.Mod == 0) {
        origin_detect_hidden_window := A_DetectHiddenWindows
        DetectHiddenWindows(True)
        SendMessage(
            0x283,  ; Message : WM_IME_CONTROL
            0x002,  ; wParam IMC_SETCONVERSIONMODE
            1025,      ; lParam  ： (NoArgs)
            ,       ; Control ： (Window)
            "ahk_id " . AhkId
        )
        DetectHiddenWindows(origin_detect_hidden_window)
    }
}
