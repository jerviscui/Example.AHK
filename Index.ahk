#Requires AutoHotkey v2.0

#SingleInstance Force

; SendMode "Event"
SetKeyDelay(-1, 0)
A_MenuMaskKey := "vkFF"  ; vkFF 是未映射的

; Combined Script
#Include CnToEn.ahk
#Include QmkStatus.ahk
; #Include QuickSymbol.ahk ;$1:: 和 :*?COZ:1. :: 冲突
