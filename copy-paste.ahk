#NoEnv
#SingleInstance Force
/*
TT copy-paste Lite script V.2 (Version 2) - or - '2 percent of power left' survival helper method for Autohotkey,
This Autohotkey scritpt allows you to copy and paste a way more easier and faster,
as well as other operations.
The main idea is:
You just need to hold a Tab key, never release it, when you are copying anything.
It should  work perfectly for both - for text, and for files, too.

It is working like this:
If you just press Tab key as usually - the AHK program will send a 'Tab'  Keystroke for the System.
If you press Tab key, and hold it pressed, then press 1 (Top1 key) for example. Then the AHK program will send a 'Ctrl + C'  Keystrokes for the System.
Do not release Tab key, just continue pressing something. - If you press 2 (Top2 key) for example,  the AHK program will send a 'Ctrl + V'  Keystrokes for the System. Because the program was 'understand', that the Tab key, was in 'hold' position. So the AHK program should activate Ctrl key, and to add it to 'V Keystroke' automatically.
And if you press S keyboard key, for example after that, the AHK program will send a Keystroke of 'Enter' key to the System, because it was preprogrammed into the  script before. Even when you are still holding Tab key pressed, the AHK program will make the correct decision - not work as Ctrl Keystroke any more, but do the 'Enter' key.
In another words - you just holding one key of the keyboard, and the program is helping to you to press/to add - more additional  Keystrokes simultaneously. And it is doing it very quick.
And because your fingers are like a bunch - always together, you would be probably less tired of your 'Copy-Paste' operations work, as well.

The 'live' example of how that is working:
First, if you just press Tab, and hold it.
Then go to Window1.
Double click on your text's word by Left Mouse button - to select all word.
Press - 1 key (Top1 key. Continue holding the Tab key).
Go to Window2.
Click just once in that field by Left Mouse button, in place you need to put a word.
Press - 2 key (Top2 key. Continue holding the Tab key).
And you would see the word should appear in Window2.
Press - S key (Continue holding the Tab key), to go to next Line in Window2.
Then return to Window1, and select another word.
- And the speed start to be x2 for your 'Copy-Paste' process, if you will be training a bit (or you'll get into this a little  bit).

Note: Alt + Tab keystrokes do not work for switching the Windows (for fast jump from one window to another), if the 'TT copy-paste Lite' script is enabled. You need to suspend it manually, pressing 'End' keyboard key.

I have set the 'End' key - for Suspend toggle.

It should  work perfectly for both - for text, and for files, too.
Thank you, very much!

The main hotkeys are:
Tab + Top1 - for Copy;
Tab + Top2 - for Paste;
Tab + Top4 - for Select All;
Tab + S - for Enter;
Tab + D - for Enter, too;
Shift + Tab	- just in case, if Tab itself had any glitches
End - for Suspend toggle
CTRL + ALT + SHIFT + WIN + F12 - for quick script Exit
*/

;START OF CONFIG SECTION
#MaxHotkeysPerInterval 500
; #NoTrayIcon
#KeyHistory 0
SetBatchLines -1
ListLines, Off
SendMode Input ; Forces Send and SendRaw to use SendInput buffering for speed. Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir, %A_ScriptDir% ; Ensures a consistent starting directory.
; SplitPath, A_ScriptName, , , , MyScriptName ; store the script file name (without extension) in MyScriptName
; DetectHiddenWindows,On
; SetWinDelay, -1 ; Remove short delay done automatically after every windowing command except IfWinActive and IfWinExist
; SetKeyDelay, -1, -1 ; Remove short delay done automatically after every keystroke sent by Send or ControlSend
; SetMouseDelay,-1 ; Remove short delay done automatically after Click and MouseMove/Click/Drag
; MaxThreadsPerHotkey,1 ; no re-entrant hotkey handling
; #Warn  ; Enable warnings to assist with detecting common errors.
; Hook hotkeys are smart enough to ignore such keystrokes.
; #UseHook

;END OF CONFIG SECTION

;This is needed or key presses would faulty send their natural
;actions. Like NumPadDiv would send sometimes "/" to the
;screen.
; #InstallKeybdHook

Temp = 0
Temp2 = 0


	#UseHook, On   ; in case if a key would send command
; as "itself". It works as prefix $, button
; just for all that keys, that are lower in the list.

#IfWinActive
Tab & 1:: Send ^ { c }						; Tab + Top1							Copy to Clipboard (Send: Ctrl + C keys)
Tab & 2:: Send ^ { v }						; Tab + Top2							Paste from Clipboard (Send: Ctrl + V keys)
Tab & 4:: Send ^ { a }						; Tab + Top4							Select All (Send: Ctrl + A keys)
Tab & s:: Send { Enter }					; Tab + S								Send: Enter key
Tab & d:: Send { Enter }					; Tab + D								Send: Enter key
+Tab::+Tab							; Shift + Tab							Send: Shift + Tab keys (just in case, if Tab had any glitches)
return

^!+#F12:: ExitApp ; press CTRL + ALT + SHIFT + WIN + F12 keys for quick script Exit
End:: Suspend, Toggle ; press End key for Suspend Toggle
return
;~

Tab::
Send { Tab } ; Send: Tab key
return
