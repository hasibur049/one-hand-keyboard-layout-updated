SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.
;#InstallKeybdHook
#SingleInstance Force
A_MaxHotkeysPerInterval := 200
Persistent
SetCapsLockState "AlwaysOff"
CoordMode "ToolTip"
; Get current mouse cursor position
MouseGetPos(&mouseX, &mouseY)

INSERT_MODE := true
INSERT_MODE_II := false ; Variable to track the state of the index layer
TOGGLE := false

VIM_NORMAL_SPACE_MODE := false
;NORMAL_GUI_MODE := false
NORMAL_ALT_MODE := false
NUMBER_MODE := false
SYMBOL_MODE := false
inside_symbol_layer_state := 1
NUMPAD_SYMBOL_MODE := false ; Variable to track the state of the numpad symbol layer
NUMPAD_NUMBER_MODE := false

VISUAL_MODE := false
DELETE_MODE := false
YANK_MODE := false
CHANGE_MODE := false

char_visual := false
line_visual := false
block_visual := false

; Global variables to track which GUI is currently displayed
oGui1 := "", oGui2 := "", oGui3 := "", oGui4 := "", oGui5 := "", oGui6 := ""
CurrentGui := 1
TotalGuis := 5
guiOpen := false
NumberInput := "" ; initial value for gui live display

index_TooltipX := A_ScreenWidth / 2 ; tooltip 1 index layer
vim_normal_TooltipX_Space := index_TooltipX - 117 ; tooltip 2 noraml layer 1
normal_TooltipX_Alt := index_TooltipX - 117 ; tooltip 9 normal layer 2
chord_TooltipX := index_TooltipX ; tooltip 3 for display chord dict
chord_TooltipY := A_ScreenHeight - 34  ; Y coordinate at the very bottom edge of the screen
; A_CaretX-50, A_CaretY-50 ; tooltip 3 for display chord dict
number_TooltipX := index_TooltipX + 100 ; tooltip 4 number layer
symbol_TooltipX := index_TooltipX + 100 ; tooltip 5 symbol layer
numpad_symbol_TooltipX := index_TooltipX + 100 ; tooltip 6 numpad symbol layer
numpad_number_TooltipX := index_TooltipX + 100 ; tooltip 7 numpad number layer
; MouseGetPos, x, y tooltip 8 for rbutton copy message
del_yank_change_visual_inside_NormalMode_TooltipX := index_TooltipX - 225 ; tooltip for 10 delete, yank, change, visual mode operation
