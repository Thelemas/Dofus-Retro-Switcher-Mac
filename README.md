[🇫🇷 Français](README.fr.md) | 🇬🇧 English

# Dofus Retro Switcher for macOS

Switch between accounts with a single shortcut when playing **Dofus Retro with multiple accounts on Mac**, just like the organizers on Windows.

Built on [Hammerspoon](https://www.hammerspoon.org/), a free and open-source automation tool for macOS.

---

## Features

| Shortcut | Action |
|---|---|
| `⌥ Option` + `Tab` | Next account |
| `⌥ Option` + `⇧ Shift` + `Tab` | Previous account |
| `⌥ Option` + `1` to `8` | Jump directly to account #X |
| Mouse side button (forward) | Next account |
| Mouse side button (back) | Previous account |
| `⌥ Option` + `D` | Debug: list open windows |

A small popup shows the active character's name on each switch.

> 💡 The **Alt** key on Mac is **⌥ Option** (between `Ctrl` and `Cmd`).

---

## Installation

### 1. Install Homebrew

Homebrew is a package manager for macOS. Open **Terminal** (`Cmd + Space`, then type "Terminal") and paste:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the instructions. Your session password will be requested; characters don't show while typing, that's normal.

**On Apple Silicon Macs (M1, M2, M3, M4…)**, then add Homebrew to your PATH:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Check that it works:

```bash
brew --version
```

### 2. Install Hammerspoon

```bash
brew install --cask hammerspoon
```

> Without Homebrew: download the `.zip` from [hammerspoon.org](https://www.hammerspoon.org/), unzip it and drag **Hammerspoon.app** into **Applications**.

### 3. Launch Hammerspoon and allow Accessibility

1. Open **Hammerspoon** from Applications. If macOS blocks it: right-click, then **Open**.
2. Go to **System Settings** > **Privacy & Security** > **Accessibility**.
3. Enable **Hammerspoon**.

### 4. Install the script

In Terminal:

```bash
mkdir -p ~/.hammerspoon
curl -o ~/.hammerspoon/init.lua https://raw.githubusercontent.com/Thelemas/DofusRetroSwitcherMac/main/DofusRetroSwitcherMac.lua
```

> The `DofusRetroSwitcherMac.lua` script is saved as `init.lua`, the only file Hammerspoon loads at startup.

> ⚠️ If you already have a Hammerspoon `init.lua`, this command will overwrite it. Back it up first, or add the script's content to your existing file.

Then click the **Hammerspoon** icon in the menu bar, then **Reload Config**.
The message "Dofus switcher chargé" should appear. ✅

---

## Configuration (optional)

Open `~/.hammerspoon/init.lua` in a text editor. In Finder, `Cmd + Shift + G` then `~/.hammerspoon` takes you there.

### Set your characters' order

By default, windows are sorted by the order they were opened. To force an order (e.g. your initiative order), fill the `ORDRE` list with your characters' names as they appear in the window titles:

```lua
local ORDRE = {
  "MyIop",
  "MyEni",
  "MyCra",
}
```

### If no window is detected

1. Press `⌥ Option` + `D`: the console lists all open windows as `AppName | Title`.
2. Find the exact name of the Dofus Retro app.
3. Put it in the `MATCH` variable:

```lua
local MATCH = "Dofus"
```

### Change the shortcuts

Replace `{"alt"}` with `{"ctrl"}`, `{"cmd"}` or a combination like `{"ctrl", "alt"}`. Avoid `cmd` + `tab`, which macOS already uses.

After any change, click **Reload Config**.

---

## Tips

- **Play in windowed mode**, not fullscreen. In fullscreen, macOS puts each window in a separate Space, which makes switching slow or unreliable.
- The script only switches windows (one keypress = one switch, like Windows organizers). It does not automate any in-game action.

---

## Credits

Created by **Thelemas** – [github.com/Thelemas/DofusRetroSwitcherMac](https://github.com/Thelemas/DofusRetroSwitcherMac)

If you reuse or modify this script, please keep the author notice and credit this repo. 🙂

## 📄 License

Released under the [MIT](LICENSE) license.
