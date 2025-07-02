/*
   --------------------------------------------------
   --------------------------------------------------
   -----------------------gui------------------------
   --------------------------------------------------
   --------------------------------------------------
*/

checkGui() {
    global guiOpen
    global VIM_NORMAL_SPACE_MODE
    global NORMAL_ALT_MODE
    global SYMBOL_MODE
    global NUMBER_MODE
    global INSERT_MODE

; Code to execute after the jump
if !guiOpen {
    guiOpen := true
    VIM_NORMAL_SPACE_MODE := false
    NORMAL_ALT_MODE := false
    SYMBOL_MODE := false
    NUMBER_MODE := false
    INSERT_MODE := false
    }
}

; Define the remapped hotkeys for switching between GUIs
#HotIf guiOpen
	;fn row
    $1::
    {
        DestroyGui()
        Gui1Setup()
    }
    $2::
    {
        DestroyGui()
        Gui2Setup()
    }
    $3::
    {
        DestroyGui()
        Gui3Setup()
    }
    $4::
    {
        DestroyGui()
        Gui4Setup()
    }
    $5::
    {
        DestroyGui()
        Gui5Setup()
    }

    ; Top row remapping
    $q::return
    $w::HandleNumber(7)
    $e::HandleNumber(8)
    $r::HandleNumber(9)
    $t::return

    ; Home row remapping
	$a::HandleNumber(1)
    $s::HandleNumber(4)
    $d::HandleNumber(5)
    $f::HandleNumber(6)
    $g::HandleNumber(0)

    ; Bottom row remapping
    $z::return
    $x::HandleNumber(1)
    $c::HandleNumber(2)
    $v::HandleNumber(3)
    $b::return

    $Alt::return
    $Tab::return
    $CapsLock::return
    $Down::return
    $Shift::return
    $Ctrl::return
    $Right::return

    $space::
    {
        global oGui1, oGui2, oGui3, oGui4, oGui5, oGui6

        global guiOpen, VIM_NORMAL_SPACE_MODE, SYMBOL_MODE, NUMBER_MODE
        global TOGGLE, INSERT_MODE, INSERT_MODE_II

        ; Destroy existing GUIs if they exist
        if IsObject(oGui1) {
            oGui1.Destroy()
            oGui1 := "" ; Optional: Reset variable to indicate no GUI is assigned
        }
        if IsObject(oGui2) {
            oGui2.Destroy()
            oGui2 := ""
        }
        if IsObject(oGui3) {
            oGui3.Destroy()
            oGui3 := ""
        }
        if IsObject(oGui4) {
            oGui4.Destroy()
            oGui4 := ""
        }
        if IsObject(oGui5) {
            oGui5.Destroy()
            oGui5 := ""
        }
        if IsObject(oGui6) {
            oGui6.Destroy()
            oGui6 := ""
        }

        guiOpen := false
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

liveDisplayGui() {

    ; Calculate the position for the input display GUI
    ScreenWidth := A_ScreenWidth ; 1920
    ScreenHeight := A_ScreenHeight ; 1080

	DisplayHeight := 40  ; Height of the input display box
	DisplayWidth := 85 ; Width of the input display box

	; Calculate Y position for the bottom of the screen
	DisplayY := ScreenHeight - DisplayHeight - 54  ; 20 pixels above the bottom for padding

	; Calculate X position to center the display horizontally
	DisplayX := (ScreenWidth - DisplayWidth) / 2.05  ; Use '/' for floating-point division

    ; Create the GUI window
    global oGui6 := Gui("+AlwaysOnTop -Caption +ToolWindow")  ; Create the GUI window with flags
    oGui6.BackColor := 'EEAA99'                        ; Set the background color (which will also be the transparent color)
    oGui6.SetFont("Bold s15", "Verdana")  ; Set the font size and style

    ;Set 0x000000 (black) to be transparent (A: 255)
    WinSetTransColor((oGui6.BackColor := 000000) ' 255', oGui6)

    ; Add a text control to display the input
    oGui6.Add("Text", Format("w{} h{} BackgroundWhite center cBlack vLiveDisplay", DisplayWidth, DisplayHeight), NumberInput)

    ; Show the GUI with the specified parameters
    oGui6.Show(Format("x{} y{} w{} h{} NoActivate", DisplayX, DisplayY, DisplayWidth, DisplayHeight))
}

; Define the GUI setups
Gui1Setup() {
    global CurrentGui
    checkGui()
	CurrentGui := 1

    ; Create the GUI window
    global oGui1 := Gui("+AlwaysOnTop -Caption +ToolWindow")  ; Create the GUI window with flags
    oGui1.BackColor := 'EEAA99'                        ; Set the background color (which will also be the transparent color)

    ;Set 0x000000 (black) to be transparent (A: 255)
    WinSetTransColor((oGui1.BackColor := 000000) ' 255', oGui1)

	; Add transparent buttons w 150 h 120
	global ogcGui1Button11Action := oGui1.Add("Button", "x101 y1 w140 h110 BackgroundTrans", "Volume Min")
	ogcGui1Button11Action.OnEvent("Click", Gui1Button11Action)
	global ogcGui1Button12Action := oGui1.Add("Button", "x101 y119 w140 h110 BackgroundTrans ", "Volume Max")
	ogcGui1Button12Action.OnEvent("Click", Gui1Button12Action)
	global ogcGui1Button13Action := oGui1.Add("Button", "x101 y239 w140 h110 BackgroundTrans ", "Volume Mute")
	ogcGui1Button13Action.OnEvent("Click", Gui1Button13Action)
	global ogcGui1Button14Action := oGui1.Add("Button", "x101 y359 w140 h110 BackgroundTrans ", "Show Tooltip")
	ogcGui1Button14Action.OnEvent("Click", Gui1Button14Action)
	global ogcGui1Button15Action := oGui1.Add("Button", "x101 y479 w140 h110 BackgroundTrans ", "Null Value")
	ogcGui1Button15Action.OnEvent("Click", Gui1Button15Action)
;-------------------------------------------------------
	global ogcGui1Button16Action := oGui1.Add("Button", "x251 y1 w140 h110 BackgroundTrans ", "Button 16")
	ogcGui1Button16Action.OnEvent("Click", Gui1Button16Action)
	global ogcGui1Button17Action := oGui1.Add("Button", "x251 y119 w140 h110 BackgroundTrans ", "Button 17")
	ogcGui1Button17Action.OnEvent("Click", Gui1Button17Action)
	global ogcGui1Button18Action := oGui1.Add("Button", "x251 y239 w140 h110 BackgroundTrans ", "Button 18")
	ogcGui1Button18Action.OnEvent("Click", Gui1Button18Action)
	global ogcGui1Button19Action:= oGui1.Add("Button", "x251 y359 w140 h110 BackgroundTrans ", "Button 19")
	ogcGui1Button19Action.OnEvent("Click", Gui1Button19Action)
	global ogcGui1Button20Action := oGui1.Add("Button", "x251 y479 w140 h110 BackgroundTrans ", "Button 20")
	ogcGui1Button20Action.OnEvent("Click", Gui1Button20Action)
;----------------------------------------------------
	global ogcGui1Button21Action := oGui1.Add("Button", "x401 y1 w140 h110 BackgroundTrans ", "Button 21")
	ogcGui1Button21Action.OnEvent("Click", Gui1Button21Action)
	global ogcGui1Button22Action := oGui1.Add("Button", "x401 y119 w140 h110 BackgroundTrans ", "Button 22")
	ogcGui1Button22Action.OnEvent("Click", Gui1Button22Action)
	global ogcGui1Button23Action := oGui1.Add("Button", "x401 y239 w140 h110 BackgroundTrans ", "Button 23")
	ogcGui1Button23Action.OnEvent("Click", Gui1Button23Action)
	global ogcGui1Button24Action := oGui1.Add("Button", "x401 y359 w140 h110 BackgroundTrans ", "Button 24")
	ogcGui1Button24Action.OnEvent("Click", Gui1Button24Action)
	global ogcGui1Button25Action := oGui1.Add("Button", "x401 y479 w140 h110 BackgroundTrans ", "Button 25")
	ogcGui1Button25Action.OnEvent("Click", Gui1Button25Action)
;-------------------------------------
	global ogcGui1Button26Action := oGui1.Add("Button", "x551 y1 w140 h110 BackgroundTrans ", "Button 26")
	ogcGui1Button26Action.OnEvent("Click", Gui1Button26Action)
	global ogcGui1Button27Action := oGui1.Add("Button", "x551 y119 w140 h110 BackgroundTrans ", "Button 27")
	ogcGui1Button27Action.OnEvent("Click", Gui1Button27Action)
	global ogcGui1Button28Action := oGui1.Add("Button", "x551 y239 w140 h110 BackgroundTrans ", " Current Gui " CurrentGui)
	ogcGui1Button28Action.OnEvent("Click", Gui1Button28Action)
	global ogcGui1Button29Action := oGui1.Add("Button", "x551 y359 w140 h110 BackgroundTrans ", "Button 29")
	ogcGui1Button29Action.OnEvent("Click", Gui1Button29Action)
	global ogcGui1Button30Action := oGui1.Add("Button", "x551 y479 w140 h110 BackgroundTrans ", "Button 30")
	ogcGui1Button30Action.OnEvent("Click", Gui1Button30Action)
;---------------------------------
	global ogcGui1Button31Action := oGui1.Add("Button", "x701 y1 w140 h110 BackgroundTrans ", "Button 31")
	ogcGui1Button31Action.OnEvent("Click", Gui1Button31Action)
	global ogcGui1Button32Action := oGui1.Add("Button", "x701 y119 w140 h110 BackgroundTrans ", "Button 32")
	ogcGui1Button32Action.OnEvent("Click", Gui1Button32Action)
	global ogcGui1Button33Action := oGui1.Add("Button", "x701 y239 w140 h110 BackgroundTrans ", "Button 33")
	ogcGui1Button33Action.OnEvent("Click", Gui1Button33Action)
	global ogcGui1Button34Action := oGui1.Add("Button", "x701 y359 w140 h110 BackgroundTrans ", "Button 34")
	ogcGui1Button34Action.OnEvent("Click", Gui1Button34Action)
	global ogcGui1Button35Action := oGui1.Add("Button", "x701 y479 w140 h110 BackgroundTrans ", "Button 35")
	ogcGui1Button35Action.OnEvent("Click", Gui1Button35Action)
;-------------------------------------
	global ogcGui1Button36Action := oGui1.Add("Button", "x851 y1 w140 h110 BackgroundTrans ", "Button 36")
	ogcGui1Button36Action.OnEvent("Click", Gui1Button36Action)
	global ogcGui1Button37Action := oGui1.Add("Button", "x851 y119 w140 h110 BackgroundTrans ", "WSL Ubuntu Bash shell`n37")
	ogcGui1Button37Action.OnEvent("Click", Gui1Button37Action)
	global ogcGui1Button38Action := oGui1.Add("Button", "x851 y239 w140 h110 BackgroundTrans ", "Button 38")
	ogcGui1Button38Action.OnEvent("Click", Gui1Button38Action)
	global ogcGui1Button39Action := oGui1.Add("Button", "x851 y359 w140 h110 BackgroundTrans ", "Button 39")
	ogcGui1Button39Action.OnEvent("Click", Gui1Button39Action)
	global ogcGui1Button40Action := oGui1.Add("Button", "x851 y479 w140 h110 BackgroundTrans ", "Button 40")
	ogcGui1Button40Action.OnEvent("Click", Gui1Button40Action)
;--------------------------
	global ogcGui1Button41Action := oGui1.Add("Button", "x1001 y1 w140 h110 BackgroundTrans ", "Button 41")
	ogcGui1Button41Action.OnEvent("Click", Gui1Button41Action)
	global ogcGui1Button42Action := oGui1.Add("Button", "x1001 y119 w140 h110 BackgroundTrans ", "Button 42")
	ogcGui1Button42Action.OnEvent("Click", Gui1Button42Action)
	global ogcGui1Button43Action := oGui1.Add("Button", "x1001 y239 w140 h110 BackgroundTrans ", "Button 43")
	ogcGui1Button43Action.OnEvent("Click", Gui1Button43Action)
	global ogcGui1Button44Action:= oGui1.Add("Button", "x1001 y359 w140 h110 BackgroundTrans ", "Button 44")
	ogcGui1Button44Action.OnEvent("Click", Gui1Button44Action)
	global ogcGui1Button45Action := oGui1.Add("Button", "x1001 y479 w140 h110 BackgroundTrans ", "Button 45")
	ogcGui1Button45Action.OnEvent("Click", Gui1Button45Action)

	oGui1.Add("Button", "x1151 y239 w50 h110 BackgroundTrans ", "Next").OnEvent("Click", Gui1Button0Action)

    oGui1.OnEvent('Close', (*) => ExitApp())
	oGui1.Title := "Control Panel"
	oGui1.Show("w1246 h621")  ; Display the GUI with the buttons

	liveDisplayGui()
}

; Define the GUI setups
Gui2Setup() {
    global CurrentGui
    checkGui()
	CurrentGui := 2

    ; Create the GUI window
    global oGui2 := Gui("+AlwaysOnTop -Caption +ToolWindow")  ; Create the GUI window with flags
    oGui2.BackColor := 'EEAA99'                        ; Set the background color (which will also be the transparent color)

    ;Set 0x000000 (black) to be transparent (A: 255)
    WinSetTransColor((oGui2.BackColor := 000000) ' 255', oGui2)

    oGui2.Add("Button", "x41 y239 w50 h110 BackgroundTrans ", "Prev").OnEvent("Click", Gui2Button1Action)

	; Add transparent buttons w 150 h 120
	global ogcGui2Button11Action := oGui2.Add("Button", "x101 y1 w140 h110 BackgroundTrans", "Volume Min")
	;ogcGui2Button11Action.OnEvent("Click", Gui2Button11Action)
	global ogcGui2Button12Action := oGui2.Add("Button", "x101 y119 w140 h110 BackgroundTrans ", "Volume Max")
	;ogcGui2Button12Action.OnEvent("Click", Gui2Button12Action)
	global ogcGui2Button13Action := oGui2.Add("Button", "x101 y239 w140 h110 BackgroundTrans ", "Volume Mute")
	;ogcGui2Button13Action.OnEvent("Click", Gui2Button13Action)
	global ogcGui2Button14Action := oGui2.Add("Button", "x101 y359 w140 h110 BackgroundTrans ", "Show Tooltip")
	;ogcGui2Button14Action.OnEvent("Click", Gui2Button14Action)
	global ogcGui2Button15Action := oGui2.Add("Button", "x101 y479 w140 h110 BackgroundTrans ", "Null Value")
	ogcGui2Button15Action.OnEvent("Click", Gui2Button15Action)
;-------------------------------------------------------
	global ogcGui2Button16Action := oGui2.Add("Button", "x251 y1 w140 h110 BackgroundTrans ", "Button 16")
	;ogcGui2Button16Action.OnEvent("Click", Gui2Button16Action)
	global ogcGui2Button17Action := oGui2.Add("Button", "x251 y119 w140 h110 BackgroundTrans ", "Button 17")
	;ogcGui2Button17Action.OnEvent("Click", Gui2Button17Action)
	global ogcGui2Button18Action := oGui2.Add("Button", "x251 y239 w140 h110 BackgroundTrans ", "Button 18")
	;ogcGui2Button18Action.OnEvent("Click", Gui2Button18Action)
	global ogcGui2Button19Action:= oGui2.Add("Button", "x251 y359 w140 h110 BackgroundTrans ", "Button 19")
	;ogcGui2Button19Action.OnEvent("Click", Gui2Button19Action)
	global ogcGui2Button20Action := oGui2.Add("Button", "x251 y479 w140 h110 BackgroundTrans ", "Button 20")
	;ogcGui2Button20Action.OnEvent("Click", Gui2Button20Action)
;----------------------------------------------------
	global ogcGui2Button21Action := oGui2.Add("Button", "x401 y1 w140 h110 BackgroundTrans ", "Button 21")
	;ogcGui2Button21Action.OnEvent("Click", Gui2Button21Action)
	global ogcGui2Button22Action := oGui2.Add("Button", "x401 y119 w140 h110 BackgroundTrans ", "Button 22")
	;ogcGui2Button22Action.OnEvent("Click", Gui2Button22Action)
	global ogcGui2Button23Action := oGui2.Add("Button", "x401 y239 w140 h110 BackgroundTrans ", "Button 23")
	;ogcGui2Button23Action.OnEvent("Click", Gui2Button23Action)
	global ogcGui2Button24Action := oGui2.Add("Button", "x401 y359 w140 h110 BackgroundTrans ", "Button 24")
	;ogcGui2Button24Action.OnEvent("Click", Gui2Button24Action)
	global ogcGui2Button25Action := oGui2.Add("Button", "x401 y479 w140 h110 BackgroundTrans ", "Button 25")
	;ogcGui2Button25Action.OnEvent("Click", Gui2Button25Action)
;-------------------------------------
	global ogcGui2Button26Action := oGui2.Add("Button", "x551 y1 w140 h110 BackgroundTrans ", "Button 26")
	;ogcGui2Button26Action.OnEvent("Click", Gui2Button26Action)
	global ogcGui2Button27Action := oGui2.Add("Button", "x551 y119 w140 h110 BackgroundTrans ", "Button 27")
	;ogcGui2Button27Action.OnEvent("Click", Gui2Button27Action)
	global ogcGui2Button28Action := oGui2.Add("Button", "x551 y239 w140 h110 BackgroundTrans ", " Current Gui " CurrentGui)
	ogcGui2Button28Action.OnEvent("Click", Gui2Button28Action)
	global ogcGui2Button29Action := oGui2.Add("Button", "x551 y359 w140 h110 BackgroundTrans ", "Button 29")
	;ogcGui2Button29Action.OnEvent("Click", Gui2Button29Action)
	global ogcGui2Button30Action := oGui2.Add("Button", "x551 y479 w140 h110 BackgroundTrans ", "Button 30")
	;ogcGui2Button30Action.OnEvent("Click", Gui2Button30Action)
;---------------------------------
	global ogcGui2Button31Action := oGui2.Add("Button", "x701 y1 w140 h110 BackgroundTrans ", "Button 31")
	;ogcGui2Button31Action.OnEvent("Click", Gui2Button31Action)
	global ogcGui2Button32Action := oGui2.Add("Button", "x701 y119 w140 h110 BackgroundTrans ", "Button 32")
	;ogcGui2Button32Action.OnEvent("Click", Gui2Button32Action)
	global ogcGui2Button33Action := oGui2.Add("Button", "x701 y239 w140 h110 BackgroundTrans ", "Button 33")
	;ogcGui2Button33Action.OnEvent("Click", Gui2Button33Action)
	global ogcGui2Button34Action := oGui2.Add("Button", "x701 y359 w140 h110 BackgroundTrans ", "Button 34")
	;ogcGui2Button34Action.OnEvent("Click", Gui2Button34Action)
	global ogcGui2Button35Action := oGui2.Add("Button", "x701 y479 w140 h110 BackgroundTrans ", "Button 35")
	;ogcGui2Button35Action.OnEvent("Click", Gui2Button35Action)
;-------------------------------------
	global ogcGui2Button36Action := oGui2.Add("Button", "x851 y1 w140 h110 BackgroundTrans ", "Button 36")
	;ogcGui2Button36Action.OnEvent("Click", Gui2Button36Action)
	global ogcGui2Button37Action := oGui2.Add("Button", "x851 y119 w140 h110 BackgroundTrans ", "Button 37")
	;ogcGui2Button37Action.OnEvent("Click", Gui2Button37Action)
	global ogcGui2Button38Action := oGui2.Add("Button", "x851 y239 w140 h110 BackgroundTrans ", "Button 38")
	;ogcGui2Button38Action.OnEvent("Click", Gui2Button38Action)
	global ogcGui2Button39Action := oGui2.Add("Button", "x851 y359 w140 h110 BackgroundTrans ", "Button 39")
	;ogcGui2Button39Action.OnEvent("Click", Gui2Button39Action)
	global ogcGui2Button40Action := oGui2.Add("Button", "x851 y479 w140 h110 BackgroundTrans ", "Button 40")
	;ogcGui2Button40Action.OnEvent("Click", Gui2Button40Action)
;--------------------------
	global ogcGui2Button41Action := oGui2.Add("Button", "x1001 y1 w140 h110 BackgroundTrans ", "Button 41")
	;ogcGui2Button41Action.OnEvent("Click", Gui2Button41Action)
	global ogcGui2Button42Action := oGui2.Add("Button", "x1001 y119 w140 h110 BackgroundTrans ", "Button 42")
	;ogcGui2Button42Action.OnEvent("Click", Gui2Button42Action)
	global ogcGui2Button43Action := oGui2.Add("Button", "x1001 y239 w140 h110 BackgroundTrans ", "Button 43")
	;ogcGui2Button43Action.OnEvent("Click", Gui2Button43Action)
	global ogcGui2Button44Action:= oGui2.Add("Button", "x1001 y359 w140 h110 BackgroundTrans ", "Button 44")
	;ogcGui2Button44Action.OnEvent("Click", Gui2Button44Action)
	global ogcGui2Button45Action := oGui2.Add("Button", "x1001 y479 w140 h110 BackgroundTrans ", "Button 45")
	;ogcGui2Button45Action.OnEvent("Click", Gui2Button45Action)

    oGui2.Add("Button", "x1151 y239 w50 h110 BackgroundTrans ", "Next").OnEvent("Click", Gui2Button0Action)

    oGui2.OnEvent('Close', (*) => ExitApp())
	oGui2.Title := "Control Panel"
	oGui2.Show("w1246 h621")  ; Display the GUI with the buttons

    liveDisplayGui()
}

Gui3Setup() {
    global CurrentGui
	checkGui()
	CurrentGui := 3

    global oGui3 := Gui("+LastFound +AlwaysOnTop -Caption +ToolWindow")
    oGui3.BackColor := "EEAA99"
    oGui3.Add("Text", "x10 y10 w200 h30", " Current Gui " CurrentGui)

    oGui3.Add("Button", "x100 y100 w200 h50 ", "Prev").OnEvent("Click", Gui3Button1Action)
	oGui3.Add("Button", "x100 y200 w200 h50 ", "Next").OnEvent("Click", Gui3Button0Action)

    oGui3.Title := "Control Panel"
    oGui3.Show("w400 h300")

    liveDisplayGui()
}

Gui4Setup() {
    global CurrentGui
	checkGui()
	CurrentGui := 4

    global oGui4 := Gui("+LastFound +AlwaysOnTop -Caption +ToolWindow")
    oGui4.BackColor := "EEAA99"
    oGui4.Add("Text", "x10 y10 w200 h30", " Current Gui " CurrentGui)

    oGui4.Add("Button", "x100 y100 w200 h50 ", "Prev").OnEvent("Click", Gui4Button1Action)
	oGui4.Add("Button", "x100 y200 w200 h50 ", "Next").OnEvent("Click", Gui4Button0Action)

    oGui4.Title := "Control Panel"
    oGui4.Show("w400 h300")

    liveDisplayGui()
}

Gui5Setup() {
    global CurrentGui
	checkGui()
	CurrentGui := 5

    global oGui5 := Gui("+LastFound +AlwaysOnTop -Caption +ToolWindow")
    oGui5.BackColor := "EEAA99"
    oGui5.Add("Text", "x10 y10 w200 h30", " Current Gui " CurrentGui)

    oGui5.Add("Button", "x100 y100 w200 h50 ", "Prev").OnEvent("Click", Gui5Button1Action)

    oGui5.Title := "Control Panel"
    oGui5.Show("w400 h300")

    liveDisplayGui()
}

; Handle number input and update live display
HandleNumber(Num) {
    global oGui6, guiOpen, NumberInput, LastInputTime
    if (guiOpen) {  ; Only process input when GUI is open
        ; Only allow input if the length is less than 2 digits
        if (StrLen(NumberInput) < 2) {
            NumberInput .= Num  ; Append the new number to the input
            LastInputTime := A_TickCount
		}
            oGui6["LiveDisplay"].Value := NumberInput ; Update the live input display

            SetTimer(ProcessInput, -500)  ; Start a timer to wait for 500ms
    }
}

ProcessInput()
{
    global guiOpen, NumberInput, LastInputTime, oGui6
    if (guiOpen && (A_TickCount - LastInputTime >= 500)) {
        TempInput := NumberInput
        ; Check if the input is a valid button number

        if (CurrentGui = 1) && (Gui1ButtonNumber(NumberInput)) {
            ResetDisplayAndInputField()
            Gui1Button%TempInput%Action()  ; Trigger corresponding button action
        }
        else if (CurrentGui = 2) && (Gui2ButtonNumber(NumberInput)) {
            ResetDisplayAndInputField()
            Gui2Button%TempInput%Action()  ; Trigger corresponding button action
        }
        else if (CurrentGui = 3) && (Gui3ButtonNumber(NumberInput)) {
            ResetDisplayAndInputField()
            Gui3Button%TempInput%Action()  ; Trigger corresponding button action
        }
        else if (CurrentGui = 4) && (Gui4ButtonNumber(NumberInput)) {
            ResetDisplayAndInputField()
            Gui4Button%TempInput%Action()  ; Trigger corresponding button daction
        }
        else if (CurrentGui = 5) && (Gui5ButtonNumber(NumberInput)) {
            ResetDisplayAndInputField()
            Gui5Button%TempInput%Action()  ; Trigger corresponding button action
        }
    }
}

ResetDisplayAndInputField()
{
    global oGui6, NumberInput

    ; Reset the display and input fields
    oGui6["LiveDisplay"].Value := "..."  ; Clear the live input display
    NumberInput := ""  ; Reset the input after handling
}


Gui1ButtonNumber(Num) {
    return (Num != "") && (Num >= 11 && Num <= 45) || (Num = 0) || (Num = 1) ; Return true only for numbers between 11 and 45 or 0/1 and when number can't be an empty strings
}

Gui2ButtonNumber(Num) {
    return (Num != "") && (Num = 0) || (Num = 1) || (Num = 15) || (Num = 28)
}

Gui3ButtonNumber(Num) {
    return (Num != "") && (Num = 0) || (Num = 1)
}

Gui4ButtonNumber(Num) {
    return (Num != "") && (Num = 0) || (Num = 1)
}

Gui5ButtonNumber(Num) {
    return (Num != "") && (Num = 0) || (Num = 1)
}

; -----------------------------DestroyGui--------------------------------------

DestroyGui() {
    global oGui1, oGui2, oGui3, oGui4, oGui5, oGui6

    ; Destroy existing GUIs if they exist
    if IsObject(oGui1) {
        oGui1.Destroy()
        oGui1 := "" ; Optional: Reset variable to indicate no GUI is assigned
    }
    if IsObject(oGui2) {
        oGui2.Destroy()
        oGui2 := ""
    }
    if IsObject(oGui3) {
        oGui3.Destroy()
        oGui3 := ""
    }
    if IsObject(oGui4) {
        oGui4.Destroy()
        oGui4 := ""
    }
    if IsObject(oGui5) {
        oGui5.Destroy()
        oGui5 := ""
    }
    if IsObject(oGui6) {
        oGui6.Destroy()
        oGui6 := ""
    }
}

Gui1Button1Action(*) ; 1 for prev
{
}

Gui1Button0Action(*) ; 0 for next
{
    DestroyGui()
    Gui2Setup()
}

Gui1Button00Action(*) ; 0 for next
{
    DestroyGui()
    Gui2Setup()
}

Gui2Button1Action(*) ; 1 for prev
{
    DestroyGui()
    Gui1Setup()
}

Gui2Button0Action(*) ; 0 for next
{
    DestroyGui()
    Gui3Setup()
}

Gui2Button00Action(*) ; 0 for next
{
    DestroyGui()
    Gui3Setup()
}

Gui3Button1Action(*) ; 1 for prev
{
    DestroyGui()
    Gui2Setup()
}

Gui3Button0Action(*) ; 0 for next
{
    DestroyGui()
    Gui4Setup()
}

Gui3Button00Action(*) ; 0 for next
{
    DestroyGui()
    Gui4Setup()
}

Gui4Button1Action(*) ; 1 for prev
{
    DestroyGui()
    Gui3Setup()
}

Gui4Button0Action(*) ; 0 for next
{
    DestroyGui()
    Gui5Setup()
}

Gui4Button00Action(*) ; 0 for next
{
    DestroyGui()
    Gui5Setup()
}

Gui5Button1Action(*) ; 1 for prev
{
    DestroyGui()
    Gui4Setup()
}

Gui5Button0Action(*) ; 0 for next
{
}

Gui5Button00Action(*) ; 0 for next
{
}

; ---------------------------------Gui1-----------------------------------------

Gui1Button11Action(*)
{
    ; Set volume to 0 (mute)
	SoundSetVolume(0)  ; Mute the system volume
	ToolTip(ogcGui1Button11Action.Text)
	Sleep(1000)
    ToolTip()
}

Gui1Button12Action(*)
{
	ToolTip(ogcGui1Button12Action.Text)
	Sleep(1000)
    ToolTip()
}

Gui1Button13Action(*)
{
	ToolTip(ogcGui1Button13Action.Text)
	Sleep(1000)
    ToolTip()
}

Gui1Button14Action(*)
{
	ToolTip(ogcGui1Button14Action.Text)
	Sleep(1000)
    ToolTip()
}

Gui1Button15Action(*)
{
	ToolTip(ogcGui1Button15Action.Text)
	Sleep(1000)
    ToolTip()
}

Gui1Button16Action(*)
{
	ToolTip(ogcGui1Button16Action.Text)
	Sleep(1000)
    ToolTip()
}

Gui1Button17Action(*)
{
	ToolTip(ogcGui1Button17Action.Text)
	Sleep(1000)
    ToolTip()
}

Gui1Button18Action(*)
{
	ToolTip(ogcGui1Button18Action.Text)
	Sleep(1000)
    ToolTip()
}

Gui1Button19Action(*)
{
	ToolTip(ogcGui1Button19Action.Text)
	Sleep(1000)
    ToolTip()
}

Gui1Button20Action(*)
{
	ToolTip(ogcGui1Button20Action.Text)
	Sleep(1000)
    ToolTip()
}

Gui1Button21Action(*)
{
    ToolTip(ogcGui1Button21Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button22Action(*)
{
    ToolTip(ogcGui1Button22Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button23Action(*)
{
    ToolTip(ogcGui1Button23Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button24Action(*)
{
    ToolTip(ogcGui1Button24Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button25Action(*)
{
    ToolTip(ogcGui1Button25Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button26Action(*)
{
    ToolTip(ogcGui1Button26Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button27Action(*)
{
    ToolTip(ogcGui1Button27Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button28Action(*)
{
    ToolTip(ogcGui1Button28Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button29Action(*)
{
    ToolTip(ogcGui1Button29Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button30Action(*)
{
    ToolTip(ogcGui1Button30Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button31Action(*)
{
    ToolTip(ogcGui1Button31Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button32Action(*)
{
    ToolTip(ogcGui1Button32Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button33Action(*)
{
    ToolTip(ogcGui1Button33Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button34Action(*)
{
    ToolTip(ogcGui1Button34Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button35Action(*)
{
    ToolTip(ogcGui1Button35Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button36Action(*)
{
    ToolTip(ogcGui1Button36Action.Text)
    Sleep(1000)
    ToolTip()
}


Gui1Button37Action(*)
{
    DestroyGui()

    ToolTip("Please wait... Opening WSL Ubuntu Bash shell")
    Sleep(500)
    ToolTip()

    ; Launch directly into the bash shell of Ubuntu
    ;Run('wt.exe -p "Ubuntu-22.04" -- wsl -d Ubuntu-22.04 -e bash -l')

    Run("wt.exe")
    /*
    🔧 To Set WSL as the Default Profile:

    i. Open Windows Terminal.
    ii. Click the down arrow (˅) next to the tab bar → choose Settings.
    iii. In Startup, set the Default profile to your desired WSL distribution (e.g., "Ubuntu").
    iv. Now, every time you open Windows Terminal, it starts in WSL by default.
    */

    global guiOpen, VIM_NORMAL_SPACE_MODE, SYMBOL_MODE, NUMBER_MODE
    global TOGGLE, INSERT_MODE, INSERT_MODE_II

        guiOpen := false
        VIM_NORMAL_SPACE_MODE := false
        SYMBOL_MODE := false
        NUMBER_MODE := false
        INSERT_MODE := true

        if TOGGLE {
            INSERT_MODE_II := true
            ToolTip("Index", index_TooltipX, 0, 1)
        }
}


/*
Gui1Button37Action(*)
{
    ToolTip('Please wait opening- Ubuntu: Bourne Again shell (bash)')

    Sleep(1000)
    ToolTip()
}
*/

Gui1Button38Action(*)
{
    ToolTip(ogcGui1Button38Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button39Action(*)
{
    ToolTip(ogcGui1Button39Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button40Action(*)
{
    ToolTip(ogcGui1Button40Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button41Action(*)
{
    ToolTip(ogcGui1Button41Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button42Action(*)
{
    ToolTip(ogcGui1Button42Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button43Action(*)
{
    ToolTip(ogcGui1Button43Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button44Action(*)
{
    ToolTip(ogcGui1Button44Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui1Button45Action(*)
{
    ToolTip(ogcGui1Button45Action.Text)
    Sleep(1000)
    ToolTip()
}

; ---------------------------------Gui2-----------------------------------------

Gui2Button15Action(*) {
    ToolTip(ogcGui2Button15Action.Text)
    Sleep(1000)
    ToolTip()
}

Gui2Button28Action(*)
{
    ToolTip(ogcGui2Button28Action.Text)
    Sleep(1000)
    ToolTip()
}