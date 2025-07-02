/*
  ----------------------------------------------
  ----------------------------------------------
  ----------------change volume-----------------
  ----------------------------------------------
  ----------------------------------------------
*/

#HotIf MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp:: Send "{Volume_Up}"
WheelDown:: Send "{Volume_Down}"
#HotIf

MouseIsOver(WinTitle)
{
    MouseGetPos(, , &Win)
    Return WinExist(WinTitle . " ahk_id " . Win)
}
