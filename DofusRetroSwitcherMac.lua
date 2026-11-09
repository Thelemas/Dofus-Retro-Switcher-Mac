-- =========================================================
--  Dofus Retro Switcher pour macOS (Hammerspoon)
--  Auteur : Thelemas - https://github.com/Thelemas/DofusRetroSwitcherMac
--  Licence GPL-3.0 - Merci de conserver cette mention en cas de réutilisation.
-- =========================================================-- =========================================================
--  Dofus Retro - Switcher de comptes pour macOS (Hammerspoon)
-- =========================================================

-- Texte contenu dans le NOM DE L'APP Dofus (Alt+D pour vérifier)
local MATCH = "Dofus"

-- Ordre de tes persos (nom tel qu'il apparaît dans le titre de la fenêtre).
-- Laisse vide pour utiliser l'ordre d'ouverture des fenêtres.
local ORDRE = {
  -- "Perso1",
  -- "Perso2",
  -- "Perso3",
}

---------------------------------------------------------------

local function isDofus(w)
  if not w or not w:isStandard() then return false end
  local app = w:application()
  local appName = app and app:name() or ""
  return appName:find(MATCH, 1, true) ~= nil
end

local function rang(w)
  local title = w:title() or ""
  for i, nom in ipairs(ORDRE) do
    if title:find(nom, 1, true) then return i end
  end
  return 1000 + w:id()  -- sinon ordre d'ouverture
end

local function fenetres()
  local list = {}
  for _, w in ipairs(hs.window.allWindows()) do
    if isDofus(w) then table.insert(list, w) end
  end
  table.sort(list, function(a, b) return rang(a) < rang(b) end)
  return list
end

local function nomPerso(w)
  local t = w:title() or "?"
  return t:match("^(.-)%s+%-%s+") or t
end

local function activer(w)
  if w:isMinimized() then w:unminimize() end
  w:focus()
  hs.alert.closeAll()
  hs.alert.show(nomPerso(w), 0.6)
end

local function cycler(sens)
  local list = fenetres()
  if #list == 0 then hs.alert.show("Aucune fenêtre Dofus trouvée") return end
  local cur = hs.window.focusedWindow()
  local idx = 0
  for i, w in ipairs(list) do
    if cur and w:id() == cur:id() then idx = i break end
  end
  local cible = (idx == 0) and 1 or ((idx - 1 + sens) % #list) + 1
  activer(list[cible])
end

-- Alt+Tab : compte suivant / Alt+Shift+Tab : précédent
hs.hotkey.bind({"alt"}, "tab", function() cycler(1) end)
hs.hotkey.bind({"alt", "shift"}, "tab", function() cycler(-1) end)

-- Alt+1..8 : accès direct au compte n° X (keycodes => marche en AZERTY)
local touchesChiffres = {18, 19, 20, 21, 23, 22, 26, 28}
for i, kc in ipairs(touchesChiffres) do
  hs.hotkey.bind({"alt"}, kc, function()
    local list = fenetres()
    if list[i] then activer(list[i]) end
  end)
end

-- Boutons latéraux de la souris : avant = suivant, arrière = précédent
mouseTap = hs.eventtap.new({hs.eventtap.event.types.otherMouseDown}, function(e)
  local btn = e:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)
  if btn == 4 then cycler(1) return true end
  if btn == 3 then cycler(-1) return true end
  return false
end)
mouseTap:start()

-- Alt+D : debug, liste les apps/fenêtres ouvertes dans la console
hs.hotkey.bind({"alt"}, "d", function()
  local lignes = {}
  for _, w in ipairs(hs.window.allWindows()) do
    local app = w:application()
    table.insert(lignes, (app and app:name() or "?") .. "  |  " .. (w:title() or ""))
  end
  print("\n" .. table.concat(lignes, "\n"))
  hs.openConsole()
end)

hs.alert.show("Dofus switcher chargé")
