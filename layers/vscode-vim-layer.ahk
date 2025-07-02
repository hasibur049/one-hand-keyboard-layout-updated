/*
   ----------------------------------------------------
   --------------vscode-vim-mode-----------------------
   ---long press Space to active vim normal layer 1----
   ----------------------------------------------------
   ----------------------------------------------------
*/

Vim_NormalLabelSpace() {
    global VIM_NORMAL_SPACE_MODE, NORMAL_ALT_MODE, SYMBOL_MODE, NUMBER_MODE, INSERT_MODE, INSERT_MODE_II

    if !VIM_NORMAL_SPACE_MODE {
        VIM_NORMAL_SPACE_MODE := true
        ;guiOpen := false
        NORMAL_ALT_MODE := false
        SYMBOL_MODE := false
        NUMBER_MODE := false
        INSERT_MODE := false
        INSERT_MODE_II := false

        ToolTip(, , , 4)
        ToolTip(, , , 5)
        ToolTip(, , , 9)
        ToolTip("Normal", vim_normal_TooltipX_Space, 0, 2)
    }
}

#HotIf VIM_NORMAL_SPACE_MODE
; Detect mouse click and drag (selection)
~LButton::
{
    ;VimModeLibrary()
}

;fn row
;$1::return
$2::
{
    if LongPress(200)
        Send("gg") ;go to the first line of the document
    else
        Send("^") ;jump to the first non-blank character of the line ??????????????????????????????????????????????????????????????????
}
$3::
{
    Send("s")

    global VIM_NORMAL_SPACE_MODE, SYMBOL_MODE, NUMBER_MODE, TOGGLE, INSERT_MODE, INSERT_MODE_II

    ToolTip(, , , 2)
    ToolTip(, , , 4)
    ToolTip(, , , 5)

    VIM_NORMAL_SPACE_MODE := false
    SYMBOL_MODE := false
    NUMBER_MODE := false
    if TOGGLE {
        INSERT_MODE_II := true

        ToolTip("Index", index_TooltipX, 0, 1)
    }
}

$4::
{
    if LongPress(200)
        Send("G") ;go to the last line of the document
    Else
        Send("$") ;jump to the end of the line
}

;$5::return

; Top row remapping
$q::
{
    if LongPress(200)
        Send(">>")  ;indent (move right) line one shiftwidth
    Else
        Send("<<")  ;indent (move left) line one shiftwidth
}

$w:: DeleteLabel()
$e:: YankLabel()
$r:: ChangeLabel()
$t:: Send("p") ;put (paste) the clipboard after cursor

; home row
a:: Send("h") ;h - move cursor left
s:: Send("k") ;k - move cursor up
f:: Send("l") ;l - move cursor right
d:: Send("j") ;j - move cursor down

$g::
{
    global block_visual, line_visual, char_visual

    g := Morse(200)
    If (g = "00") {
        block_visual := true
        Vim_VisualLabel()
    }
    Else If (g = "0") {
        char_visual := true

        Send("v")
        Vim_VisualLabel()
    }
    Else If (g = "1") {
        line_visual := true

        Send("V")
        Vim_VisualLabel()
    }
}

; Bottom row remapping
$z:: Send("b") ;jump backwards to the start of a word
$x:: Send("{WheelUp}")
$c:: Send("{WheelDown}")
$v:: Send("w") ;jump forwards to the start of a worddd

$b::
{
    keyPress := Morse(200)

    If (keyPress = "00")
        Send("^r") ; short keyPress to redo
    else If (keyPress = "0")
        Send("u") ; short keyPress to undo
}

$Space::
{
    global VIM_NORMAL_SPACE_MODE, SYMBOL_MODE, NUMBER_MODE, INSERT_MODE, INSERT_MODE_II, TOGGLE

    ToolTip(, , , 2)
    ToolTip(, , , 4)
    ToolTip(, , , 5)

    keyPress := Morse(200)
    If (keyPress = "00")
        Send("o")  ; double short keyPress to go next line and enter insert mode
    else If (keyPress = "1")
        Send("i") ; short keyPress to go to the prev char where the curser point and enter insert mode
    else If (keyPress = "0")
        Send("a") ; long keyPress to go to the next char where the curser point and enter insert mode

    VIM_NORMAL_SPACE_MODE := false
    SYMBOL_MODE := false
    NUMBER_MODE := false
    INSERT_MODE := true

    if TOGGLE {
        INSERT_MODE_II := true

        ToolTip("Index", index_TooltipX, 0, 1)
    }
}

