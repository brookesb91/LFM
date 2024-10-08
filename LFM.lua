LFM = CreateFrame("Frame")

local instances = {
  { name = "Ragefire Chasm",                matches = { "rfc" } },
  { name = "Wailing Caverns",               matches = { "wc" } },
  { name = "The Deadmines",                 matches = { "deadmines" } },
  { name = "Shadowfang Keep",               matches = { "sfk" } },
  { name = "Blackfathom Deeps",             matches = { "bfd" } },
  { name = "The Stockade",                  matches = { "stocks" } },
  { name = "Gnomeregan",                    matches = { "gnome" } },
  { name = "Razorfen Kraul",                matches = { "rfk" } },
  { name = "Scarlet Monastery - Graveyard", matches = { "gy" } },
  { name = "Scarlet Monastery - Library",   matches = { "lib" } },
  { name = "Scarlet Monastery - Armory",    matches = { "arm" } },
  { name = "Scarlet Monastery - Cathedral", matches = { "cath" } },
  { name = "Razorfen Downs",                matches = { "rfd" } },
  { name = "Uldaman",                       matches = { "ulda" } },
  { name = "Zul'Farrak",                    matches = { "zf" } },
  { name = "Maraudon",                      matches = { "mara" } },
  { name = "Temple of Atal'Hakkar",         matches = { "st" } },
  { name = "Blackrock Depths",              matches = { "brd" } },
  { name = "Lower Blackrock Spire",         matches = { "lbrs" } },
  { name = "Upper Blackrock Spire",         matches = { "ubrs" } },
  { name = "Dire Maul - East",              matches = { "dire maul east", "dm east", "dme" } },
  { name = "Dire Maul - West",              matches = { "dire maul west", "dm west", "dmw" } },
  { name = "Dire Maul - North",             matches = { "dire maul north", "dm north", "dmn", "dmt", "tribute" } },
  { name = "Stratholme",                    matches = { "strat", "strath" } },
  { name = "Scholomance",                   matches = { "scholo" } },
  { name = "Demon Fall Canyon",             matches = { "dfc" } },
  { name = "Crystal Vale",                  matches = { "thunderaan", "prince" } },
  { name = "Molten Core",                   matches = { "mc" } },
  { name = "Onyxia's Lair",                 matches = { "ony", "onyxia" } },
  { name = "Blackwing Lair",                matches = { "bwl" } },
  { name = "Zul'Gurub",                     matches = { "zg" } },
  { name = "Ruins of Ahn'Qiraj",            matches = { "aq20" } },
  { name = "Temple of Ahn'Qiraj",           matches = { "aq40" } },
  { name = "Naxxramas",                     matches = { "naxx" } }
}

local roles = {
  { name = "Tank",   matches = { "tank", "tanks" },                      color = "FF4D85E6", icon = "Interface\\Icons\\INV_Shield_06" },
  { name = "Healer", matches = { "heal", "healer", "healers", "heals" }, color = "FF85FF85", icon = "Interface\\Icons\\Spell_Holy_Heal02" },
  { name = "DPS",    matches = { "dps", "dd", "rdps" },                  color = "FFFF6B6B", icon = "Interface\\Icons\\INV_Sword_39" }
}

local class_icons = {
  ["druid"] = "Interface\\Icons\\ClassIcon_Druid",
  ["hunter"] = "Interface\\Icons\\ClassIcon_Hunter",
  ["mage"] = "Interface\\Icons\\ClassIcon_Mage",
  ["paladin"] = "Interface\\Icons\\ClassIcon_Paladin",
  ["priest"] = "Interface\\Icons\\ClassIcon_Priest",
  ["rogue"] = "Interface\\Icons\\ClassIcon_Rogue",
  ["shaman"] = "Interface\\Icons\\ClassIcon_Shaman",
  ["warlock"] = "Interface\\Icons\\ClassIcon_Warlock",
  ["warrior"] = "Interface\\Icons\\ClassIcon_Warrior"
}

local race_icons = {
  ["human"] = "Interface\\Icons\\INV_Misc_Head_Human_01",
  ["dwarf"] = "Interface\\Icons\\INV_Misc_Head_Dwarf_01",
  ["night elf"] = "Interface\\Icons\\INV_Misc_Head_Elf_02",
  ["gnome"] = "Interface\\Icons\\INV_Misc_Head_Gnome_01",
  ["orc"] = "Interface\\Icons\\INV_Misc_Head_Orc_01",
  ["undead"] = "Interface\\Icons\\INV_Misc_Head_Undead_01",
  ["tauren"] = "Interface\\Icons\\INV_Misc_Head_Tauren_01",
  ["troll"] = "Interface\\Icons\\INV_Misc_Head_Troll_01"
}

local enabled = false

local function enable()
  if enabled then
    return
  end

  enabled = true
  LFM:RegisterEvent("CHAT_MSG_CHANNEL")
  DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00LFM enabled")
end

local function disable()
  if not enabled then
    return
  end

  enabled = false
  LFM:UnregisterEvent("CHAT_MSG_CHANNEL")
  DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000LFM disabled")
end

LFM:SetScript("OnEvent", function(self, event, ...)
  if event == "CHAT_MSG_CHANNEL" then
    local message, player = ...
    local guid = select(12, ...)
    local text = string.lower(message)
    local notification = "|cFFFF80FF|Hplayer:" .. player .. "|h[" .. player .. "]|h"

    if text:match("lf(%d?)m") then
      notification = notification .. " |cFF40C040LFM"
    elseif text:match("lfg") then
      notification = notification .. " |cFF8080FFLFG"
    else
      return
    end

    local matched_instance = false

    for _, entry in ipairs(instances) do
      for _, match in ipairs(entry.matches) do
        if text:match("%f[%w_]" .. match .. "%f[^%w_]") then
          notification = notification .. " |cFFFFFF00[" .. entry.name .. "]"
          matched_instance = true
          break
        end
      end
    end

    if not matched_instance then
      return
    end

    for _, entry in ipairs(roles) do
      for _, match in ipairs(entry.matches) do
        if text:match(match) then
          notification = notification ..
              " |c" .. entry.color .. "[|T" .. entry.icon .. ":14|t " .. entry.name .. "]"
          break
        end
      end
    end

    local class, _, race = GetPlayerInfoByGUID(guid)

    notification = "|T" .. race_icons[race:lower()] .. ":14|t|T" .. class_icons[class:lower()] .. ":14|t" .. notification

    DEFAULT_CHAT_FRAME:AddMessage(notification)
  end
end)

SLASH_LFM1 = "/lfm"

SlashCmdList["LFM"] = function(msg)
  if enabled then
    disable()
  else
    enable()
  end
end
