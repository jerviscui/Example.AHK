; $F1:: AltTab()
$F2:: AltTabMenu()

; AltTab-replacement for Windows 8:
AltTab() {
    ; list := ""
    ; WinGetList(,), id, list
    ; Loop, %id%
    ; {
    ;     this_ID := id%A_Index%
    ;     IfWinActive, ahk_id %this_ID%
    ;     continue
    ;     WinGetTitle, title, ahk_id %this_ID%
    ;     If (title = "")
    ;         continue
    ;     If (!IsWindow(WinExist("ahk_id" . this_ID)))
    ;         continue
    ;     WinActivate, ahk_id %this_ID%
    ;     WinWaitActive, ahk_id %this_ID%, , 2
    ;     break
    ; }

    ids := WinGetList(, , "")
    for this_id in ids
    {
        WinActivate this_id
        this_class := WinGetClass(this_id)
        this_title := WinGetTitle(this_id)
        Result := MsgBox(
            (
                "Visiting All Windows
        " A_Index " of " ids.Length "
        ahk_id " this_id "
        ahk_class " this_class "
        " this_title "

        Continue?"
            ), , 4)
        if (Result = "No")
            break
    }
}

; AltTabMenu-replacement for Windows 8:
AltTabMenu() {
    ; list := ""
    ; Menu, windows, Add
    ; Menu, windows, deleteAll
    ; WinGet, id, list
    ; Loop, %id%
    ; {
    ;     this_ID := id%A_Index%
    ;     WinGetTitle, title, ahk_id %this_ID%
    ;     If (title = "")
    ;         continue
    ;     If (!IsWindow(WinExist("ahk_id" . this_ID)))
    ;         continue
    ;     Menu, windows, Add, %title%, ActivateTitle
    ;     WinGet, Path, ProcessPath, ahk_id %this_ID%
    ;     Try
    ;         Menu, windows, Icon, %title%, %Path%, , 0
    ;     Catch
    ;         Menu, windows, Icon, %title%, %A_WinDir%\System32\SHELL32.dll, 3, 0
    ; }
    ; CoordMode, Mouse, Screen
    ; MouseMove, (0.4 * A_ScreenWidth), (0.35 * A_ScreenHeight)
    ; CoordMode, Menu, Screen
    ; Xm := (0.25 * A_ScreenWidth)
    ; Ym := (0.25 * A_ScreenHeight)
    ; Menu, windows, Show, %Xm%, %Ym%
}

; ActivateTitle:
;     SetTitleMatchMode 3
;     WinActivate(, A_ThisMenuItem)
;     return

;-----------------------------------------------------------------
; Check whether the target window is activation target
;-----------------------------------------------------------------
; IsWindow(hWnd) {
;         WinGet, dwStyle, Style, ahk_id %hWnd%
;         if ((dwStyle & 0x08000000) || !(dwStyle & 0x10000000)) {
;             return false
;         }
;         WinGet, dwExStyle, ExStyle, ahk_id %hWnd%
;         if (dwExStyle & 0x00000080) {
;             return false
;         }
;         WinGetClass, szClass, ahk_id %hWnd%
;         if (szClass = "TApplication") {
;             return false
;         }
;         return true
;     }


; timeInterval := 500

; GetImeState(id) {
;     return SendMessage(0x283, ; WM_IME_CONTROL
;         ; 0x005, ; IMC_GETOPENSTATUS
;         0x001, ; wParam IMC_SETCONVERSIONMODE
;         0, ; lParam (NoArgs)
;         , ; Control (Window)
;         id)
; }

; SwitchImeState(id) {
;     SendMessage(0x283, ; WM_IME_CONTROL
;         ; 0x006, ; IMC_GETOPENSTATUS
;         0x002, ; wParam IMC_SETCONVERSIONMODE
;         1025, ; lParam (Chinese)
;         , ; Control (Window)
;         id)
; }

; DetectHiddenWindows True

; outer:
;     Loop {
;         try {
;             hWnd := WinGetID("A")
;         } catch as e {
;             ; ^Esc 开始菜单弹窗，会卡死在找不到当前窗口
;             continue("outer")
;         }
;         id := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")

;         if (GetImeState(id) == 0) {
;             SwitchImeState(id)
;         }

;         Sleep 10000
;     }

#Include <IsCnIME>

; #HotIf GetKeyState("Ctrl", "P")
; *Shift:: {
;     ; SwitchToCn()
;     ToolTip(A_Now)
; }
; #HotIf

; SetTimer Mainloop, 3000

; MainLoop() {
;     SwitchToCn()
; }

; $^Shift:: {
;     ; SwitchToCn()
;     ToolTip(A_Now)
; }
