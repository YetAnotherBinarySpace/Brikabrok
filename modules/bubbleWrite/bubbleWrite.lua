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
BrikabrokBubble = Brikabrok:NewModule("BUBBLE", "AceEvent-3.0","AceComm-3.0","AceHook-3.0")
local AceGUI = LibStub("AceGUI-3.0")


function BrikabrokBubble:OnEnable()
    --[[
    for i = 1, NUM_CHAT_WINDOWS do
        local chatOpened = _G["ChatFrame"..i.."EditBox"] -- Hook global chat frames
        if chatOpened then
            self:HookScript(chatOpened,"OnTextChanged", function(self)
                local input = chatOpened:GetText()
                if Brikabrok.db.profile.chat.bubble and input:len() > 0 and Brikabrok:correctInput(input,".") and Brikabrok:correctInput(input,"/") then
                        local channel = chatOpened:GetAttribute("chatType")
                        if channel == "GUILD" or channel == "PARTY" or channel == "RAID" or channel == "WHISPER" or channel == "RAID_LEADER" or channel == "PARTY_LEADER" then
                            --print("meme")
                        else
                            SendChatMessage(".cast 211565")
                        end
                else
                    SendChatMessage(".unaura 211565")
                end
            end)
        end
    end
    --]]
end