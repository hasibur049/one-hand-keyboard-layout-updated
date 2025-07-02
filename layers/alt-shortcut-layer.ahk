/*
   --------------------------------------------------
   --------------------------------------------------
   -------press alt to active normal layer 2---------
   --------------------------------------------------
   --------------------------------------------------
*/

NormalLabelAlt() {
    global VIM_NORMAL_SPACE_MODE
    global NORMAL_ALT_MODE
    global NUMBER_MODE
    global SYMBOL_MODE
    global INSERT_MODE
    global INSERT_MODE_II

    if !NORMAL_ALT_MODE {
        NORMAL_ALT_MODE := true
        VIM_NORMAL_SPACE_MODE := false
        NUMBER_MODE := false
        SYMBOL_MODE := false
        INSERT_MODE := false
        INSERT_MODE_II := false

        ToolTip(, , , 2)
        ToolTip(, , , 4)
        ToolTip(, , , 5)
        ToolTip("Normal 2", normal_TooltipX_Alt, 0, 9)
    }
}

#HotIf NORMAL_ALT_MODE
;$1::#^c ;shortcut key to TOGGLE invert color filter
$1:: Send "{PrintScreen}"
$2:: Send "{LWin}"
$3:: Send "{F5}"
$4:: Reload() ; Hotkey to reload the script
$5:: Suspend() ; Hotkey to suspend the script

$s:: MouseClick "left"
$d:: Send "{WheelUp 3}" ;scrollspeed:=5
$f:: Send "{WheelDown 3}" ;scrollspeed:=5


;$Alt::
$Space::
{
    global NORMAL_ALT_MODE
    global VIM_NORMAL_SPACE_MODE
    global NUMBER_MODE
    global SYMBOL_MODE
    global INSERT_MODE
    global INSERT_MODE_II
    global TOGGLE

    ToolTip(, , , 2)
    ToolTip(, , , 4)
    ToolTip(, , , 5)
    ToolTip(, , , 9)

    NORMAL_ALT_MODE := false
    VIM_NORMAL_SPACE_MODE := false
    NUMBER_MODE := false
    SYMBOL_MODE := false
    INSERT_MODE := true

    if TOGGLE {
        INSERT_MODE_II := true

        ToolTip("Index", index_TooltipX, 0, 1)
    }

    if LongPress(200) {
        if WinActive("ahk_class Chrome_WidgetWin_1 ahk_exe Code.exe") {
            Send "{Esc}"
            Vim_NormalLabelSpace()  ; Trigger Vim_NormalLabelSpace if VS Code is active
        }
    }
}

;~Alt Up:: InStr(A_PriorKey, 'Alt') && Send('{Esc}')
; https://www.autohotkey.com/boards/viewtopic.php?style=7&t=127153
#HotIf