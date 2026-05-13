global KeyboardLayoutId := Map(
    "cn", 134481924, ;微软拼音
    "en", 67699721, ;英文
)

global ImeConversionMode := Map(
    "native", 0x0001
)

global WmImeControl := 0x0283
global ImcGetConversionMode := 0x0001
global ImcSetConversionMode := 0x0002
global ImcGetOpenStatus := 0x0005
global ImcSetOpenStatus := 0x0006

; 返回当前输入法的中英文状态
IsCnIME(WinTitle := "A")
{
    State := GetImeState(WinTitle)
    IsCn := State.Ok ? IsChineseImeState(State) : false
    ; ToolTip(IsCn)

    return IsCn
}

IsChineseImeState(State)
{
    if !IsObject(State) {
        return false
    }

    ; ToolTip(State.Layout . " " . " " . State.HasConversionStatus . " " . State.Conversion . " " . State.OpenStatus)

    IsChineseLayout := State.HasOwnProp("Layout") && State.Layout == KeyboardLayoutId["cn"]
    IsOpen := State.HasOwnProp("HasOpenStatus") && State.HasOpenStatus && State.OpenStatus
    HasNativeMode := !State.HasOwnProp("HasConversionStatus")
        || !State.HasConversionStatus
        || HasNativeConversionMode(State.Conversion)
    IsConsole := State.HasOwnProp("SourceClass") && State.SourceClass == "ConsoleWindowClass"

    if IsConsole {
        return IsOpen && HasNativeMode
    }

    return IsChineseLayout && IsOpen && HasNativeMode
}

GetImeState(WinTitle := "A")
{
    try {
        hWnd := WinGetID(WinTitle)
    } catch Error as err {
        ; ^Esc 开始菜单弹窗，会卡死在找不到当前窗口
        return { Ok: false }
    }

    SourceHwnd := GetImeSourceHwnd(hWnd)
    ThreadID := DllCall("GetWindowThreadProcessId", "Ptr", SourceHwnd, "UInt*", 0, "UInt")
    Layout := DllCall("GetKeyboardLayout", "UInt", ThreadID, "UPtr")
    SourceClass := ""
    try SourceClass := WinGetClass("ahk_id " SourceHwnd)
    State := {
        Ok: true,
        Hwnd: hWnd,
        SourceHwnd: SourceHwnd,
        ThreadID: ThreadID,
        Layout: Layout,
        HasOpenStatus: false,
        OpenStatus: 0,
        HasConversionStatus: false,
        Conversion: 0,
        DefaultImeWnd: 0,
        SourceClass: SourceClass
    }

    DefaultImeWnd := DllCall("imm32\ImmGetDefaultIMEWnd", "Ptr", SourceHwnd, "Ptr")
    if !DefaultImeWnd {
        return State
    }
    State.DefaultImeWnd := DefaultImeWnd

    if TryGetImeControl(DefaultImeWnd, ImcGetOpenStatus, &OpenStatus) {
        State.HasOpenStatus := true
        State.OpenStatus := OpenStatus
    }

    if TryGetImeControl(DefaultImeWnd, ImcGetConversionMode, &Conversion) {
        State.HasConversionStatus := true
        State.Conversion := Conversion
    }

    return State
}

GetImeSourceHwnd(hWnd)
{
    ThreadID := DllCall("GetWindowThreadProcessId", "Ptr", hWnd, "UInt*", 0, "UInt")
    guiThreadInfo := Buffer(A_PtrSize == 8 ? 72 : 48, 0)
    NumPut("UInt", guiThreadInfo.Size, guiThreadInfo)

    if DllCall("GetGUIThreadInfo", "UInt", ThreadID, "Ptr", guiThreadInfo, "Int") {
        FocusHwnd := NumGet(guiThreadInfo, A_PtrSize == 8 ? 16 : 12, "Ptr")
        if FocusHwnd {
            return FocusHwnd
        }
    }

    return hWnd
}

TryGetImeControl(DefaultImeWnd, Command, &Value)
{
    origin_detect_hidden_window := A_DetectHiddenWindows
    DetectHiddenWindows(True)
    try {
        Value := SendMessage(
            WmImeControl,
            Command,
            0,
            ,
            "ahk_id " DefaultImeWnd
        )
        return true
    } catch Error as err {
        Value := 0
        return false
    } finally {
        DetectHiddenWindows(origin_detect_hidden_window)
    }
}

HasNativeConversionMode(Conversion)
{
    return (Conversion & ImeConversionMode["native"]) != 0
}

SwitchToCn(WinTitle := "A")
{
    State := GetImeState(WinTitle)
    if !State.Ok {
        return false
    }

    if IsChineseImeState(State) {
        return true
    }

    ; 仅在已知中文布局或已有打开的 IME 上尝试切回中文，避免误伤真正的英文布局。
    CanSwitch := State.Layout == KeyboardLayoutId["cn"] || (State.HasOpenStatus && State.OpenStatus)
    if !CanSwitch {
        return false
    }

    if !State.DefaultImeWnd {
        return false
    }

    if State.HasOpenStatus && !State.OpenStatus {
        if !TrySetImeControl(State.DefaultImeWnd, ImcSetOpenStatus, 1) {
            return false
        }
    }

    if State.HasConversionStatus {
        return TrySetImeControl(
            State.DefaultImeWnd,
            ImcSetConversionMode,
            State.Conversion | ImeConversionMode["native"]
        )
    }

    return true
}

TrySetImeControl(DefaultImeWnd, Command, Value)
{
    origin_detect_hidden_window := A_DetectHiddenWindows
    DetectHiddenWindows(True)
    try {
        SendMessage(
            WmImeControl,
            Command,
            Value,
            ,
            "ahk_id " DefaultImeWnd
        )
        return true
    } catch Error as err {
        return false
    } finally {
        DetectHiddenWindows(origin_detect_hidden_window)
    }
}
