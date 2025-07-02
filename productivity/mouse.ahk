/*
   -----------------------------------------------
   ---------------Productivity mouse--------------
   -----------------------------------------------
   -----------------------------------------------
*/

global gui50 := ""

MButton::
{
    CoordMode("Mouse", "Screen")
    MouseGetPos(&XposA, &YposA)
    XposA -= 80
    YposA -= 80

    ; Check if Gui(50) already exists and destroy it if so
    global gui50  ; Declare the GUI variable globally
    if IsObject(gui50)
        gui50.Destroy()

    gui50 := Gui(50)  ; Create a new GUI object
    gui50.BackColor := "EEAA99"

    ;Set 0x000000 (black) to be transparent (A: 255)
    WinSetTransColor((gui50.BackColor := 000000) ' 255', gui50)

    ; Buttons (1st column)
    gui50.Add("Button", "x2 y0 w50 h50 BackgroundTrans", "Button 1").OnEvent("Click", dothis10)
    gui50.Add("Button", "x2 y60 w50 h50 BackgroundTrans", "Undo").OnEvent("Click", dothis20)
    gui50.Add("Button", "x2 y120 w50 h50 BackgroundTrans", "Redo").OnEvent("Click", dothis30)
    gui50.Add("Button", "x2 y180 w50 h50 BackgroundTrans")
    gui50.Add("Button", "x2 y240 w50 h50 BackgroundTrans")

    ; Buttons (2nd column)
    gui50.Add("Button", "x62 y0 w50 h50")
    gui50.Add("Button", "x62 y60 w50 h50 BackgroundTrans", "Cut").OnEvent("Click", dothis3)
    gui50.Add("Button", "x62 y120 w50 h50 BackgroundTrans", "Close").OnEvent("Click", closewarnmenu)
    gui50.Add("Button", "x62 y180 w50 h50 BackgroundTrans", "New Button 9").OnEvent("Click", dothis14)
    gui50.Add("Button", "x62 y240 w50 h50 BackgroundTrans", "New Button 10").OnEvent("Click", dothis15)

    ; Buttons (3rd column)
    gui50.Add("Button", "x122 y0 w50 h50 BackgroundTrans", "Minimize").OnEvent("Click", dothis5)
    gui50.Add("Button", "x122 y60 w50 h50 BackgroundTrans", "Copy").OnEvent("Click", dothis4)
    gui50.Add("Button", "x122 y180 w50 h50 BackgroundTrans", "New Button 11").OnEvent("Click", dothis11)
    gui50.Add("Button", "x122 y240 w50 h50 BackgroundTrans", "New Button 12").OnEvent("Click", dothis32)

    ; Buttons (4th column)
    gui50.Add("Button", "x182 y0 w50 h50 BackgroundTrans", "Maximize").OnEvent("Click", dothis1)
    gui50.Add("Button", "x182 y60 w50 h50 BackgroundTrans", "Paste").OnEvent("Click", dothis2)
    gui50.Add("Button", "x182 y120 w50 h50 BackgroundTrans", "New Button 13").OnEvent("Click", dothis13)
    gui50.Add("Button", "x182 y180 w50 h50 BackgroundTrans", "New Button 14").OnEvent("Click", dothis14)
    gui50.Add("Button", "x182 y240 w50 h50 BackgroundTrans", "New Button 59").OnEvent("Click", dothis59)

    ; Buttons (5th column)
    gui50.Add("Button", "x242 y0 w50 h50 BackgroundTrans", "WinClose").OnEvent("Click", dothis9)
    gui50.Add("Button", "x242 y60 w50 h50 BackgroundTrans", "Select All").OnEvent("Click", dothis100)
    gui50.Add("Button", "x242 y120 w50 h50 BackgroundTrans", "New Button 6").OnEvent("Click", dothis111)
    gui50.Add("Button", "x242 y180 w50 h50 BackgroundTrans", "New Button 99").OnEvent("Click", dothis99)
    gui50.Add("Button", "x242 y240 w50 h50 BackgroundTrans", "New Button 78").OnEvent("Click", dothis78)

    gui50.Opt("+LastFound +AlwaysOnTop +ToolWindow -Caption")
    gui50.Title := "menus"  ; Set the window title
    gui50.Show("x" XposA " y" YposA " h300 w299")  ; Show the GUI without a title parameter
}


closewarnmenu(*) {
    if IsObject(gui50)
        gui50.Destroy()
}

dothis1(*) {
    if IsObject(gui50)
        gui50.Destroy()
    WinMaximize("A")
}

dothis2(*) {
    Send("^p")
}

dothis3(*) {
    Send("^x")
}

dothis4(*) {
    Send("^c")
}

dothis5(*) {
    if IsObject(gui50)
        gui50.Destroy()
    WinMinimize("A")
}

dothis9(*) {
    if IsObject(gui50)
        gui50.Destroy()
    WinClose("A")
}

dothis10(*) {
    if IsObject(gui50)
        gui50.Destroy()
    MsgBox("New Button 5")
}

dothis11(*) {
    if IsObject(gui50)
        gui50.Destroy()

    MsgBox("New Button 6")
}

dothis13(*) {
    if IsObject(gui50)
        gui50.Destroy()

    MsgBox("New Button 8")
}

dothis14(*) {
    if IsObject(gui50)
        gui50.Destroy()

    MsgBox("New Button 9")
}

dothis15(*) {
    if IsObject(gui50)
        gui50.Destroy()

    MsgBox("New Button 10")
}

dothis20(*) {
    Send("^z")
}

dothis30(*) {
    Send("^y")
}

dothis32(*) {
    if IsObject(gui50)
        gui50.Destroy()
    MsgBox("New Button 17")
}

dothis59(*) {
    if IsObject(gui50)
        gui50.Destroy()
    MsgBox("New Button 59")
}

dothis78(*) {
    if IsObject(gui50)
        gui50.Destroy()
    MsgBox("New Button 78")
}

dothis100(*) {
    Send("^a")
}

dothis111(*) {
    if IsObject(gui50)
        gui50.Destroy()
    MsgBox("New Button 15")
}

dothis99(*) {
    if IsObject(gui50)
        gui50.Destroy()
    MsgBox("New Button 99")
}

;--------------------------------------------------------------

f1::
{
    MyMenu := Menu()
    MyMenu.Add("A Item 1", item1handler)
    MyMenu.Add("B Item 2", item2handler)
    MyMenu.Show()
}

item1handler(A_ThisMenuItem := "", A_ThisMenuItemPos := "", MyMenu := "", *) {
    MsgBox("You pressed item 1")
}

item2handler(A_ThisMenuItem := "", A_ThisMenuItemPos := "", MyMenu := "", *) {
    MsgBox("You pressed item 2")
}

;-----------------------------------------------------

/*
RButton::
{
    g := Morse(300)

    If (g = "00") {
    }
    Else If (g = "0")
        MsgBox("0 Pressed")
}
*/
