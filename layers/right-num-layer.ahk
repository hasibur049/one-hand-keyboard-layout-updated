/*
   ----------------------------------------------
   -----------Number layer section---------------
   -----------Layer two/ NumpadAdd---------------
   ----------------------------------------------
   ----------------------------------------------
*/

; Hotkey to activate the numpad number layer
Right::
{
    global NUMPAD_NUMBER_MODE
    global NUMBER_MODE
    global SYMBOL_MODE
    global inside_symbol_layer_state
    global VIM_NORMAL_SPACE_MODE
    global NORMAL_ALT_MODE
    global INSERT_MODE
    global INSERT_MODE_II

    ; Activate the numpad number layer
    NUMPAD_NUMBER_MODE := true
    VIM_NORMAL_SPACE_MODE := false
    NORMAL_ALT_MODE := false
    SYMBOL_MODE := false
    inside_symbol_layer_state := 1
    NUMBER_MODE := false
    INSERT_MODE := false
    INSERT_MODE_II := false

    ; Show the number layer tooltip
    ToolTip("Numpad Number", numpad_number_TooltipX, 0, 7)

    ; Hide any other tooltips
    ToolTip(, , , 2)
    ToolTip(, , , 9)
    ToolTip(, , , 4)
    ToolTip(, , , 5)
}

Right Up::
{
    global NUMPAD_NUMBER_MODE
    global NUMBER_MODE
    global SYMBOL_MODE
    global inside_symbol_layer_state
    global VIM_NORMAL_SPACE_MODE
    global NORMAL_ALT_MODE
    global INSERT_MODE
    global INSERT_MODE_II
    global TOGGLE

    if (A_PriorKey = "Right") {
        Send "{Right}"
    }
    ; Deactivate the numpad number layer
    NUMPAD_NUMBER_MODE := false

    ; Reset other modes and show the appropriate tooltip
    SYMBOL_MODE := false
    inside_symbol_layer_state := 1
    NUMBER_MODE := false
    VIM_NORMAL_SPACE_MODE := false
    NORMAL_ALT_MODE := false
    INSERT_MODE := true

    if TOGGLE {
        INSERT_MODE_II := true

        ; Hide any other tooltips
        ToolTip(, , , 2)
        ToolTip(, , , 4)
        ToolTip(, , , 5)
        ToolTip(, , , 7)
        ToolTip(, , , 9)

        ; Show the index layer tooltip
        ToolTip("Index", index_TooltipX, 0, 1)
    } else {
        ; Hide any other tooltips
        ToolTip(, , , 2)
        ToolTip(, , , 4)
        ToolTip(, , , 5)
        ToolTip(, , , 7)
        ToolTip(, , , 9)
    }
}

; Define behavior within the number layer
#HotIf NUMPAD_NUMBER_MODE
;fn/num row
$1:: return
$2:: return
$3::
{
    SetKeyDelay -1
    Send "{Backspace}"
}
$4:: return
$5:: return

;top row
$q:: return
$w:: Send 2
$e:: send 3
$r:: send 4
$t:: return

;home row
$a:: return
$s:: send 1
$d:: send 0
$f:: send 5
$g:: send 9

;bottom row
$z:: return
$x:: send 6
$c:: send 7
$v:: send 8
$b:: return
#HotIf
