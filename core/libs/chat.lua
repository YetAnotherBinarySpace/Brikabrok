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
local AceTimer = LibStub("AceTimer-3.0")

--[[
**   Brikabrok.sendMessage
**   Send a message with a different color depending on the type
**     msg: Message you want to send
**     priority: Priority of the message you want to send
--]]

Brikabrok.colors = {}
Brikabrok.colors["SIMPLE"] = "|cffffffff"
Brikabrok.colors["SUCCESS"] = "|cff5cb85c"
Brikabrok.colors["INFO"] = "|cff5bc0de"
Brikabrok.colors["WARNING"] = "|cfff0ad4e"
Brikabrok.colors["DANGER"] = "|cffd9534f"

function Brikabrok.sendMessage(msg, priority)
  if priority and Brikabrok.colors[string.upper(priority)] then
    DEFAULT_CHAT_FRAME:AddMessage(Brikabrok.colors[string.upper(priority)]..msg)
  else
    DEFAULT_CHAT_FRAME:AddMessage(Brikabrok.colors["INFO"]..msg)
  end
end

function Brikabrok.setColor(color)
  local color = color or "w"; -- default color if bad argument
  if color == "r" then return "|cffff0000" end -- red
  if color == "g" then return "|cff00ff00" end -- green
  if color == "b" then return "|cff0000ff" end -- blue
  if color == "y" then return "|cffffff00" end -- yellow
  if color == "p" then return "|cffff00ff" end -- purple
  if color == "c" then return "|cff00ffff" end -- cyan
  if color == "w" then return "|cffffffff" end -- white
  if color == "0" then return "|cff000000" end -- black
  if color == "o" then return "|cffffaa00" end -- orange
  -- Priority
  if color == "SIMPLE" then return "|cffffffff" end
  if color == "SUCCESS" then return "|cff5cb85c" end
  if color == "INFO" then return "|cff5bc0de" end
  if color == "WARNING" then return "|cfff0ad4e" end
  if color == "DANGER" then return "|cffd9534f" end
end


function Brikabrok:ShowHelp()
    local function commandFormat(command,desc)
        local color = Brikabrok.setColor
        Brikabrok.sendMessage(color("c").."[Brikabrok] "..color("g").." "..command.." "..color("w").." - "..desc,"SIMPLE")
    end
    commandFormat("","Listes des commandes utilitaires")
    commandFormat("/bkbdev","Ouvre le menu de création")
    commandFormat("/bkbconvert lien","Converti le lien d'un sort en id")
    commandFormat("/bkbpreview","Permet de prévisualiser les gobs")
    commandFormat("/in ","Permet de délayer une action du chat.")
	commandFormat("/bkbglances ","Permet de vous donner des coups d'oeils comme sur TRP2.")
	commandFormat("/bkbviewer ","Permet de chercher et de prévisualiser des gobs")
  commandFormat("/bkbsave ","Permet de sauvegarder et de replacer des groupes de gobs.")
end


function Brikabrok.formatMessage(message,priority)
    local color = Brikabrok.setColor
    Brikabrok.sendMessage(color("c").."[Brikabrok] "..color(priority).." "..message,priority)
end

function Brikabrok:ConvertID(input)
    if strfind(input,"|Hspell") then
        local linkType,id = strsplit(":",input)
        Brikabrok.formatMessage("L'ID du spell est "..id.." .","SUCCESS")
    else
        Brikabrok.formatMessage("Veuillez entrer un lien de spell valide en faisant shift+click sur un spell dans votre grimoire.","WARNING")
    end
end

function Brikabrok:CommandViewer(input)
    Brikabrok.ShowGobBrowserFrame();
end

-- Ripped code from /slashin Addon, all credits to @funkydude for this implementation
-- to:do // do own implementation here


local MacroEditBox_OnEvent = MacroEditBox:GetScript("OnEvent")

local function OnCallback(command)
  MacroEditBox_OnEvent(MacroEditBox, "EXECUTE_CHAT_LINE", command)
end

function Brikabrok:commandIN(input)
  local secs, command = input:match("^([^%s]+)%s+(.*)$")
  secs = tonumber(secs)
  if (not secs) or (not input) then
     Brikabrok.formatMessage("Utilisation de la commande /in invalide, devrait suivre le format /in < secondes > < commande >.","WARNING")
  else
    AceTimer:ScheduleTimer(OnCallback, secs, command)
  end
end
