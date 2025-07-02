/*
   ----------------------------------------------
   -----------Symbols layer section--------------
   -----------Layer one/ Backspace------------
   ----------------------------------------------
   ----------------------------------------------
*/

; Hotkey to activate the numpad symbol layer
Down::
{
    global NUMPAD_SYMBOL_MODE, NUMBER_MODE, SYMBOL_MODE
    global VIM_NORMAL_SPACE_MODE, NORMAL_ALT_MODE
    global INSERT_MODE, INSERT_MODE_II
    global inside_symbol_layer_state

    ; Activate the numpad symbol layer
    NUMPAD_SYMBOL_MODE := true
    VIM_NORMAL_SPACE_MODE := false
    NORMAL_ALT_MODE := false
    SYMBOL_MODE := false
    inside_symbol_layer_state := 1
    NUMBER_MODE := false
    INSERT_MODE := false
    INSERT_MODE_II := false

    ; Show the symbol layer tooltip
    ToolTip("Numpad Symbol", numpad_symbol_TooltipX, 0, 6)

    ; Hide any other tooltips
    ToolTip(, , , 2)
    ToolTip(, , , 4)
    ToolTip(, , , 5)
    ToolTip(, , , 9)
}

Down Up::
{
    global NUMPAD_SYMBOL_MODE
    global NUMBER_MODE
    global SYMBOL_MODE
    global inside_symbol_layer_state
    global VIM_NORMAL_SPACE_MODE
    global NORMAL_ALT_MODE
    global INSERT_MODE
    global INSERT_MODE_II
    global TOGGLE

    if (A_PriorKey = "Down") {
        Send "{Down}"
    }
    ; Deactivate the numpad symbol layer
    NUMPAD_SYMBOL_MODE := false

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
        ToolTip(, , , 6)
        ToolTip(, , , 9)

        ; Show the index layer tooltip
        ToolTip("Index", index_TooltipX, 0, 1)
    } else {
        ; Hide any other tooltips
        ToolTip(, , , 2)
        ToolTip(, , , 4)
        ToolTip(, , , 5)
        ToolTip(, , , 6)
        ToolTip(, , , 9)
    }
}

; Define behavior within the symbol layer
#HotIf NUMPAD_SYMBOL_MODE
;fn row in the keyboard
$1:: return
$2:: tapMode("", "~", "")
$3:: tapMode("", "|", "")
$4:: tapMode("", "^", "")
$5:: return

;top row in the keyboard
$q:: tapMode("", "``", "")
$w:: tapMode("w", "/", "\")
$e:: tapMode("e", "-", "_")
$r:: tapMode("r", "=", "+")
$t:: tapMode("t", "&", "$")

;home row in the keyboard
$a:: tapMode("a", "!", "%")
$s:: tapMode("s", "'", "`"")
$d:: tapMode("d", ";", ":")
$f:: tapMode("f", ".", ",")
$g:: tapMode("g", "*", "?")

;bottom row in the keyboard
$z:: tapMode("z", "<", ">")
$x:: tapMode("x", "[", "]")
$c:: tapMode("c", "(", ")")
$v:: tapMode("v", "{", "}")
$b:: tapMode("b", "`#", "@")
#HotIf
