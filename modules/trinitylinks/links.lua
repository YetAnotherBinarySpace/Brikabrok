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
local StdUi = LibStub('StdUi');


function BrikabrokTRINITYLINKS:OnEnable()



-- Regex is meh, really
local trinityLinks = {
	{"(|cff%x%x%x%x%x%x|Hspell:(%d+)|h[^|]+|h|r)", "%1 |cffffff00|Hcommand:.learn %2|h[Apprendre]|h|r |cffffff00|Hcommand:.unlearn %2|h[Oublier]|h|r"},
	{"(|cff%x%x%x%x%x%x|Hgameobject:%d+|h[^|]+|h|r GUID: (%d+)) (ID: (%d+))", "%1 |cffffffff|Hcommand:.go object %2|h[Aller à]|h|r |cffffffff|Hcommand:.gob move %2|h[Déplacer]|h|r |cffffffff|Hcommand:.gob activate %2|h[Activer]|h|r |cffffffff|Hcommand:.gob delete %2|h[Supprimer]|h|r %3 |cffffffff|Hcommand:.gob add %4|h[Spawn]|h|r"},
	{"(|cff%x%x%x%x%x%x|Hgameobject_entry:(%d+)|h[^|]+|h|r)", "%1 |cffffff00|Hcommand:.gob add %2|h[Spawn]|h|r |cffffff00|Hcommand:.gob i %2|h[Preview]|h|r"},
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
	{"%((Native: (%d+))%)","%((Native: (%d+))%)","(Native: %1)"},
	{"DB GUID: (%d+)%,","(DB GUID: (%d+)%,)","(DB GUID: %1,)"},
}

function Brikabrok.getLinks(self, event, message, ...)
	if Brikabrok.db.profile.dynamic_links.active then
		if not spamNotify == true and IsAddOnLoaded("TrinityAdmin") then
		    StaticPopupDialogs["BrikabrokTrinity"] = {
      		text = "Avoir TrinityAdmin et Brikabrok d'activé peut créer des conflits, veuillez désactiver Trinity pour une meilleure utilisation.",
      		button1 = "Désactiver Trinity",
      		button2 = "Désactiver lien BKB",
      		OnAccept = function()
      			spamNotify = true
      			Brikabrok.db.profile.dynamic_links.active = true
      			DisableAddOn("TrinityAdmin")
          		ReloadUI()
      		end,
      		OnCancel = function()
            	spamNotify = true
                Brikabrok.db.profile.dynamic_links.active = false
                Brikabrok.formatMessage("Option 'liens' désactivée", "SIMPLE")
      		end,
      		timeout = 0,
      		whileDead = true,
      		hideOnEscape = true,
      		preferredIndex = 3,
    		}
    		StaticPopup_Show("BrikabrokTrinity")			
        end
        
		for i=1,#trinityLinks do
			if message:find(trinityLinks[i][1]) then
				message = message:gsub(trinityLinks[i][1], trinityLinks[i][2])
			end
		end
	end
	return false, message, ...
end


function Brikabrok.wrapperLinks(self,event,msg,...)
	if Brikabrok.db.profile.dynamic_links.active then
		if not spamNotify == true and IsAddOnLoaded("TrinityAdmin") then
		    StaticPopupDialogs["BrikabrokTrinity"] = {
      		text = "Avoir TrinityAdmin et Brikabrok d'activé peut créer des conflits, veuillez désactiver Trinity pour une meilleure utilisation.",
      		button1 = "Désactiver Trinity",
      		button2 = "Désactiver lien BKB",
      		OnAccept = function()
      			spamNotify = true
      			Brikabrok.db.profile.dynamic_links.active = true
      			DisableAddOn("TrinityAdmin")
          		ReloadUI()
      		end,
      		OnCancel = function()
            	spamNotify = true
                Brikabrok.db.profile.dynamic_links.active = false
                Brikabrok.formatMessage("Option 'liens' désactivée", "SIMPLE")
      		end,
      		timeout = 0,
      		whileDead = true,
      		hideOnEscape = true,
      		preferredIndex = 3,
    		}
    		StaticPopup_Show("BrikabrokTrinity")			
        end
    local table = wrapperNoLinks
	for guid in string.gmatch(msg, table[1][1]) do 
		local npcINFO = table[1][3].." - |cffffffff|Hcommand:.np add %2|h[Spawn]|h|r"
		msg = msg:gsub(table[1][2], npcINFO)
	end
	for guid in string.gmatch(msg,table[6][1]) do
		local npcGUID = table[6][3].. " - |cffffffff|Hcommand:.wp add %2|h[Add Waypoint]|h|r |cffffffff|Hcommand:.wp load %2|h[Waypoint Load]|h|r |cffffffff|Hcommand:.wp reload %2|h[Waypoint Reload]|h|r"
		msg = msg:gsub(table[6][2], npcGUID)
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