$Alt::
{
    global VIM_NORMAL_SPACE_MODE, NORMAL_ALT_MODE

    Send "a"
    ToolTip(, , , 2)
    ToolTip("Normal 2", normal_TooltipX_Alt, 0, 9)

    NORMAL_ALT_MODE := true
    VIM_NORMAL_SPACE_MODE := false

}
~Alt Up:: InStr(A_PriorKey, 'Alt') && Send('{Esc}')
#HotIf

/*
   --------------------------------------------------
   -----------visual layer inside normal-------------
   --------------------------------------------------
*/

Vim_VisualLabel() {

    global VIM_NORMAL_SPACE_MODE, VISUAL_MODE, SYMBOL_MODE, NUMBER_MODE
    global INSERT_MODE, INSERT_MODE_II
    global char_visual, line_visual, block_visual

    if !VISUAL_MODE {
        ;guiOpen := false
        VISUAL_MODE := true
        VIM_NORMAL_SPACE_MODE := false
        SYMBOL_MODE := false
        NUMBER_MODE := false
        INSERT_MODE := false
        INSERT_MODE_II := false

        ToolTip(, , , 2)
        ToolTip(, , , 4)
        ToolTip(, , , 5)

        if char_visual
            ToolTip("VISUAL", del_yank_change_visual_inside_NormalMode_TooltipX, 0, 10)
        Else if line_visual
            ToolTip("VISUAL LINE", del_yank_change_visual_inside_NormalMode_TooltipX, 0, 10)
        Else if block_visual
            ToolTip("VISUAL BLOCK", del_yank_change_visual_inside_NormalMode_TooltipX, 0, 10)
    }
}

#HotIf VISUAL_MODE

/*
~LButton::
~RButton::
*/

$Alt:: return
$Tab:: return
$CapsLock:: return
$Down:: return
$Shift:: return
$Ctrl:: return
$Right:: return

;fn row
;$1::return
$2::
{
    if LongPress(200)
        Send("gg") ;go to the first line of the document
    else
        Send("^") ;jump to the first non-blank character of the line
}
$3:: return
$4::
{
    if LongPress(200)
        Send "G" ;go to the last line of the document
    Else
        Send "{$}" ;jump to the end of the line
}
;$5::return

; Top row remapping
$q:: return
$w::
{
    global VISUAL_MODE
    global char_visual, line_visual, block_visual

    Send "d"

    ToolTip(, , , 10)
    VISUAL_MODE := false
    char_visual := false
    line_visual := false
    block_visual := false

    Vim_NormalLabelSpace()  ; Trigger Vim_NormalLabelSpace if VS Code is active
}


$e::
{
    global VISUAL_MODE
    global char_visual, line_visual, block_visual

    Send "y"

    ToolTip(, , , 10)
    VISUAL_MODE := false
    char_visual := false
    line_visual := false
    block_visual := false

    Vim_NormalLabelSpace()  ; Trigger Vim_NormalLabelSpace if VS Code is active
}

$r::
{
    global VIM_NORMAL_SPACE_MODE, VISUAL_MODE, SYMBOL_MODE, NUMBER_MODE
    global char_visual, line_visual, block_visual
    global TOGGLE, INSERT_MODE, INSERT_MODE_II

    Send "c"

    ToolTip(, , , 2)
    ToolTip(, , , 4)
    ToolTip(, , , 5)
    ToolTip(, , , 10)

    char_visual := false
    line_visual := false
    block_visual := false

    VISUAL_MODE := false
    VIM_NORMAL_SPACE_MODE := false
    SYMBOL_MODE := false
    NUMBER_MODE := false
    INSERT_MODE := true

    if TOGGLE {
        INSERT_MODE_II := true

        ToolTip("Index", index_TooltipX, 0, 1)
    }
}

$t::
{
    global VISUAL_MODE
    global char_visual, line_visual, block_visual

    Send "p" ;put (paste) the clipboard after cursor

    ToolTip(, , , 10)

    VISUAL_MODE := false
    char_visual := false
    line_visual := false
    block_visual := false

    Vim_NormalLabelSpace()  ; Trigger Vim_NormalLabelSpace if VS Code is active
}


; home row
$a:: Send "{Left}" ;h - move cursor left
$s:: Send "{Up}" ;k - move cursor up
$f:: Send "{Right}" ;l - move cursor right
$d:: Send "{Down}" ;j - move cursor down

