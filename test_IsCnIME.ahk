#Requires AutoHotkey v2.0

#Include <IsCnIME>

failures := []

ExpectTrue(
    IsChineseImeState({
        Layout: KeyboardLayoutId["cn"],
        OpenStatus: 1,
        HasConversionStatus: true,
        Conversion: 0x401
    }),
    "Chinese layout with native conversion should be treated as Chinese",
    &failures
)

ExpectFalse(
    IsChineseImeState({
        Layout: KeyboardLayoutId["cn"],
        OpenStatus: 0,
        HasConversionStatus: true,
        Conversion: 0
    }),
    "Closed IME should not be treated as Chinese",
    &failures
)

ExpectFalse(
    IsChineseImeState({
        Layout: KeyboardLayoutId["en"],
        OpenStatus: 1,
        HasConversionStatus: true,
        Conversion: 0x401
    }),
    "English layout should win over a stale native conversion flag",
    &failures
)

ExpectFalse(
    IsChineseImeState({
        Layout: KeyboardLayoutId["cn"],
        OpenStatus: 1,
        HasConversionStatus: true,
        Conversion: 0
    }),
    "Chinese layout in alphanumeric mode should not be treated as Chinese",
    &failures
)

if failures.Length {
    for message in failures {
        FileAppend("FAIL: " message "`n", "*")
    }
    ExitApp(1)
}

FileAppend("PASS`n", "*")
ExitApp(0)

ExpectTrue(Value, Message, &Failures)
{
    if !Value {
        Failures.Push(Message)
    }
}

ExpectFalse(Value, Message, &Failures)
{
    if Value {
        Failures.Push(Message)
    }
}