function Brikabrok:callPreview(input)
	Brikabrok.ShowPreview("Interface\\Buttons\\talktomequestionmark.m2")
end

function Brikabrok.ShowPreview(worldPath)
	   Brikabrok.previewWindow = StdUi:Window(nil, 'Le Brikabrok', 300, 400);
	   Brikabrok.previewWindow:SetPoint('CENTER');
	   
	   Brikabrok.previewModel = CreateFrame("DressUpModel", nil, Brikabrok.previewWindow, "ModelWithControlsTemplate")
	   Brikabrok.previewModel:SetModel(worldPath)
	   Brikabrok.previewModel:SetPoint("LEFT", Brikabrok.previewWindow, "LEFT")
	   Brikabrok.previewModel:SetPoint("RIGHT", Brikabrok.previewWindow, "RIGHT")
	   Brikabrok.previewModel:SetPoint("TOP", Brikabrok.previewWindow, "TOP",-55,-55)
	   Brikabrok.previewModel:SetPoint("BOTTOM", Brikabrok.previewWindow, "BOTTOM")


	   local editBox = StdUi:EditBox(Brikabrok.previewWindow, 100, 20, 'ID du gob');
	   StdUi:GlueBelow(editBox,Brikabrok.previewModel, 0, 0,"CENTER");
	   editBox.OnValueChanged = function(self)
	   	SendChatMessage(".gob info "..self.value,"GUILD")
	   end

	   local zoomButton = StdUi:SquareButton(Brikabrok.previewWindow, 20, 20, 'UP')
	   StdUi:GlueLeft(zoomButton,editBox, -30, 0,"LEFT");
	   zoomButton:SetScript('OnClick', function()
    		Brikabrok.previewModel:SetModelScale(Brikabrok.previewModel:GetModelScale() + .1)
	   end);



	   local unzoomButton = StdUi:SquareButton(Brikabrok.previewWindow, 20, 20, 'DOWN')
	   StdUi:GlueRight(unzoomButton,editBox, 30, 0,"RIGHT");
	   unzoomButton:SetScript('OnClick', function()
    		Brikabrok.previewModel:SetModelScale(Brikabrok.previewModel:GetModelScale() - .1)
	   end);

end



function Brikabrok.previewGob(self,event,msg,...)
		if strfind(msg,"Name: ") then
			--print("founded")
			local lastCharacter = string.sub(msg, -5)
			local gobName = strsub(msg,7,tonumber(lastCharacter))
			local gobFixName = gobName:gsub('%s+', '')
			--print(gobFixName)
			--print(BrikabrokGobList[199748])
			if strfind(gobFixName,".m2") then
				for k, v in pairs(BrikabrokGobList) do
					local stringClear = v:lower()
					local absolutePath = stringClear:gsub('%\\', '')
					if Brikabrok.safeMatch(absolutePath,gobFixName) then
						if Brikabrok.previewModel == nil then
							Brikabrok.ShowPreview(v)
						elseif Brikabrok.previewModel ~= nil then
							if Brikabrok.previewWindow:IsVisible() then
								Brikabrok.previewModel:SetModel(v)
							else
								Brikabrok.previewWindow:Show()
								Brikabrok.previewModel:SetModel(v)
							end
						end
					end
				end
			elseif strfind(gobFixName,".wmo") then
				Brikabrok.formatMessage("Blizzard n'autorise pas la visualisation des WMO, vous ne pouvez pas prévisualiser cet objet ! ","DANGER")
			else
				Brikabrok.formatMessage("Le nom du gob est localisé, il ne peut donc être utilisé ! (ex : Chair )","DANGER")
			end

		end
	return false, msg,...
end


for k, v in pairs({"EMOTE", "GUILD", "OFFICER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "SAY", "SYSTEM", "WHISPER", "WHISPER_INFORM", "YELL"}) do
	ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, Brikabrok.getLinks)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, Brikabrok.wrapperLinks)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, Brikabrok.previewGob)
end

local oldHyperlink = ItemRefTooltip.SetHyperlink -- Save the function here to be able to call it later
function ItemRefTooltip:SetHyperlink(data, ...)
	local linkType, chatReplace = strsplit(":", data)
	if linkType == "command" then
		SendChatMessage(chatReplace, "GUILD")
	elseif linkType == "creature" then
		SendChatMessage(".go creature "..chatReplace, "GUILD")
	elseif linkType == "creature_entry" then
		SendChatMessage(".np add "..chatReplace, "GUILD")
	elseif linkType == "gameobject_entry" then
		SendChatMessage(".gob add "..chatReplace, "GUILD")
	elseif linkType == "gameobject" then
		SendChatMessage(".go gob "..chatReplace, "GUILD")
	elseif linkType == "spell" then
		SendChatMessage(".learn "..chatReplace, "GUILD")
	else
		oldHyperlink(self, data, ...)
	end
end


end