$g::
{
    global VISUAL_MODE
    global char_visual, line_visual, block_visual

    Send "{Esc}"
    ToolTip(, , , 10)

    VISUAL_MODE := false
    char_visual := false
    line_visual := false
    block_visual := false

    Vim_NormalLabelSpace()  ; Trigger Vim_NormalLabelSpace if VS Code is active
}

; Bottom row remapping
$z:: Send "b" ;jump backwards to the start of a word
;$^z::Send, ^r ;redo
$x:: Send "{WheelUp}"
$c:: Send "{WheelDown}"
$v:: Send "w" ;jump forwards to the start of a word
$b:: return

; Define the hotkey to show or destroy the GUI
$Space::
{
    global VIM_NORMAL_SPACE_MODE, VISUAL_MODE, SYMBOL_MODE, NUMBER_MODE
    global char_visual, line_visual, block_visual
    global TOGGLE, INSERT_MODE, INSERT_MODE_II

    Send "{Esc}"

    g := Morse(200)
    If (g = "00")
        Send "o"  ; double short click to go next line and enter insert mode
    else If (g = "1")
        Send "a" ; long click to go to the next char where the curser point and enter insert mode
    else If (g = "0")
        Send "i" ; short click to go to the prev char where the curser point and enter insert mode

    ToolTip(, , , 2)
    ToolTip(, , , 4)
    ToolTip(, , , 5)
    ToolTip(, , , 10)

    ;guiOpen := false
    VISUAL_MODE := false
    char_visual := false
    line_visual := false
    block_visual := false

    VIM_NORMAL_SPACE_MODE := false
    SYMBOL_MODE := false
    NUMBER_MODE := false
    INSERT_MODE := true

    if TOGGLE {
        INSERT_MODE_II := true

        ToolTip("Index", index_TooltipX, 0, 1)
    }
}

#HotIf

/*
   --------------------------------------------------
   --------------------------------------------------
   ----------------delete/cut------------------------
   --------------------------------------------------
   --------------------------------------------------
*/

DeleteLabel() {
    global DELETE_MODE
    global VIM_NORMAL_SPACE_MODE

    if !DELETE_MODE {
        DELETE_MODE := true
        VIM_NORMAL_SPACE_MODE := false

        ToolTip("DELETE", del_yank_change_visual_inside_NormalMode_TooltipX, 0, 10)
    }
}

#HotIf DELETE_MODE

$Alt:: return
$Tab:: return
$CapsLock:: return
$Down:: return
$Shift:: return
$Ctrl:: return
$Right:: return

; fn row
$1:: return
$2:: return
$3:: return
$4:: return
$5:: return

