/*
   ----------------------------------------------
   ----------------------------------------------
   -----------Capslock symbol layer--------------
   ----------------------------------------------
   ----------------------------------------------
*/

SymbolLebelCapsLock() {
    global VIM_NORMAL_SPACE_MODE, NORMAL_ALT_MODE, SYMBOL_MODE, NUMBER_MODE
    global INSERT_MODE, INSERT_MODE_II
    global inside_symbol_layer_state

    last := inside_symbol_layer_state, inside_symbol_layer_state := 3 ; Set the current layer to 3 when CapsLock is pressed

    INSERT_MODE := false
    INSERT_MODE_II := false
    NUMBER_MODE := false
    VIM_NORMAL_SPACE_MODE := false
    NORMAL_ALT_MODE := false

    ToolTip(, , , 2)
    ToolTip(, , , 4)
    ToolTip(, , , 9)

    KeyWait("CapsLock") ; Wait for CapsLock to be released

    ;layer := A_Priorkey != "CapsLock" ? last : last = 2 ? 1 : 2

    if (A_PriorKey != "CapsLock")
        inside_symbol_layer_state := last
    else if (last = 2)
        inside_symbol_layer_state := 1
    else
        inside_symbol_layer_state := 2


    if (inside_symbol_layer_state = 2) {

        SYMBOL_MODE := true
        INSERT_MODE := false
        ;INSERT_MODE_II := false

        ToolTip("Symbol", symbol_TooltipX, 0, 5)
    } else {

        SYMBOL_MODE := false
        INSERT_MODE := true

        ToolTip(, , , 5)

        if TOGGLE {
            INSERT_MODE_II := true

            ToolTip("Index", index_TooltipX, 0, 1)
        }
        return
    }
}

#HotIf (inside_symbol_layer_state = 2)
;fn/num row in the keyboard
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

$Alt::
{
    global VIM_NORMAL_SPACE_MODE, NORMAL_ALT_MODE, SYMBOL_MODE, NUMBER_MODE
    global INSERT_MODE, INSERT_MODE_II
    global inside_symbol_layer_state

    inside_symbol_layer_state := 1
    NORMAL_ALT_MODE := true
    VIM_NORMAL_SPACE_MODE := false
    ;CHECK_IS_ON_VIM_NORMAL_SPACE_MODE := false
    NUMBER_MODE := false
    SYMBOL_MODE := false
    INSERT_MODE := false
    INSERT_MODE_II := false

    ToolTip(, , , 2)
    ToolTip(, , , 4)
    ToolTip(, , , 5)
    ToolTip("Normal 2", normal_TooltipX_Alt, 0, 9)
    return
}
#HotIf

/*
#HotIf (inside_symbol_layer_state = 3)
$w:: Send("{Up}")
$a:: Send("{Left}")
$s::
{
    g := Morse(200)

    If (g = "0")
        Gui1Setup()  ; Call the function directly
    Else If (g = "1")
        return
    Else If (g = "00")
        return
}
$d:: Send("{Right}")
#HotIf
*/

; Case 1: inside_symbol_layer_state = 3 and TOGGLE is ON
#HotIf (inside_symbol_layer_state = 3 && TOGGLE)

$w:: Send("{WheelUp 2}")    ; Scroll up quickly when TOGGLE is on
$s:: Send("{WheelDown 2}")

#HotIf ; End of this conditional block

; Case 2: inside_symbol_layer_state = 3 and TOGGLE is OFF
#HotIf (inside_symbol_layer_state = 3 && !TOGGLE)

$w:: Send("{Up}")           ; Move up when TOGGLE is off
$a:: Send("{Left}")         ; Move left
$s:: Send("{Down}")         ; Move down when TOGGLE is off
$d:: Send("{Right}")

#HotIf                      ; End of this conditional block
