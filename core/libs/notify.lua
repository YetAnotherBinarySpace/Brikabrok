--[[

        _______      ______   ______ _____ _______ _______ ______   ______  _____  _______
 |      |______      |_____] |_____/   |   |       |_____| |_____] |_____/ |     | |      
 |_____ |______      |_____] |    \_ __|__ |_____  |     | |_____] |    \_ |_____| |_____ 
                                                                                          

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
function Brikabrok:OnInitialize()
  --self:RegisterEvent( "ADDON_LOADED" )
  --self:RegisterBucketEvent({"ADDON_LOADED"}, 1, "SendMessageChat")
  --self:RegisterEvent("CHAT_MSG_CHANNEL")
  for i=1,50 do
  print("meme loaded")
  end
end
--]]


--[[
function Brikabrok.NOTIFY:SendMessageChat()
	C_Timer.After(5, function () JoinChannelByName(Brikabrok.channelname) SendChatMessage(Brikabrok.version , "CHANNEL", nil, Brikabrok.channelname) end)
end


function Brikabrok.NOTIFY:CHAT_MSG_CHANNEL(event,message,author,language,channelname,target,afk,zoneid,channelnumber,channel)
    print("Message"..message.."Channel:"..channel)
    if channel == Brikabrok.channel then
       print("channel pass")
        local name,version = strsplit("~", message)
            print(version)
            if not antispam and tonumber(version) and tonumber(version) > tonumber(Brikabrok.versionmode) then
                print("version pass")
                StaticPopupDialogs["BrikabrokUpdate"] = {
                    text = "Veuillez mettre l'addon Brikabrok à jour.\nVersion: "..version,
                    button1 = "Ok",
                    OnAccept = function()
                        antispam = true
                        Brikabrok.sendMessage("Les mises à jour du Brikabrok permettent de rajouter du contenu régulièrement, v."..version, "INFO")
                    end,
                    timeout = 0,
                    whileDead = true
                }
                StaticPopup_Show("BrikabrokUpdate")
            end
        end
end
--]]