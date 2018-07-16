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
	{"(|cff%x%x%x%x%x%x|Hgameobject:%d+|h[^|]+|h|r GUID: (%d+)) (ID: (%d+))", "%1 |cffffffff|Hcommand:.go object %2|h[Aller à]|h|r |cffffffff|Hcommand:.gob move %2|h[Déplacer]|h|r |cffffffff|Hcommand:.gob activate %2|h[Activer]|h|r |cffffffff|Hcommand:.gob delete %2|h[Supprimer]|h|r %3 |cffffffff|Hcommand:.gob add %4|h[Spawn]|h|r"},
	{"(|cff%x%x%x%x%x%x|Hgameobject_entry:(%d+)|h[^|]+|h|r)", "%1 |cffffff00|Hcommand:.gob add %2|h[Spawn]|h|r"},
	{"(|cff%x%x%x%x%x%x|Hcreature_entry:(%d+)|h[^|]+|h|r)", "%1 |cffffff00|Hcommand:.np add %2|h[Spawn]|h|r"},
	{"(|cff%x%x%x%x%x%x|Hfaction:(%d+)|h[^|]+|h|r)", "%1 |cffffff00|Hcommand:.mod rep %2 exalted|h[S'exalter]|h|r"},
	{"(|cff%x%x%x%x%x%x|Hitemset:(%d+)|h[^|]+|h|r)", "%1 |cffffff00|Hcommand:.additemset %2|h[Ajouter]|h|r"},
	{"(|cff%x%x%x%x%x%x|Hitem:(.*)%|h%[(.*)%]%|h%|r)", "%1 |cffffff00|Hcommand:.add %2|h[Ajouter]|h|r"},
	{"(|cff%x%x%x%x%x%x|Htele:(%d+)|h[^|]+|h|r)", "%1 |cffffff00|Hcommand:.tele %2|h[Se téléporter]|h|r"},
}

local wrapperNoLinks = {
	{"Entry: (%d+)%.","(Entry: (%d+)%.)","(Entry: %1.)"},
	{"%((GUID: (%d+))%)","%((GUID: (%d+))%)","(GUID: %1)"},
	{"Object '(%d+)","Object '(%d+)'","(Object '%1')"},
	{"(DisplayID: (%d+))","(DisplayID: (%d+))","(DisplayID: %1)"},
	{"%((Native: (%d+))%)","%((Native: (%d+))%)","(Native: %1)"}
}

local idWrapper = "%1"

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


function Brikabrok.wrapperLinks(self,event,msg,...)
	local table = wrapperNoLinks
	if Brikabrok.db.profile.dynamic_links.active then 
		for guid in string.gmatch(msg, table[1][1]) do 
			local npcINFO = table[1][3].." - |cffffffff|Hcommand:.np add %2|h[Spawn]|h|r"
			msg = msg:gsub(table[1][2], npcINFO)
		end
		for guid in string.gmatch(msg, table[4][1]) do
			local npcDisplay = table[4][3].." - |cffffffff|Hcommand:.morph %2|h[Morph]|h|r"
			msg = msg:gsub(table[4][2], npcDisplay)
		end
		for guid in string.gmatch(msg, table[5][1]) do
			local npcNative = table[5][3].." - |cffffffff|Hcommand:.morph %2|h[Morph]|h|r"
			msg = msg:gsub(table[5][2], npcNative)
		end
		for guid in string.gmatch(msg, table[3][1]) do 
			local gobSpawn1 = table[3][3].." - |cffffffff|Hcommand:.gob add %1|h[Spawn]|h|r"
			msg = msg:gsub(table[3][2], gobSpawn1)
		end
		for guid in string.gmatch(msg, table[2][1]) do
			local gobSpawn = table[2][3].." - |cffffffff|Hcommand:.go object %2|h[Aller à]|h|r |cffffffff|Hcommand:.gob move %2|h[Déplacer]|h|r |cffffffff|Hcommand:.gob activate %2|h[Activer]|h|r |cffffffff|Hcommand:.gob delete %2|h[Supprimer]|h|r"
			msg = msg:gsub(table[2][2], gobSpawn)
		end
    end
    return false, msg, ...
end


for k, v in pairs({"EMOTE", "GUILD", "OFFICER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "SAY", "SYSTEM", "WHISPER", "WHISPER_INFORM", "YELL"}) do
	ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, Brikabrok.getLinks)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, Brikabrok.wrapperLinks)
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