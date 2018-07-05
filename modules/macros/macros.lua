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
BrikabrokMACRO = Brikabrok:NewModule("MACRO", "AceEvent-3.0","AceComm-3.0","AceBucket-3.0")
local AceComm = LibStub("AceComm-3.0")
local AceDB = LibStub("AceDB-3.0")

function Brikabrok:OnEnable()
	self:RegisterComm("BKBSend")
	self:RegisterComm("BKBAccepted")
	self:RegisterComm("BKBRefused")
	self:RegisterComm("BKBReceive")
	self:RegisterComm("BKBHead")
	self:RegisterComm("BKBShareSpells")
	self:RegisterComm("BKBShareGobs")
	self:RegisterComm("BKBShareAnims")
end

function Brikabrok:OnCommReceived(prefix, message, distribution, sender)
	if Brikabrok.db.profile.transfer.data then
    if prefix == "BKBSend" then
		AceComm:SendCommMessage("BKBReceive", "", "PARTY", nil, "NORMAL")
    	local text,icon,body,player = strsplit("~", message)
        if UnitInParty(player) then
    		StaticPopupDialogs["BrikabrokMacroReceive"] = {
    		  text = player.." essaye de vous envoyer la macro suivante: "..text..", voulez-vous accepter ?",
    		  button1 = "Oui",
    		  button2 = "Non",
    		  OnAccept = function()
    		          CreateMacro(text, icon, body)
                	  AceComm:SendCommMessage("BKBAccepted","", "PARTY", nil, "NORMAL")
    		  end,
    		  OnCancel = function ()
    		    	AceComm:SendCommMessage("BKBRefused", "", "PARTY", nil, "NORMAL")
    		  end,
    		  timeout = 0,
    		  whileDead = true,
    		  showAlert = true,
    		}
        else
            Brikabrok.sendMessage("[Brikabrok] La personne qui a essayé de vous envoyer une macro n'est pas dans votre groupe.", "DANGER")
        end
        StaticPopup_Show("BrikabrokMacroReceive")
	elseif prefix == "BKBAccepted" then
		Brikabrok.sendMessage("[Brikabrok] La personne à la quelle vous avez essayé d'envoyer les données a acceptée.","SUCCESS")
	elseif prefix == "BKBRefused" then
		Brikabrok.sendMessage("[Brikabrok] La personne à la quelle vous avez essayé d'envoyer les données a refusée.", "WARNING")
	elseif prefix == "BKBReceive" then
		Brikabrok.sendMessage("[Brikabrok] Données reçues ...", "WARNING")
	elseif prefix == "BKBHead" then
		Brikabrok.dataPlayer,Brikabrok.dataType = strsplit("~", message)
		if not Brikabrok.dataPlayer == sender then
			Brikabrok.sendMessage("[Brikabrok] La personne qui vous envoie les données essaye de modifier son identité !", "WARNING")
		end
	elseif prefix == "BKBShareSpells" then
		AceComm:SendCommMessage("BKBReceive", "", "PARTY", nil, "NORMAL")
		local deserializedString = Brikabrok:safeDeserialize(message)
		if UnitInParty(Brikabrok.dataPlayer) then
				  StaticPopupDialogs["BrikabrokDataReceive"] = {
				  text = Brikabrok.dataPlayer.." essaye de vous envoyer sa base de donnée de spell, voulez-vous accepter ?",
				  button1 = "Oui",
				  button2 = "Non",
				  OnAccept = function()
							  local randomName = Brikabrok.dataPlayer..random(1,999999)
							  Brikabrok.db:SetProfile(randomName)
							  Brikabrok.db.profile.spells = deserializedString
							  AceComm:SendCommMessage("BKBAccepted", "", "PARTY", nil, "NORMAL")
				  end,
				  OnCancel = function ()
						AceComm:SendCommMessage("BKBRefused", "", "PARTY", nil, "NORMAL")
				  end,
				  whileDead = true,
				  showAlert = true,
				  timeout = 0,
				}
		StaticPopup_Show("BrikabrokDataReceive")
		end
	elseif prefix == "BKBShareGobs" then
		AceComm:SendCommMessage("BKBReceive", "", "PARTY", nil, "NORMAL")
		local deserializedString = Brikabrok:safeDeserialize(message)
		if UnitInParty(Brikabrok.dataPlayer) then
				  StaticPopupDialogs["BrikabrokDataReceive"] = {
				  text = Brikabrok.dataPlayer.." essaye de vous envoyer sa base de donnée de gob, voulez-vous accepter ?",
				  button1 = "Oui",
				  button2 = "Non",
				  OnAccept = function()
							  local randomName = Brikabrok.dataPlayer..random(1,999999)
							  Brikabrok.db:SetProfile(randomName)
							  Brikabrok.db.profile.gobs = deserializedString
							  AceComm:SendCommMessage("BKBAccepted", "", "PARTY", nil, "NORMAL")
				  end,
				  OnCancel = function ()
						AceComm:SendCommMessage("BKBRefused", "", "PARTY", nil, "NORMAL")
				  end,
				  whileDead = true,
				  showAlert = true,
				  timeout = 0,
				}
		StaticPopup_Show("BrikabrokDataReceive")
		end
	elseif prefix == "BKBShareAnims" then
		AceComm:SendCommMessage("BKBReceive", "", "PARTY", nil, "NORMAL")
		local deserializedString = Brikabrok:safeDeserialize(message)
		if UnitInParty(Brikabrok.dataPlayer) then
				  StaticPopupDialogs["BrikabrokDataReceive"] = {
				  text = Brikabrok.dataPlayer.." essaye de vous envoyer sa base de donnée d'anim, voulez-vous accepter ?",
				  button1 = "Oui",
				  button2 = "Non",
				  OnAccept = function()
							  local randomName = Brikabrok.dataPlayer..random(1,999999)
							  Brikabrok.db:SetProfile(randomName)
							  Brikabrok.db.profile.anim = deserializedString
							  AceComm:SendCommMessage("BKBAccepted", "", "PARTY", nil, "NORMAL")
				  end,
				  OnCancel = function ()
						AceComm:SendCommMessage("BKBRefused", "", "PARTY", nil, "NORMAL")
				  end,
				  whileDead = true,
				  showAlert = true,
				  timeout = 0,
				}
		StaticPopup_Show("BrikabrokDataReceive")
		end
    end
end
end