; top row
$q:: return
$w::
{
    global DELETE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "dd" ;delete (cut) a line
    DELETE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$e::
{
    global DELETE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "x" ;delete (cut) a char
    DELETE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$r:: return
$t:: return

; home row
$a::
{
    global DELETE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "dw" ;delete (cut) the characters of the word from the cursor position to the start of the next word
    DELETE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$s::
{
    global DELETE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "d0" ;delete/cut from the cursor to the beginning of the line/ d0
    DELETE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$d::
{
    global DELETE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send("d$") ;delete (cut) to the end of the line
    DELETE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$f::
{
    global DELETE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "diw" ;delete (cut) word under the cursor
    DELETE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$g::
{
    global DELETE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "daw" ;delete (cut) word under the cursor and the space after or before it
    DELETE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

; Bottom row remapping
$z:: return
$x:: return
$c::
{
    global DELETE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "dgg" ;delete/cut from the cursor to the beginning of the file
    DELETE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$v::
{
    global DELETE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "dG" ; delete/cut from the cursor to the end of the file/
    DELETE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$b:: return
$Space::
{
    global DELETE_MODE
    global VIM_NORMAL_SPACE_MODE

    DELETE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}
#HotIf

/*
   --------------------------------------------------
   --------------------------------------------------
   -----------------yank/copy------------------------
   --------------------------------------------------
   --------------------------------------------------
*/

YankLabel() {
    global YANK_MODE
    global VIM_NORMAL_SPACE_MODE

    if !YANK_MODE {
        YANK_MODE := true
        VIM_NORMAL_SPACE_MODE := false

        ToolTip("YANK", del_yank_change_visual_inside_NormalMode_TooltipX, 0, 10)
    }
}

#HotIf YANK_MODE

$Alt:: return
$Tab:: return
$CapsLock:: return
$Down:: return
$Shift:: return
$Ctrl:: return
$Right:: return

; fn row
$1:: return
$2:: return
$3:: return
$4:: return
$5:: return

; top row
$q:: return
$w:: return
$e::
{
    global YANK_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "yy" ;Select and yank/copy a single line
    YANK_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$r::
{
    global YANK_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "yl" ;Select and yank/copy a single char
    YANK_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$t:: return

; home row
$a::
{
    global YANK_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "yw" ;yank/copy from the cursor to the beginning of the next word
    YANK_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$s::
{
    global YANK_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "y0" ;yank/copy from the cursor to the beginning of the line
    YANK_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$d::
{
    global YANK_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "y$" ;yank/copy from the cursor to the end of the line
    YANK_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$f::
{
    global YANK_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "yiw" ;yank/copy the entire word under the cursor. 'iw' focuses on the word itself, ignoring spaces or punctuation around it.
    YANK_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$g::
{
    global YANK_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "yaw" ; yank/copy the entire word under the cursor. "aw" includes spaces or punctuation around the word, making it more inclusive in its selection.
    YANK_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

; Bottom row remapping
$z:: return
$x:: return
$c::
{
    global YANK_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "ygg" ;yank/copy from the cursor to the beginning of the file
    YANK_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$v::
{
    global YANK_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "yG" ;yank/copy from the cursor to the end of the file
    YANK_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}

$b:: return
$Space::
{
    global YANK_MODE
    global VIM_NORMAL_SPACE_MODE

    YANK_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)
}
#HotIf

/*
   --------------------------------------------------
   --------------------------------------------------
   ----------------change/del------------------------
   --------------------------------------------------
   --------------------------------------------------
*/

changeToindex() {
    global VIM_NORMAL_SPACE_MODE, SYMBOL_MODE, NUMBER_MODE
    global TOGGLE, INSERT_MODE, INSERT_MODE_II

    ToolTip(, , , 2)
    ToolTip(, , , 4)
    ToolTip(, , , 5)

    ;guiOpen := false
    VIM_NORMAL_SPACE_MODE := false
    SYMBOL_MODE := false
    NUMBER_MODE := false
    INSERT_MODE := true

    if TOGGLE {
        INSERT_MODE_II := true

        ToolTip("Index", index_TooltipX, 0, 1)
    }
}

ChangeLabel() {
    global CHANGE_MODE
    global VIM_NORMAL_SPACE_MODE

    if !CHANGE_MODE {
        CHANGE_MODE := true
        VIM_NORMAL_SPACE_MODE := false

        ToolTip("CHANGE", del_yank_change_visual_inside_NormalMode_TooltipX, 0, 10)
    }
}

#HotIf CHANGE_MODE

$Alt:: return
$Tab:: return
$CapsLock:: return
$Down:: return
$Shift:: return
$Ctrl:: return
$Right:: return

; fn row
$1:: return
$2:: return
$3:: return
$4:: return
$5:: return

; top row
$q:: return
$w:: return
$e::
{
    global CHANGE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "s" ;Select and change/del a single char
    CHANGE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)

    changeToindex()
}

$r::
{
    global CHANGE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "cc" ;Select and change/del a single line
    CHANGE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)

    changeToindex()
}

$t:: return

; home row
$a::
{
    global CHANGE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "cw" ;change/del from the cursor to the beginning of the next word
    CHANGE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)

    changeToindex()
}

$s::
{
    global CHANGE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "c0" ;change/del from the cursor to the beginning of the line
    CHANGE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)

    changeToindex()
}

$d::
{
    global CHANGE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "c$" ;change/del from the cursor to the end of the line
    CHANGE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)

    changeToindex()
}

$f::
{
    global CHANGE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "ciw" ;change/del the entire word under the cursor. 'iw' focuses on the word itself, ignoring spaces or punctuation around it.
    CHANGE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)

    changeToindex()
}

$g::
{
    global CHANGE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "caw" ;change/del the entire word under the cursor. "aw" includes spaces or punctuation around the word, making it more inclusive in its selection.
    CHANGE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)

    changeToindex()
}


; Bottom row remapping
$z:: return
$x:: return
$c::
{
    global CHANGE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "cgg" ;change/del from the cursor to the beginning of the file
    CHANGE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)

    changeToindex()
}

$v::
{
    global CHANGE_MODE
    global VIM_NORMAL_SPACE_MODE

    Send "cG" ;change/del from the cursor to the end of the file
    CHANGE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)

    changeToindex()
}

$b:: return

$Space::
{
    global CHANGE_MODE
    global VIM_NORMAL_SPACE_MODE

    CHANGE_MODE := false
    VIM_NORMAL_SPACE_MODE := true
    ToolTip(, , , 10)

}

#HotIf