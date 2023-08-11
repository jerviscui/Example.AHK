/*
Description = 快速输出数字键对应的符号和F键
*/
#Requires AutoHotkey v2.0

#SingleInstance Force

CoordMode "ToolTip", "Screen"

SendMode "Event"
SetKeyDelay(-1, 0)
A_MenuMaskKey := "vkFF"  ; vkFF 是未映射的

;#region Windows Virtual Desktop
$#-:: {
    Send("#^{Left}")
}

$#=:: {
    Send("#^{Right}")
}
;#endregion

;#region Number output Numeric symbol and F1~F10

; time := DllCall("GetDoubleClickTime")
time := 230

DoubleClick(VK)
{
    ; ToolTip(A_TimeSincePriorHotkey)
    if (A_PriorHotKey = A_ThisHotkey && A_TimeSincePriorHotkey > 100 && A_TimeSincePriorHotkey < time)
    {
        Send("{Backspace}+" . VK)

        return
    }

    Send(VK)
}

global Pressed := false

$F12:: {
    global Pressed

    Pressed := true
    startTime := A_TickCount + 400
    while startTime > A_TickCount
    {
        if GetKeyState("1", "P")
        {
            Pressed := false
            Send("{F1}")
            return
        }
        if GetKeyState("2", "P")
        {
            Pressed := false
            Send("{F2}")
            return
        }
        if GetKeyState("3", "P")
        {
            Pressed := false
            Send("{F3}")
            return
        }
        if GetKeyState("4", "P")
        {
            Pressed := false
            Send("{F4}")
            return
        }
        if GetKeyState("5", "P")
        {
            Pressed := false
            Send("{F5}")
            return
        }
        if GetKeyState("6", "P")
        {
            Pressed := false
            Send("{F6}")
            return
        }
        if GetKeyState("7", "P")
        {
            Pressed := false
            Send("{F7}")
            return
        }
        if GetKeyState("8", "P")
        {
            Pressed := false
            Send("{F8}")
            return
        }
        if GetKeyState("9", "P")
        {
            Pressed := false
            Send("{F9}")
            return
        }
        if GetKeyState("0", "P")
        {
            Pressed := false
            Send("{F10}")
            return
        }

        Sleep(10)
    }

    Pressed := false
    Send("{F12}")
}

$1:: {
    if Pressed
    {
        return
    }

    DoubleClick("1")
}
$2:: {
    if Pressed
    {
        return
    }

    DoubleClick("2")
}
$3:: {
    if Pressed
    {
        return
    }

    DoubleClick("3")
}
$4:: {
    if Pressed
    {
        return
    }

    DoubleClick("4")
}
$5:: {
    if Pressed
    {
        return
    }

    DoubleClick("5")
}
$6:: {
    if Pressed
    {
        return
    }

    DoubleClick("6")
}
$7:: {
    if Pressed
    {
        return
    }

    DoubleClick("7")
}
$8:: {
    if Pressed
    {
        return
    }

    DoubleClick("8")
}
$9:: {
    if Pressed
    {
        return
    }

    DoubleClick("9")
}
$0:: {
    if Pressed
    {
        return
    }

    DoubleClick("0")
}
;#endregion
