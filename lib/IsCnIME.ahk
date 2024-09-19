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
