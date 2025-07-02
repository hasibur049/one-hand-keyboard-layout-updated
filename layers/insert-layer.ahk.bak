/*
   ----------------------------------------------
   ----------------------------------------------
   -------------Basic letter typing--------------
   ----------------------------------------------
   ----------------------------------------------
*/

#HotIf INSERT_MODE ; Start of INSERT_MODE
; Detect if d is pressed and released without combination
$d::
{
    if KeyWait("d", "T0.1") ; Wait to see if the 'd' key is held down for 100ms
        return  ; If 'd' is held down, do nothing
    KeyWait("d")  ; Wait for the 'd' key to be released
    return
}

$d Up::
{
    global TOGGLE, INSERT_MODE_II ; https://www.autohotkey.com/boards/viewtopic.php?p=501239#p501239

    ; Check if d is pressed alone
    if (A_PriorKey != "d")
        return  ; If the prior key wasn't d alone, do nothing

    ; TOGGLE the INSERT_MODE_II state
    INSERT_MODE_II := !INSERT_MODE_II
    if INSERT_MODE_II {
        TOGGLE := true
        ToolTip("Index", index_TooltipX, 0, 1)
    } else {
        TOGGLE := false
        ToolTip("", , , 1)  ; Hides the tooltip
    }
    return
}

; Hotkeys for d & other N key combinations
~d & s:: Send "{Up}"
~d & f:: Send "{Down}"
~d & g::AltTab
~d & x:: Send "{Left}"
~d & v:: Send "{Right}"
~d & t:: Send "{Delete}"
~d & w:: Send "{Home} {Up} {End} {Enter}"
~d & r:: Send "{End} {Enter}"
~d & Space::
{
    if LongPress(200) {   ; Check if Space key is held down for more than 200ms
        ToolTip("Long Press Test!")
        SetTimer(() => ToolTip(""), -1000)  ; Clear the tooltip after 1 second
    } else
        Gui1Setup()  ; Call the function directly
}

#HotIf INSERT_MODE_II ; start of INSERT_MODE_II
;fn row
;*Esc::
*1::
{
    if GetKeyState("CapsLock", "T")  ; Check if CapsLock is on
        SetCapsLockState("Off")      ; Turn CapsLock off
    else
        SetCapsLockState("On")       ; Turn CapsLock on
}
*2:: Send "{Tab}"
*3:: Send("{Backspace}")
*4:: indexMode("x")
*5:: return

;top row
*q:: indexMode("z")
*w:: indexMode("b")
; Custom remapped Enter key
;*e::handleEnter()
*e:: Send "{Enter}"
*r:: indexMode("g")
*t:: indexMode("j")

;home row
*a:: indexMode("u")
*s:: indexMode("o")
*f:: indexMode("r")
*g:: indexMode("c")

;bottom row
;*LShift::Tab
*z:: indexMode("m")
*x:: indexMode("y")
*c:: indexMode("v")
*v:: indexMode("f")
*b:: indexMode("p")

;fn row
~Space & 1:: return
~Space & 2:: return
~Space & 3:: return
~Space & 4:: return
~Space & 5:: return
;top row
~Space & w:: Send 2
~Space & e:: Send 3
~Space & r:: Send 4
~Space & t:: Send "{-}"

/*
	[2] [3] [4] [-]
[+] [1] [0] [5] [9]
[*] [6] [7] [8] [.]

*/

;home row
~Space & a:: Send "{+}"
~Space & s:: Send 1
~Space & d:: Send 0
~Space & d Up::
{
    global INSERT_MODE_II
    INSERT_MODE_II := true

    ToolTip("Index", index_TooltipX, 0, 1)
}
~Space & f:: Send 5
~Space & g:: Send 9
;bottom row
~Space & z:: Send "{*}"
~Space & x:: Send 6
~Space & c:: Send 7
~Space & v:: Send 8
~Space & b:: Send "{.}"

#HotIf ;end of INSERT_MODE_II

;fn row
*1::
{
    if GetKeyState("CapsLock", "T")  ; Check if CapsLock is on
        SetCapsLockState("Off")      ; Turn CapsLock off
    else
        SetCapsLockState("On")       ; Turn CapsLock on
}
*2:: Send "{Tab}"

*3:: Send "{Enter}"
*4:: indexMode("x")
*5:: return

;top row
*q:: indexMode("q")
*w:: indexMode("h")
*e:: indexMode("t")
*r:: indexMode("i")
*t:: indexMode("p")

;home row
*a:: indexMode("s")
*s:: indexMode("e")
*f:: indexMode("a")
*g:: indexMode("w")

;bottom row
*z:: indexMode("n")
*x:: indexMode("l")
*c:: Send("{Backspace}")
*v:: indexMode("d")
*b:: indexMode("k")

;fn row
~Space & 1:: return
~Space & 2:: return
~Space & 3:: return
~Space & 4:: return
~Space & 5:: return

;top row
~Space & w:: tapMode("w", "/", "\") ; two key hotkey short/long
~Space & e:: tapMode("e", "-", "_") ; two key hotkey short/long
~Space & r:: tapMode("r", "=", "+") ; two key hotkey short/long
~Space & t:: tapMode("t", "&", "$") ; two key hotkey short/long

;home row
~Space & a:: tapMode("a", "!", "%") ; two key hotkey short/long
~Space & s:: tapMode("s", "`'", "`"") ; two key hotkey short/long
~Space & d:: tapMode("d", ";", ":") ; two key hotkey short/long
~Space & d Up::
{
    global INSERT_MODE_II

    INSERT_MODE_II := false
    ToolTip("", , , 1)  ; Hides the tooltip
}
~Space & f:: tapMode("f", ".", ",") ; two key hotkey short/long
~Space & g:: tapMode("g", "*", "?") ; two key hotkey short/long

;bottom row
~Space & z:: tapMode("z", "<", ">") ; two key hotkey short/long
~Space & x:: tapMode("x", "[", "]") ; two key hotkey short/long
~Space & c:: tapMode("c", "(", ")") ; two key hotkey
~Space & v:: tapMode("v", "{", "}") ; two key hotkey
~Space & b:: tapMode("b", "#", "@") ; two key hotkey short/long

#HotIf ;end of INSERT_M