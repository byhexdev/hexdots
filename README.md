# dots

> *🩸 my dotfiles. they're messy, but they're mine.*


---

## 🕯️ what's inside

| what | how |
|------|-----|
| 🪟 **hyprland** | wayland compositor. my precious. my beloved. |
| 💜 **kitty** | terminal. fast. pretty. likes it rough. |
| 🔪 **nvim** | neovim via lazyvim. i'm not that deep yet |
| 🎀 **rofi** | app launcher + powermenu. it just works. |
| 🩹 **swaync** | notification center. tells me my battery is dying. |
| 🕸️ **waybar** | status bar. i look at it a lot. |
| 🖼️ **hyprpaper** | wallpaper. pretty pictures. |

---

## 🌸 colorscheme

we stay **earthy** in these parts. browns, creams, shadows.

| role | hex |
|------|-----|
| 🥀 primary | `#7f4f24` |
| 🍂 secondary | `#b6ad90` |
| 🩸 shadow | `#582f0e` |
| 🌑 background | `#0b1215` |
| 🕯️ foreground | `#dccba6` |

---

## 🔪 fonts

- **jetbrains mono nerd font** — for when i'm typing
- **go mono nerd font** — for when i'm looking at things
- lots of little icons to make the emptiness feel less empty

---

## 🦇 keybind highlights

- `super + ?` — do a thing
- `alt + space` — find a thing
- `alt + shift` — speak a different thing
- `super + backspace` — leave this mortal plane (powermenu)
- `ctrl + print` — screenshot a thing
- `ctrl + pause` — pick a color, any color

---

## 🩹 restore.sh

> *one script to bring them all and in the darkness bind them*

```bash
chmod +x restore.sh && ./restore.sh
```

installs everything from `pkg.txt` and `aur.txt`, backs up your old broken configs, and symlinks mine in their place. like putting a fresh bandage on an old wound.

includes 🎀 **throne** (a vpn because fuck liberty of speech).

---

## 💀 requirements

- some archable os
- hyprland
