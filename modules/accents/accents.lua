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
Brikabrok.ACCENTS = Brikabrok:NewModule("ACCENTS", "AceEvent-3.0","AceComm-3.0","AceHook-3.0","AceConsole-3.0")
local AceGUI = LibStub("AceGUI-3.0")

local EMOTE_PATTERNS = {
	{"* Emote *", "%*.-%*"},
	{"** Emote **", "%*%*.-%*%*"},
	{"< Emote >", "%<.-%>"},
	{"* Emote * + < Emote >", "[%*%<].-[%*%>]"},
}

function Brikabrok:ChangeAccent(accentName)
	if BrikabrokDwarfAccent == false then
		BrikabrokDwarfAccent = true
		Brikabrok.sendMessage("L'accent nain a été activé, vous pouvez le déactiver en faisant /anain","INFO")
	else
		BrikabrokDwarfAccent = false
		Brikabrok.sendMessage("L'accent nain a été déactivé, vous pouvez l'activer en faisant /anain","INFO")
end
end
--/run mememe = "issou *parler*"  if string.find(mememe, "%*.-%*") then print ("emote found") end

function Brikabrok:ChatEdit_ParseText(chatEntry, send)
     if (send == 1) then
        local text = chatEntry:GetText();
        local newText = text;             
        chatEntry:SetText( newText );
		
		local BposDot, EposDot = string.find(text, '%.')
		local BposDash,EposDash = string.find(text, '%/')
		numberPatterns = 0
		if (BposDot~=1 or EposDot~=1) and (BposDash~=1 or EposDash~=1) and BrikabrokDwarfAccent then
			for i=1,#EMOTE_PATTERNS do
				if string.find(text, EMOTE_PATTERNS[i][2]) then
					numberPatterns = 1
					--print("Pattern matching for: ".." "..EMOTE_PATTERNS[i][1].." "..EMOTE_PATTERNS[i][2])
					numberPatterns = 1
					local beginSplitEmote,endSplitEmote = string.find(text, EMOTE_PATTERNS[i][2])
					local emote = string.sub(text, beginSplitEmote,endSplitEmote)
					local message = string.sub(text, 1,beginSplitEmote-1)
					local messageNext = string.sub(text, endSplitEmote+1,string.len(text))
					local splitedMessage = string.gsub( message, "r", "'l");
					local splitedMessageNext = string.gsub( messageNext, "r", "'l");
					if messageNext == nil then
						text = splitedMessage.." "..emote
					else 
						text = splitedMessage.." "..emote.." "..splitedMessageNext
					end
				elseif not string.find(text, EMOTE_PATTERNS[i][2]) and numberPatterns < 1 then
					--print (numberPatterns)
					--print ("NO PATTERN MATCHTING")
					text = string.gsub( text, "r", "'l");
					text = string.gsub( text, "R", "'L");
				end
			end
			--print("CHECK PASS, commands safe")
			--print(text)
		else
			--print("CHECK NOT PASS, commands NOT safe")
			--print(text)
		end
		
		chatEntry:SetText( text );
     end
 end
