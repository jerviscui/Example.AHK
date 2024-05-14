/*
[NewScriptTemplate]
Description = 方向键映射
问题：
1. Alt 按住时，会不断触发 Alt up down 从而不断激活窗口的工具栏，
2. shift + alt 不能触发，需要再单独映射。
*/
#Requires AutoHotkey v2.0

#SingleInstance Force

SendMode "Event"
SetKeyDelay(-1, 0)
A_MenuMaskKey := "vkFF"  ; vkFF 是未映射的

; 屏蔽 Alt 原有功能，貌似还是会激活菜单栏
; https://www.autohotkey.com/boards/viewtopic.php?p=354621&sid=bc25eb5f19d3e62bd022881b16208519#p354621
!x:: Reload
*Alt:: Send '{Blind}{Alt down}'
*Alt up:: {
    if InStr(A_PriorKey, "Alt")
        Send '{Blind}{Ctrl}{Alt up}'  ; "Mask" the Alt-up event.
    else
        Send '{Blind}{Alt up}'
    return
}

;#region Windows Virtual Desktop
$#-:: {
    Send("#^{Left}")
}

$#=:: {
    Send("#^{Right}")
}
;#endregion

$!i:: Send "{Up}"
$!j:: Send "{Left}"
$!k:: Send "{Down}"
$!l:: Send "{Right}"

; $!e:: Send "{Up}"
; $!s:: Send "{Left}"
; $!d:: Send "{Down}"
; $!f:: Send "{Right}"

$!y:: Send "{Home}"
$!u:: Send "{End}"
$!n:: Send "{PgDn}"
$!p:: Send "{PgUp}"

; 左Win键+鼠标滚轮切换虚拟桌面
<#WheelUp::#^Left
<#WheelDown::#^Right

; 左Alt键+鼠标滚轮切换窗口
; <!WheelUp:: ShiftAltTab
; <!WheelDown:: AltTab

;Browser_Forward & Browser_Back
XButton2::!Right
XButton1::!Left
