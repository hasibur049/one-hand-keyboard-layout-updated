/*
   ----------------------------------------------
   ----------------------------------------------
   ---------------Tab Number layer---------------
   ----------------------------------------------
   ----------------------------------------------
*/

NumberLebelTab() {
    global VIM_NORMAL_SPACE_MODE, NORMAL_ALT_MODE, SYMBOL_MODE, NUMBER_MODE
    global INSERT_MODE

    if !NUMBER_MODE {
        NUMBER_MODE := true
        SYMBOL_MODE := false
        VIM_NORMAL_SPACE_MODE := false
        NORMAL_ALT_MODE := false
        INSERT_MODE := false
        ;INSERT_MODE_II := false

        ToolTip(, , , 2)
        ToolTip(, , , 5)
        ToolTip(, , , 9)
        ToolTip("Numpad", number_TooltipX, 0, 4)
    }
    ;return
}

#HotIf NUMBER_MODE
;fn/num row
$1:: return
$2:: return
$3:: return
$4:: return
$5:: return

;top row
$q:: return
$w:: Send 7
$e:: send 8
$r:: send 9
$t:: return

;home row
$a:: return
$s:: send 4
$d:: send 5
$f:: send 6
$g:: send 0

;bottom row
$z:: return
$x:: send 1
$c:: send 2
$v:: send 3
$b:: return

$Tab::
{
    global VIM_NORMAL_SPACE_MODE, NORMAL_ALT_MODE, SYMBOL_MODE, NUMBER_MODE
    global TOGGLE, INSERT_MODE, INSERT_MODE_II

    NUMBER_MODE := false
    SYMBOL_MODE := false
    VIM_NORMAL_SPACE_MODE := false
    NORMAL_ALT_MODE := false
    INSERT_MODE := true

    if TOGGLE {
        INSERT_MODE_II := true

        ToolTip(, , , 4)
        ToolTip(, , , 5)
        ToolTip(, , , 9)
        ToolTip("Index", index_TooltipX, 0, 1)
    } else {
        ToolTip(, , , 4)
        ToolTip(, , , 5)
        ToolTip(, , , 9)
    }
    return
}

$CapsLock::
{
    global VIM_NORMAL_SPACE_MODE, NORMAL_ALT_MODE, SYMBOL_MODE, NUMBER_MODE
    global INSERT_MODE, INSERT_MODE_II
    global inside_symbol_layer_state

    inside_symbol_layer_state := 2
    SYMBOL_MODE := true
    NUMBER_MODE := false
    VIM_NORMAL_SPACE_MODE := false
    NORMAL_ALT_MODE := false
    INSERT_MODE := false
    ;INSERT_MODE_II := false

    ToolTip(, , , 2)
    ToolTip(, , , 4)
    ToolTip(, , , 9)
    ToolTip("Symbol", symbol_TooltipX, 0, 5)
}
#HotIf