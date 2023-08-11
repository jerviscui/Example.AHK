/*
Description = 中英文符号互换
*/
#Requires AutoHotkey v2.0

#SingleInstance Force

SendMode "Event"
SetKeyDelay(-1, 0)
A_MenuMaskKey := "vkFF"  ; vkFF 是未映射的

MyGui := Gui("+LastFound +AlwaysOnTop +ToolWindow -Caption +Border +E0x08000000", "qmk status")
MyGui.SetFont("s9 bold", "Microsoft YaHei")
MyGui.BackColor := "Black"
WinSetTransparent(130, MyGui)
MyGui.MarginX := 5
MyGui.MarginY := 3

Txt := MyGui.Add("Text", "cWhite", "Num+Swap")

MyGui.Show("X50 Y30 NoActivate")