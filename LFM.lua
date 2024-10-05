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
  { name = "Dire Maul - East",              matches = { "dm east", "dme" } },
  { name = "Dire Maul - West",              matches = { "dm west", "dmw" } },
  { name = "Dire Maul - North",             matches = { "dm north", "dmn" } },
  { name = "Stratholme",                    matches = { "strat" } },
  { name = "Scholomance",                   matches = { "scholo" } },
  { name = "Demon Fall Canyon",             matches = { "dfc" } },
  { name = "Molten Core",                   matches = { "mc" } },
  { name = "Onyxia's Lair",                 matches = { "ony" } },
  { name = "Blackwing Lair",                matches = { "bwl" } },
  { name = "Zul'Gurub",                     matches = { "zg" } },
  { name = "Ruins of Ahn'Qiraj",            matches = { "aq20" } },
  { name = "Temple of Ahn'Qiraj",           matches = { "aq40" } },
  { name = "Naxxramas",                     matches = { "naxx" } }
}

local roles = {
  { name = "Tank",   matches = { "tank", "tanks" },                      color = "FF4D85E6" },
  { name = "Healer", matches = { "heal", "healer", "healers", "heals" }, color = "FF85FF85" },
  { name = "DPS",    matches = { "dps", "dd", "rdps" },                  color = "FFFF6B6B" }
}

LFM:RegisterEvent("CHAT_MSG_CHANNEL")

LFM:SetScript("OnEvent", function(self, event, ...)
  if event == "CHAT_MSG_CHANNEL" then
    local message, player = ...
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
          notification = notification .. " |c" .. entry.color .. "[" .. entry.name .. "]"
          break
        end
      end
    end

    DEFAULT_CHAT_FRAME:AddMessage(notification)
  end
end)
