  🇫🇷 Français | [🇬🇧 English](README.md)
# Dofus Retro Switcher pour macOS

Passe d'un compte à l'autre en un raccourci quand tu joues à **Dofus Retro en multi-compte sur Mac**, comme les organizers sur Windows.

Basé sur [Hammerspoon](https://www.hammerspoon.org/), un outil gratuit et open source d'automatisation pour macOS.

---

## Fonctionnalités

| Raccourci | Action |
|---|---|
| `⌥ Option` + `Tab` | Compte suivant |
| `⌥ Option` + `⇧ Shift` + `Tab` | Compte précédent |
| `⌥ Option` + `1` à `8` | Accès direct au compte n°X |
| Bouton latéral souris (avant) | Compte suivant |
| Bouton latéral souris (arrière) | Compte précédent |
| `⌥ Option` + `D` | Debug : liste les fenêtres ouvertes |

Un petit popup affiche le nom du personnage actif à chaque changement.

> 💡 La touche **Alt** sur Mac, c'est **⌥ Option** (entre `Ctrl` et `Cmd`).

---

## Installation

### 1. Installer Homebrew

Homebrew est un gestionnaire de paquets pour macOS. Ouvre le **Terminal** (`Cmd + Espace`, puis tape « Terminal ») et colle :

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Suis les instructions : ton mot de passe de session sera demandé. Les caractères ne s'affichent pas pendant la saisie, c'est normal.

**Sur Mac Apple Silicon (M1, M2, M3, M4…)**, ajoute ensuite Homebrew au PATH :

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Vérifie que ça marche :

```bash
brew --version
```

### 2. Installer Hammerspoon

```bash
brew install --cask hammerspoon
```

> Sans Homebrew : télécharge le `.zip` sur [hammerspoon.org](https://www.hammerspoon.org/), dézippe-le et glisse **Hammerspoon.app** dans **Applications**.

### 3. Lancer Hammerspoon et autoriser l'Accessibilité

1. Ouvre **Hammerspoon** depuis Applications. Si macOS bloque l'ouverture : clic droit, puis **Ouvrir**.
2. Va dans **Réglages Système** > **Confidentialité et sécurité** > **Accessibilité**.
3. Active **Hammerspoon**.

### 4. Installer le script

Dans le Terminal :

```bash
mkdir -p ~/.hammerspoon
curl -L -o ~/.hammerspoon/init.lua https://github.com/Thelemas/DofusRetroSwitcherMac/releases/latest/download/DofusRetroSwitcherMac.lua
```

> Le script `DofusRetroSwitcherMac.lua` est enregistré sous le nom `init.lua`, le seul fichier que Hammerspoon charge au démarrage.

> ⚠️ Si tu as déjà un `init.lua` Hammerspoon, cette commande l'écrase. Fais une sauvegarde avant, ou ajoute le contenu du script à ton fichier existant.

Ensuite, clique sur l'icône **Hammerspoon** dans la barre de menu, puis sur **Reload Config**.
Le message « Dofus switcher chargé » doit s'afficher. ✅

---

## Configuration (optionnel)

Ouvre `~/.hammerspoon/init.lua` avec un éditeur de texte. Dans le Finder, `Cmd + Shift + G` puis `~/.hammerspoon` permet d'y accéder.

### Définir l'ordre de tes personnages

Par défaut, les fenêtres sont triées dans leur ordre d'ouverture. Pour forcer un ordre, par exemple ton ordre d'initiative, remplis la liste `ORDRE` avec les noms de tes persos tels qu'ils apparaissent dans le titre des fenêtres :

```lua
local ORDRE = {
  "MonIop",
  "MonEni",
  "MonCra",
}
```

### Si aucune fenêtre n'est détectée

1. Appuie sur `⌥ Option` + `D` : la console liste toutes les fenêtres ouvertes au format `NomDeLApp | Titre`.
2. Repère le nom exact de l'application Dofus Retro.
3. Mets-le dans la variable `MATCH` :

```lua
local MATCH = "Dofus"
```

### Changer les raccourcis

Remplace `{"alt"}` par `{"ctrl"}`, `{"cmd"}` ou une combinaison comme `{"ctrl", "alt"}`. Évite `cmd` + `tab`, déjà utilisé par macOS.

Après chaque modification, fais **Reload Config**.

---

## Conseils

- **Joue en mode fenêtré**, pas en plein écran. En plein écran, macOS place chaque fenêtre dans un Space séparé, ce qui rend le changement lent ou instable.
- Le script se contente de changer de fenêtre : une touche = un changement, comme les organizers Windows. Il n'automatise aucune action en jeu.

---

## Crédits

Créé par **Thelemas** – [github.com/Thelemas/DofusRetroSwitcherMac](https://github.com/Thelemas/DofusRetroSwitcherMac)

Si tu réutilises ou modifies ce script, merci de conserver la mention d'auteur et de créditer ce repo. 🙂

## 📄 Licence

Released under the [GPL-3.0](LICENSE) license
