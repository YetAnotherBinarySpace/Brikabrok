--[[

        _______      ______   ______ _____ _     _ _______ ______   ______  _____  _     _
 |      |______      |_____] |_____/   |   |____/  |_____| |_____] |_____/ |     | |____/ 
 |_____ |______      |_____] |    \_ __|__ |    \_ |     | |_____] |    \_ |_____| |    \_
                                                                                          

    MIT License

    Copyright (c) 2018 BinarySpace

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

--]]

local Brikabrok = LibStub("AceAddon-3.0"):GetAddon("Brikabrok")
BrikabrokTRINITYLINKS = Brikabrok:NewModule("TRINITYLINKS", "AceHook-3.0")


function BrikabrokTRINITYLINKS:OnEnable()


-- Regex is meh, really
local trinityLinks = {
	{"(|cff%x%x%x%x%x%x|Hspell:(%d+)|h[^|]+|h|r)", "%1 |cffffff00|Hcommand:.learn %2|h[Apprendre]|h|r |cffffff00|Hcommand:.unlearn %2|h[Oublier]|h|r"},
	{"(|cff%x%x%x%x%x%x|Hgameobject:%d+|h[^|]+|h|r GUID: (%d+)) (ID: (%d+))", "%1 |cffffffff|Hcommand:.gob activate %2|h[Activer]|h|r |cffffffff|Hcommand:.gob delete %2|h[Supprimer]|h|r %3 |cffffffff|Hcommand:.gob add %4|h[Spawn]|h|r"},
	{"(|cff%x%x%x%x%x%x|Hgameobject_entry:(%d+)|h[^|]+|h|r)", "%1 |cffffff00|Hcommand:.gob add %2|h[Spawn]|h|r"},
	{"(|cff%x%x%x%x%x%x|Hcreature_entry:(%d+)|h[^|]+|h|r)", "%1 |cffffff00|Hcommand:.npc add %2|h[Spawn]|h|r"},
	{"(|cff%x%x%x%x%x%x|Hfaction:(%d+)|h[^|]+|h|r)", "%1 |cffffff00|Hcommand:.mod rep %2 exalted|h[S'exalter]|h|r"},
	{"(|cff%x%x%x%x%x%x|Hitemset:(%d+)|h[^|]+|h|r)", "%1 |cffffff00|Hcommand:.additemset %2|h[Ajouter]|h|r"},
	{"(|cff%x%x%x%x%x%x|Hitem:(.*)%|h%[(.*)%]%|h%|r)", "%1 |cffffff00|Hcommand:.add %2|h[Ajouter]|h|r"},
	{"(|cff%x%x%x%x%x%x|Htele:(%d+)|h[^|]+|h|r)", "%1 |cffffff00|Hcommand:.tele %2|h[Se téléporter]|h|r"},
}

function Brikabrok.getLinks(self, event, message, ...)
	if Brikabrok.db.profile.dynamic_links.active then 
		for i=1,#trinityLinks do
			if message:find(trinityLinks[i][1]) then
				message = message:gsub(trinityLinks[i][1], trinityLinks[i][2])
			end
		end
	end
	return false, message, ...
end

for k, v in pairs({"EMOTE", "GUILD", "OFFICER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "SAY", "SYSTEM", "WHISPER", "WHISPER_INFORM", "YELL"}) do
	if Brikabrok.db.profile.dynamic_links.active and IsAddOnLoaded("TrinityAdmin") then
		Brikabrok.sendMessage("[Brikabrok] Vous avez TrinityAdmin d'activé ainsi que l'option 'Liens', ce qui peut causer un conflit, veuillez déactiver l'un des deux.","WARNING")
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, Brikabrok.getLinks)
end

local oldHyperlink = ItemRefTooltip.SetHyperlink -- Save the function here to be able to call it later
function ItemRefTooltip:SetHyperlink(data, ...)
	local linkType, chatReplace = strsplit(":", data)
	if linkType == "command" then
		SendChatMessage(chatReplace, "GUILD")
	else
		oldHyperlink(self, data, ...)
	end
end


end