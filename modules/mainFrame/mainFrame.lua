--[[

        _______      ______   ______ _____ _     _ _______ ______   ______  _____  _     _
 |      |______      |_____] |_____/   |   |____/  |_____| |_____] |_____/ |     | |____/ 
 |_____ |______      |_____] |    \_ __|__ |    \_ |     | |_____] |    \_ |_____| |    \_
                                                                                          

    MIT License

    Copyright (c) BinarySpace

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
BrikabrokUI = Brikabrok:NewModule("UI", "AceEvent-3.0")
local AceGUI = LibStub("AceGUI-3.0")
-----------------------------------
----------- Main Frame ------------
-----------------------------------


function BrikabrokUI:OnEnable()

--[[
**	 DrawGroup1
**	 Draws the first tab of the main frame aka Spells
**		container: Which container hold this
--]]
function Brikabrok:DrawGroup1(container)
	if Brikabrok.db ~= nil then
	  Brikabrok.BuildSpData(Brikabrok.db.profile.spells) 
	end
end
--[[
**	 DrawGroup2
**	 Draws the second tab of the main frame aka Gobs
**		container: Which container hold this
--]]
function Brikabrok:DrawGroup2(container)
	if Brikabrok.db ~= nil then
		Brikabrok.BuildGobsData(Brikabrok.db.profile.gobs)
	end
end


