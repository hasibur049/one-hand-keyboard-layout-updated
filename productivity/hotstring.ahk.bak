/*
   ----------------------------------------------
   ----------------------------------------------
   -----------------Hotstring--------------------
   ----------------------------------------------
   ----------------------------------------------
*/

; Define your hotstring replacements
hotstrings := Map(
    "omg", "oh my god",
    "fyi", "for your information",
    "afaik", "as far as I know",
    "btw", "by the way",
    "ahk", "autohotkey",
    "s@", "shanto.ewu99@gmail.com"
)

typedText := ""

; Start capturing input
ih := InputHook("V")
ih.Start()

ih.OnChar := (ih, char) => typedText .= char

handleEnter() {
    global typedText, hotstrings
    if hotstrings.Has(typedText) {
        Send("{BS " typedText.Length "}")
        SendText(hotstrings[typedText])
    } else {
        Send("{Enter}")
    }
    typedText := ""
    ih.Start()
}
