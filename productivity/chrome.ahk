/*
   ----------------------------------------------
   ----------------------------------------------
   --------------chrome autmation----------------
   ----------------------------------------------
   ----------------------------------------------
*/

#HotIf WinActive("ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe",)
$space:: Send "{Space Down}"
$space Up:: Send "{Space Up}"
#HotIf