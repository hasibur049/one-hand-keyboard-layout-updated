; Main script that initializes modes and includes other script files.
#Requires AutoHotkey v2

#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\src\include.ahk"
#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\src\initialize.ahk"

;VsCodeWinActive := WinActive("ahk_class Chrome_WidgetWin_1 ahk_exe Code.exe")

WinEvent.Active(ActiveWindowChanged)
Persistent()

ActiveWindowChanged(hWnd, *) {
    global TOGGLE, INSERT_MODE, INSERT_MODE_II
    global VIM_NORMAL_SPACE_MODE
    global VISUAL_MODE

    VIM_NORMAL_SPACE_MODE := false
    VISUAL_MODE := false

    /*
    if !guiOpen
        INSERT_MODE := true
    else
        INSERT_MODE := false
    */

    INSERT_MODE := !guiOpen ;INSERT_MODE := !guiOpen is a shorter, cleaner way of writing the same logic above.

    if WinActive("ahk_class Chrome_WidgetWin_1 ahk_exe Code.exe") {
        ; Get the active window's title
        currentTitle := WinWaitActive(hWnd)  ; Retrieve title directly with function syntax

        VimModeLibrary(currentTitle)
    } else {

        ToolTip(, , , 2)
        ToolTip(, , , 4)
        ToolTip(, , , 5)
        ToolTip(, , , 10)

        if TOGGLE {
            INSERT_MODE_II := true

            ToolTip("Index", index_TooltipX, 0, 1)
        }
    }
}

VimModeLibrary(activeTitle) {
    global TOGGLE, INSERT_MODE, INSERT_MODE_II
    global VIM_NORMAL_SPACE_MODE
    global VISUAL_MODE

    ; Get the Vim mode element
    VimStatusEl := UIA.ElementFromHandle(activeTitle)

    try {
        match := VimStatusEl.FindElement({ AutomationId: "vscodevim.vim.primary" }) ; Try finding the element
    } catch {
        ; Handle the error if element is not found
        ; MsgBox("Error: An element matching the condition was not found.")
        return
    }

    mode := match.Name  ; Get the current mode from the UI

    ;if (mode == "-- INSERT --")
    if (mode == "-- NORMAL --")
        Vim_NormalLabelSpace()
    else if (mode == "-- VISUAL --")
        Vim_VisualLabel()
    else
    {
        ToolTip(, , , 2)
        ToolTip(, , , 10)

        VIM_NORMAL_SPACE_MODE := false
        VISUAL_MODE := false
        INSERT_MODE := true

        if TOGGLE {
            INSERT_MODE_II := true

            ToolTip("Index", index_TooltipX, 0, 1)
        }
    }
}

;-----------------------------------------------------------------------------
/*
   ----------------------------------------------
   ----------------------------------------------
   ------------Other modifier key----------------
   ----------------------------------------------
   ----------------------------------------------
*/

LShift & d::
LCtrl & d::
{
    global TOGGLE, INSERT_MODE_II

    ; TOGGLE the INSERT_MODE_II state
    INSERT_MODE_II := !INSERT_MODE_II
    if INSERT_MODE_II {
        ssTOGGLE := true
        ToolTip("Index", index_TooltipX, 0, 1)
    } else {
        TOGGLE := false
        ToolTip("", , , 1)
    }
}

LCtrl & a::
{
    if WinActive("ahk_class Chrome_WidgetWin_1 ahk_exe Code.exe")
        Send("^s")
    else
        Send("^x")
}

LCtrl & s:: Send("^z")  ; Send Ctrl+Z when either Ctrl+S is pressed
LCtrl & z:: Send("^c")  ; Send Ctrl+C when either Ctrl+Z is pressed
LCtrl & x:: Send("^v")  ; Send Ctrl+V when either Ctrl+X is pressed

;LWin::Alt
LCtrl & Space:: Suspend ; Hotkey to suspend the script
LCtrl & Alt:: Reload	; Hotkey to reload the script

Alt::
{
    if VIM_NORMAL_SPACE_MODE
        Send("a")

    NormalLabelAlt()
}

CapsLock::
{
    if VIM_NORMAL_SPACE_MODE
        Send("a")

    SymbolLebelCapsLock()
}

Tab::
{
    if VIM_NORMAL_SPACE_MODE
        Send("a")

    NumberLebelTab()
}

Space::
{
    if LongPress(200) {  ; Check if Space key is held down for more than 200ms

        if WinActive("ahk_class Chrome_WidgetWin_1 ahk_exe Code.exe") {
            Send "{Esc}"
            Vim_NormalLabelSpace()  ; Trigger Vim_NormalLabelSpace if VS Code is active
        }
    } else {
        Send "{Space}" ; Action for short press
    }
}

; -------------------------------------------------------------------------

#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\layers\insert-layer.ahk"
;#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\hotkeys\modifier-key.ahk"
#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\layers\vscode-vim-layer.ahk"
#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\layers\tab-num-layer.ahk"
#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\layers\caps-symbol-layer.ahk"
#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\layers\down-symbol-layer.ahk"
#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\layers\right-num-layer.ahk"
#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\layers\alt-shortcut-layer.ahk"
#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\gui\gui.ahk"
#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\productivity\hotstring.ahk"
#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\productivity\chrome.ahk"
#Include "D:\PleaseGodHelpMe\one-hand-keyboard-layout-updated\productivity\volume.ahk"


/*
   ----------------------------------------------
   ----------------------------------------------
   -------------Other additional code------------
   ----------------------------------------------
   ----------------------------------------------
*/

tapMode(physicalKey, shortTap, longTap)
{
    if (physicalKey == "" && longTap == "") {
        Send("{blind}{" shortTap "}")
    }
    else {
        ErrorLevel := !KeyWait(physicalKey, "T0.16")

        if (ErrorLevel) {
            SetKeyDelay(-1)
            Send("{blind}{" longTap "}")
        }
        else {
            SetKeyDelay(-1)
            Send("{blind}{" shortTap "}")
        }

        ErrorLevel := !KeyWait(physicalKey)
        return
    }
}

indexMode(key) {
    ; Check if Ctrl is pressed
    if GetKeyState("Ctrl", "P") {
        SendInput("{Ctrl down}" key "{Ctrl up}")  ; Send Ctrl+u

        ; Check if Alt is pressed
    } else if GetKeyState("Alt", "P") {
        SendInput("{Alt down}" key "{Alt up}")  ; Send Alt+u

        ; Check if Shift is pressed
    } else if GetKeyState("Shift", "P") {
        SendInput("{Shift down}" key "{Shift up}")  ; Send Shift+u (uppercase U)

        ; If no modifier is pressed
    } else
        SendInput(key)   ; Send lowercase u
}

LongPress(Timeout) {
    RegExMatch(Hotkey := A_ThisHotkey, "\W$|\w*$", &Key)
    KeyWait((Key && Key[0]))
    IF ((Key && Key[0]) Hotkey) != (A_PriorKey A_ThisHotkey)
        Exit()
    Return A_TimeSinceThisHotkey > Timeout
}

Morse(Timeout) {
    tout := Timeout / 1000
    key := RegExReplace(A_ThisHotKey, "[\*\~\$\#\+\!\^]")
    Loop {
        t := A_TickCount
        ErrorLevel := !KeyWait(key)
        Pattern .= A_TickCount - t > Timeout
        ErrorLevel := !KeyWait(key, "DT" tout)
        if (ErrorLevel)
            Return Pattern
    }
}