--[[
**	 DrawGroup3
**	 Draws the third tab of the main frame aka ForgeInfo
**		container: Which container hold this
--]]
function Brikabrok:DrawGroup3(container)

  local forgeinfoCommand = AceGUI:Create("Button")
  forgeinfoCommand:SetPoint("Top", 10, 10)
  forgeinfoCommand:SetPoint("Center")
  forgeinfoCommand:SetText("Forge Info")
  forgeinfoCommand:SetWidth(200)
  forgeinfoCommand:SetCallback("OnClick", function() SendChatMessage(".forge info", "GUILD") end)
  Brikabrok:addToScroll(forgeinfoCommand)
  
  Brikabrok:createHeading("Apparence")

  -- Very BAD code incoming, I didn't figure out how to do this yet properly in Lua :'(
  
  local peauBox = AceGUI:Create("EditBox")
  peauBox:SetText("Peau")
  peauBox:SetLabel("Peau")
  Brikabrok:addToScroll(peauBox)
  
  local visageBox = AceGUI:Create("EditBox")
  visageBox:SetText("Visage")
  visageBox:SetLabel("Visage")
  Brikabrok:addToScroll(visageBox)
  
  local cheveuxBox = AceGUI:Create("EditBox")
  cheveuxBox:SetText("Cheveux")
  cheveuxBox:SetLabel("Cheveux")
  Brikabrok:addToScroll(cheveuxBox)
  
  local couleurBox = AceGUI:Create("EditBox")
  couleurBox:SetText("Couleur")
  couleurBox:SetLabel("Couleur")
  Brikabrok:addToScroll(couleurBox)
  
  local detailsBox = AceGUI:Create("EditBox")
  detailsBox:SetText("Pilosité / Détails")
  detailsBox:SetLabel("Pilosité / Détails")
  Brikabrok:addToScroll(detailsBox)
  
  local tatouageBox = AceGUI:Create("EditBox")
  tatouageBox:SetText("Tatouages")
  tatouageBox:SetLabel("Tatouages")
  Brikabrok:addToScroll(tatouageBox)
  
  local cornesBox = AceGUI:Create("EditBox")
  cornesBox:SetText("Cornes")
  cornesBox:SetLabel("Cornes")
  Brikabrok:addToScroll(cornesBox)
  
  local bandeauBox = AceGUI:Create("EditBox")
  bandeauBox:SetText("Bandeau")
  bandeauBox:SetLabel("Bandeau")
  Brikabrok:addToScroll(bandeauBox)
  
  Brikabrok:createHeading("Tenue et armes")

  local editbox1 = AceGUI:Create("EditBox")
  editbox1:SetText("Casque")
  editbox1:SetLabel("Casque")
  Brikabrok:addToScroll(editbox1)
  
  local editbox2 = AceGUI:Create("EditBox")
  editbox2:SetText("Epaulières")
  editbox2:SetLabel("Epaulières")
  Brikabrok:addToScroll(editbox2)
  
  local editbox3 = AceGUI:Create("EditBox")
  editbox3:SetText("Chemise")
  editbox3:SetLabel("Chemise")
  Brikabrok:addToScroll(editbox3)
  
  local editbox4 = AceGUI:Create("EditBox")
  editbox4:SetText("Torse")
  editbox4:SetLabel("Torse")
  Brikabrok:addToScroll(editbox4)
  
  local editbox5 = AceGUI:Create("EditBox")
  editbox5:SetText("Ceinture")
  editbox5:SetLabel("Ceinture")
  Brikabrok:addToScroll(editbox5)
  
  local editbox6 = AceGUI:Create("EditBox")
  editbox6:SetText("Jambières")
  editbox6:SetLabel("Jambières")
  Brikabrok:addToScroll(editbox6)
  
  local editbox7 = AceGUI:Create("EditBox")
  editbox7:SetText("Bottes")
  editbox7:SetLabel("Bottes")
  Brikabrok:addToScroll(editbox7)
  
  local editbox8 = AceGUI:Create("EditBox")
  editbox8:SetText("Brassards")
  editbox8:SetLabel("Brassards")
  Brikabrok:addToScroll(editbox8)
  
  local editbox9 = AceGUI:Create("EditBox")
  editbox9:SetText("Gants")
  editbox9:SetLabel("Gants")
  Brikabrok:addToScroll(editbox9)
  
  local editbox10 = AceGUI:Create("EditBox")
  editbox10:SetText("Cape")
  editbox10:SetLabel("Cape")
  Brikabrok:addToScroll(editbox10)
  
  local editbox11 = AceGUI:Create("EditBox")
  editbox11:SetText("Tabard")
  editbox11:SetLabel("Tabard")
  Brikabrok:addToScroll(editbox11)
  
  local editbox12 = AceGUI:Create("EditBox")
  editbox12:SetText("Arme Droite")
  editbox12:SetLabel("Arme Droite")
  Brikabrok:addToScroll(editbox12)
  
  local editbox13 = AceGUI:Create("EditBox")
  editbox13:SetText("Arme Gauche")
  editbox13:SetLabel("Arme Gauche")
  Brikabrok:addToScroll(editbox13)

function findID (self,event,msg)
 if string.match (msg, "DisplayID du casque") then
  local info1 = string.sub(msg, 22,99)
  info1 = string.gsub(info1, "%s+", "")  -- Remove spaces
  editbox1:SetText(info1:gsub('%.', '')) -- Remove points thank's to regex
 elseif string.match (msg, "DisplayID des épaulières") then
  local info2 = string.sub(msg, 29,99)
  info2 = string.gsub(info2, "%s+", "") 
  editbox2:SetText(info2:gsub('%.', ''))
 elseif string.match (msg, "DisplayID de la chemise") then
  local info3 = string.sub(msg, 26,99)
  info3 = string.gsub(info3, "%s+", "") 
  editbox3:SetText(info3:gsub('%.', ''))
 elseif string.match (msg, "DisplayID du torse") then
  local info4 = string.sub(msg, 21,99)
  info4 = string.gsub(info4, "%s+", "") 
  editbox4:SetText(info4:gsub('%.', ''))
 elseif string.match (msg, "DisplayID de la ceinture") then
  local info5 = string.sub(msg, 27,99)
  info5 = string.gsub(info5, "%s+", "") 
  editbox5:SetText(info5:gsub('%.', ''))
 elseif string.match (msg, "DisplayID des jambières") then
  local info6 = string.sub(msg, 27,99)
  info6 = string.gsub(info6, "%s+", "") 
  editbox6:SetText(info6:gsub('%.', ''))
 elseif string.match (msg, "DisplayID des bottes") then
  local info7 = string.sub(msg, 23,99)
  info7 = string.gsub(info7, "%s+", "") 
  editbox7:SetText(info7:gsub('%.', ''))
 elseif string.match (msg, "DisplayID des brassards") then
  local info8 = string.sub(msg, 26,99)
  info8 = string.gsub(info8, "%s+", "") 
  editbox8:SetText(info8:gsub('%.', ''))
 elseif string.match (msg, "DisplayID des gants") then
  local info9 = string.sub(msg, 22,99)
  info9 = string.gsub(info9, "%s+", "") 
  editbox9:SetText(info9:gsub('%.', ''))
 elseif string.match (msg, "DisplayID de la cape") then
  local info10 = string.sub(msg, 23,99)
  info10 = string.gsub(info10, "%s+", "") 
  editbox10:SetText(info10:gsub('%.', ''))
 elseif string.match (msg, "DisplayID du tabard") then
  local info11 = string.sub(msg, 22,99)
  info11 = string.gsub(info11, "%s+", "") 
  editbox11:SetText(info11:gsub('%.', ''))
 elseif string.match (msg, "ID de l'arme droite") then
  local info12 = string.sub(msg, 23,99)
  info12 = string.gsub(info12, "%s+", "") 
  editbox12:SetText(info12:gsub('%.', ''))  
 elseif string.match (msg, "ID de l'arme gauche") then
  local info13 = string.sub(msg, 22,99)
  info13 = string.gsub(info13, "%s+", "") 
  editbox13:SetText(info13:gsub('%.', ''))
 elseif string.match (msg, "Peau :") then
  local peauinfo = string.sub(msg, 7,99)
  peauinfo = string.gsub(peauinfo, "%s+", "") 
  peauBox:SetText(peauinfo:gsub('%.', ''))
 elseif string.match (msg, "Visage :") then
   local visageinfo = string.sub(msg, 9,99)
   visageinfo = string.gsub(visageinfo, "%s+", "") 
   visageBox:SetText(visageinfo:gsub('%.', ''))
 elseif string.match (msg, "Cheveux :") then
   local cheveuxinfo = string.sub(msg, 10,99)
   cheveuxinfo = string.gsub(cheveuxinfo, "%s+", "")
   cheveuxBox:SetText(cheveuxinfo:gsub('%.', ''))
 elseif string.match (msg, "Couleur :") then
   local couleurinfo = string.sub(msg, 10,99)
   couleurinfo = string.gsub(couleurinfo, "%s+", "")
   couleurBox:SetText(couleurinfo:gsub('%.', ''))
 elseif string.match (msg, "Pilosite/Details :") then
   local detailsinfo = string.sub(msg, 19,99)
   detailsinfo = string.gsub(detailsinfo, "%s+", "")
   detailsBox:SetText(detailsinfo:gsub('%.', ''))
 elseif string.match (msg, "Tatouage :") then
   local tatouageinfo = string.sub(msg, 11,99)
   tatouageinfo = string.gsub(tatouageinfo, "%s+", "")
   tatouageBox:SetText(tatouageinfo:gsub('%.', ''))
 elseif string.match (msg, "Cornes :") then
   local cornesinfo = string.sub(msg, 9,99)
   cornesinfo = string.gsub(cornesinfo, "%s+", "")
   cornesBox:SetText(cornesinfo:gsub('%.', ''))
 elseif string.match (msg, "Bandeau :") then
   local bandeauinfo = string.sub(msg, 10,99)
   bandeauinfo = string.gsub(bandeauinfo, "%s+", "")
   bandeauBox:SetText(bandeauinfo:gsub('%.', ''))
  return false
 end
end

for k, v in pairs({"EMOTE", "GUILD", "OFFICER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "SAY", "SYSTEM", "WHISPER", "WHISPER_INFORM", "YELL"}) do
  ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, findID)
end

end



--[[
**	 DrawGroup4
**	 Draws the fourth tab of the main frame aka Divers
**		container: Which container hold this
--]]
function Brikabrok:DrawGroup4(container)

for i = 1, #BrikabrokSliders do
  local slName = BrikabrokSliders[i][1]
  local slMin = BrikabrokSliders[i][2]
  local slMax = BrikabrokSliders[i][3]
  local slMessage = BrikabrokSliders[i][4]
  
  
  local slList = AceGUI:Create("Slider")
  slList:SetLabel(slName)
  slList:SetValue(slMin)
  slList:SetSliderValues(slMin,slMax,slMin)
       callbacks = {
        OnValueChanged = function (value, container, event, group)  end ,
        OnMouseUp = function (self) SendChatMessage(BrikabrokSliders[i][4]..self.editbox:GetText(), "SAY") end ,
             }
  Brikabrok:addCallbacks(slList, callbacks)
  Brikabrok:addToScroll(slList)
  


end

for i = 1, #BrikabrokChecks do

  local cName = BrikabrokChecks[i][1]
  
  local cList = AceGUI:Create("CheckBox")
  cList:SetLabel(cName)
  sliderCallbacks = {
        OnValueChanged = function (value, container, event, group) SendChatMessage(BrikabrokChecks[i][cList:GetValue()], "GUILD")  end ,
  }
  Brikabrok:addCallbacks(cList, sliderCallbacks)
  Brikabrok:addToScroll(cList)
end
end

function Brikabrok:DrawGroup5(container)
	if Brikabrok.db ~= nil then
		Brikabrok.BuildAnimationsData(Brikabrok.db.profile.anim)
	end
end

function Brikabrok:DrawGroup6(container)
  Brikabrok.BuildMacrosData()
end


--[[
**	 SelectGroup
**	 Callback function for OnGroupSelected
**		container: Which container hold this
**		event: ...
**		group: ...
--]]
local function SelectGroup(container, event, group)
    container:ReleaseChildren()
    container:SetLayout("Flow")


    local scrollContainer = AceGUI:Create("SimpleGroup")
    scrollContainer:SetRelativeWidth(0.6)
    scrollContainer:SetFullHeight(true)
    scrollContainer:SetLayout("Fill")
    container:AddChild(scrollContainer)

    brikabrokScroll = AceGUI:Create("ScrollFrame")
    brikabrokScroll:SetFullHeight(true)
    brikabrokScroll:SetLayout("Flow")
    scrollContainer:AddChild(brikabrokScroll)
   
   if group == "tab1" then
      Brikabrok:DrawGroup1(container)
   elseif group == "tab2" then
      Brikabrok:DrawGroup2(container)
   elseif group == "tab3" then
      Brikabrok:DrawGroup3(container)
   elseif group == "tab4" then
      Brikabrok:DrawGroup4(container)
   elseif group == "tab5" then
      Brikabrok:DrawGroup5(container)
   elseif group == "tab6" then
      Brikabrok:DrawGroup6(container)
   elseif group == "tab7" then
      Brikabrok:DrawGroup7(container)
   end
end

-- Create main frame
mainFrame = AceGUI:Create("Brikabrok")
mainFrame:SetTitle("Le Brikabrok")
mainFrame:SetLayout("Fill")

-- Add tabs here
local tab =  AceGUI:Create("TabGroup")
tab:SetLayout("Flow")
tab:SetTabs({{text="Spells", value="tab1"},{text="Gobs", value="tab2"},{text="Forge", value="tab3"}, {text="Divers", value="tab4"}, {text="Animations", value="tab5"}, {text="Macros", value="tab6"}})
tab:SetCallback("OnGroupSelected", SelectGroup)
tab:SelectTab("tab1")
mainFrame:AddChild(tab)

end