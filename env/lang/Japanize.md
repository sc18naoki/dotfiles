# how to enable TOGGLE Japanese/English on US-Key Ubuntu

---

1. requirement

Japanese(Mozc)

install it from "settings" -> "Region & Language" -> "Input Sources", and type "+" button.

2. config

a). unset ubuntu keybind

"settings" -> "Devices" -> "Keyboard" -> "Typing",

then Disable switch source.

b). configure Mozc

Go Mozc's property.

"Keymap" -> "Customize"

for column,

- Direct input : {prefered_keybind} : Activate IME

- Precomposition : {prefered_keybind} : Deactivate IME

3. reboot application

NOTE:

toggle with SUPER(CMD|Alt)+any_key is not supported.
