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
BrikabrokMINIMAP= Brikabrok:NewModule("MINIMAP", "AceEvent-3.0","AceComm-3.0")


-----------------------------------
------------- MINI-MAP ------------
-----------------------------------

-- No documentation needed

Brikabrok.Settings = {
  MinimapPos = 45
}

function Brikabrok.MinimapButton_Reposition()
  BrikabrokMinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(Brikabrok.Settings.MinimapPos)),(80*sin(Brikabrok.Settings.MinimapPos))-52)
end

function Brikabrok.MinimapButton_DraggingFrame_OnUpdate()

  local xpos,ypos = GetCursorPosition()
  local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

  xpos = xmin-xpos/UIParent:GetScale()+70
  ypos = ypos/UIParent:GetScale()-ymin-70

  Brikabrok.Settings.MinimapPos = math.deg(math.atan2(ypos,xpos))
  Brikabrok.MinimapButton_Reposition()
end

function Brikabrok.MinimapButton_OnEnter(self)
  if (self.dragging) then
    return
  end
  GameTooltip:SetOwner(self or UIParent, "ANCHOR_LEFT")
  Brikabrok.MinimapButton_Details(GameTooltip)
end


function Brikabrok.MinimapButton_Details(tt, ldb)
  tt:SetText("Le Brikabrok")
  tt:AddLine("Version : "..Brikabrok.versionmode.." Release",1,1,1)
  tt:AddLine("Clic gauche: Ouvrir le menu principal",1,1,1)
  tt:AddLine("Clic droit: Ouvrir le menu rapide",1,1,1)
  tt:AddLine("Molette: Ouvrir le menu d'ajout",1,1,1)
  tt:SetSize(270,90)
end

function Brikabrok.MinimapButton_OnClick()
  buttonMod = GetMouseButtonClicked()
  if buttonMod == "LeftButton" then
    mainFrame:Show()
  elseif buttonMod == "MiddleButton" then
    easyDev:Show()
  elseif buttonMod == "RightButton" then
    easyFrame:Show()
  end
end