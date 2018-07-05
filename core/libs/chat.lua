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

--[[
**   Brikabrok.sendMessage
**   Send a message with a different color depending on the type
**     msg: Message you want to send
**     priority: Priority of the message you want to send
--]]

Brikabrok.colors = {}
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
