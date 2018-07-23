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
BrikabrokSECONDARY = Brikabrok:NewModule("SECONDARY", "AceEvent-3.0","AceComm-3.0")
local AceGUI = LibStub("AceGUI-3.0")


function BrikabrokSECONDARY:OnEnable()

-----------------------------------
------------ 2nd Frame ------------
-----------------------------------

--[[
**   DrawGroupSecondary1
**   Draw the first tab for the secondary frame
**    container: Which container hold this
--]]
local function DrawGroupSecondary1(container)

  local headingVarious = AceGUI:Create("Heading")
  headingVarious:SetText("Utiles")
  headingVarious:SetFullWidth(true)
  brikabrokEasyScroll:AddChild(headingVarious)

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
    brikabrokEasyScroll:AddChild(slList)

  end


for i = 1, #BrikabrokChecks do

  local cName = BrikabrokChecks[i][1]
  
  local cList = AceGUI:Create("CheckBox")
  cList:SetLabel(cName)
  sliderCallbacks = {
        OnValueChanged = function (value, container, event, group) SendChatMessage(BrikabrokChecks[i][cList:GetValue()], "GUILD")  end ,
  }
  Brikabrok:addCallbacks(cList, sliderCallbacks)
  brikabrokEasyScroll:AddChild(cList)
end

  local headingScale = AceGUI:Create("Heading")
  headingScale:SetText("Taille RP")
  headingScale:SetFullWidth(true)
  brikabrokEasyScroll:AddChild(headingScale)

  sChooseRace = AceGUI:Create("Dropdown")
  sChooseRace:SetList(raceListDropdown)
  sChooseRace:SetText("Race")
  sChooseRace:SetLabel("Définissez votre race")
  brikabrokEasyScroll:AddChild(sChooseRace)
  sChooseRace:SetCallback("OnValueChanged", function(self,callback,key) keyOverrideDrop = key end)
  
  autoCheckRace = AceGUI:Create("CheckBox")
  autoCheckRace:SetLabel("Race actuelle")
  autoCheckRace:SetValue(true)
  brikabrokEasyScroll:AddChild(autoCheckRace)

  sScaleRP = AceGUI:Create("EditBox")
  sScaleRP:SetText("190")
  sScaleRP:SetPoint("CENTER")
  sScaleRP:SetLabel("Taille RP (cm)")
  brikabrokEasyScroll:AddChild(sScaleRP)
  ScaleCallbacks = {
    OnEnterPressed = function (self) 
      for i = 1, #raceRPscale do
        local raceID = raceRPscale[i][1]
        local raceScaleM = raceRPscale[i][2]
        local raceScaleF = raceRPscale[i][3]
			  local checkOverride = keyOverrideDrop
			
        local raceScale,raceScaleID = UnitRace("player")
        local genderCis = UnitSex("player")
        if raceID==raceScaleID and autoCheckRace:GetValue() then
          if genderCis == 2 then -- male cis white
				    local scaleWanted = sScaleRP:GetText()
				    local scaleDiff = scaleWanted/raceScaleM*100-100
				    Brikabrok.formatMessage("Taille de base de votre race : "..raceScaleM.."cm, Votre taille: "..scaleWanted.."cm, soit une différence de "..scaleDiff.."%","INFO")
            local scaleDivM = scaleWanted/raceScaleM
            SendChatMessage(".modify scale "..scaleDivM, "SAY")
          elseif genderCis == 3 then -- female
				    local scaleWanted = sScaleRP:GetText()
				    local scaleDiff = scaleWanted/raceScaleF*100-100
				    Brikabrok.formatMessage("Taille de base de votre race : "..raceScaleF.."cm, Votre taille: "..scaleWanted.."cm, soit une différence de "..scaleDiff.."%","INFO")
            local scaleDivF = scaleWanted/raceScaleF
            SendChatMessage(".modify scale "..scaleDivF, "SAY")
			    end
			elseif not autoCheckRace:GetValue() then
			  if checkOverride==raceID then
				if genderCis == 2 then -- male cis white
					local scaleWanted = sScaleRP:GetText()
					local scaleDiff = scaleWanted/raceScaleM*100-100
					Brikabrok.formatMessage("Taille de base de votre race : "..raceScaleM.."cm, Votre taille: "..scaleWanted.."cm, soit une différence de "..scaleDiff.."%","INFO")
					local scaleDivM = scaleWanted/raceScaleM
					SendChatMessage(".modify scale "..scaleDivM, "SAY")
				elseif genderCis == 3 then -- female
					local scaleWanted = sScaleRP:GetText()
					local scaleDiff = scaleWanted/raceScaleF*100-100
					Brikabrok.formatMessage("Taille de base de votre race : "..raceScaleF.."cm, Votre taille: "..scaleWanted.."cm, soit une différence de "..scaleDiff.."%","INFO")
					local scaleDivF = scaleWanted/raceScaleF
					SendChatMessage(".modify scale "..scaleDivF, "SAY")
				end
			  end
			end
			end
    end
  }
  Brikabrok:addCallbacks(sScaleRP, ScaleCallbacks)
  
end


--[[
**   DrawGroupSecondary2
**   Draw the 2nd tab for the secondary frame
**    container: Which container hold this
--]]
local function DrawGroupSecondary2(container)

    local qsGob = AceGUI:Create("EditBox")
    qsGob:SetText("GOB ID")
    qsGob:SetPoint("CENTER")
    qsGob:SetLabel("GOB ID")
    brikabrokEasyScroll:AddChild(qsGob)

    local qsButton = AceGUI:Create("Button")
    qsButton:SetText("ID")
    qsButton:SetWidth(200)
    qsButton:SetCallback("OnClick", function() 
      SendChatMessage(".gob tar", "GUILD") 
    end)
    brikabrokEasyScroll:AddChild(qsButton)

    local headingrotate = AceGUI:Create("Heading")
    headingrotate:SetText("Rotation des gobs")
    headingrotate:SetFullWidth(true)
    brikabrokEasyScroll:AddChild(headingrotate)

    local qsSliderx = AceGUI:Create("Slider")
    qsSliderx:SetLabel(qsName)
    qsSliderx:SetValue(0)
    qsSliderx:SetPoint("CENTER", UIParent, "CENTER")
    qsSliderx:SetSliderValues(0,360,0)
    brikabrokEasyScroll:AddChild(qsSliderx)

    local qsSlidery = AceGUI:Create("Slider")
    qsSlidery:SetLabel(qsName)
    qsSlidery:SetValue(0)
    qsSlidery:SetPoint("CENTER", UIParent, "CENTER")
    qsSlidery:SetSliderValues(0,360,0)
    brikabrokEasyScroll:AddChild(qsSlidery)

    local qsSliderz = AceGUI:Create("Slider")
    qsSliderz:SetLabel(qsName)
    qsSliderz:SetValue(0)
    qsSliderz:SetSliderValues(0,360,0)
    brikabrokEasyScroll:AddChild(qsSliderz)

    local callbacks = {
    OnValueChanged = function (value, container, event, group)  end ,
    OnMouseUp = function (self) SendChatMessage(".gob rotate "..qsGob:GetText().." "..qsSliderx.editbox:GetText().." "..qsSlidery.editbox:GetText().." "..qsSliderz.editbox:GetText(), "SAY") end ,
    }
    Brikabrok:addCallbacks(qsSliderx, callbacks)

    local callbacks2 = {
    OnValueChanged = function (value, container, event, group)  end ,
    OnMouseUp = function (self) SendChatMessage(".gob rotate "..qsGob:GetText().." "..qsSliderx.editbox:GetText().." "..qsSlidery.editbox:GetText().." "..qsSliderz.editbox:GetText(), "SAY") end ,
    }
    Brikabrok:addCallbacks(qsSlidery, callbacks2)

    local callbacks3 = {
    OnValueChanged = function (value, container, event, group)  end ,
    OnMouseUp = function (self) SendChatMessage(".gob rotate "..qsGob:GetText().." "..qsSliderx.editbox:GetText().." "..qsSlidery.editbox:GetText().." "..qsSliderz.editbox:GetText(), "SAY") end ,
    }
    Brikabrok:addCallbacks(qsSliderz, callbacks3)

    local headingdivers = AceGUI:Create("Heading")
    headingdivers:SetText("Divers")
    headingdivers:SetFullWidth(true)
    brikabrokEasyScroll:AddChild(headingdivers)

    local qsSliderSize = AceGUI:Create("Slider")
    qsSliderSize:SetLabel("Taille")
    qsSliderSize:SetValue(0)
    qsSliderSize:SetPoint("CENTER", UIParent, "CENTER")
    qsSliderSize:SetSliderValues(0.1,50,0.1)
    brikabrokEasyScroll:AddChild(qsSliderSize)
	
	   local qsActivate = AceGUI:Create("Button")
    qsActivate:SetText("Activer")
    qsActivate:SetWidth(200)
    qsActivate:SetCallback("OnClick", function() SendChatMessage(".gob act "..qsGob:GetText(), "GUILD") end)
    brikabrokEasyScroll:AddChild(qsActivate)

    local callbacksSize = {
    OnValueChanged = function (value, container, event, group)  end ,
    OnMouseUp = function (self) SendChatMessage(".gob s scale "..qsGob:GetText().." "..qsSliderSize.editbox:GetText(), "SAY") end ,
    }
    Brikabrok:addCallbacks(qsSliderSize, callbacksSize)


    local headingbuttons = AceGUI:Create("Heading")
    headingbuttons:SetText("Déplacement des gobs")
    headingbuttons:SetFullWidth(true)
    brikabrokEasyScroll:AddChild(headingbuttons)

    local moveGobX = AceGUI:Create("Slider")
    moveGobX:SetLabel("X")
    moveGobX:SetValue(0)
    moveGobX:SetPoint("CENTER", UIParent, "CENTER")
    moveGobX:SetSliderValues(-100,100,0)
    brikabrokEasyScroll:AddChild(moveGobX)

    local moveGobY = AceGUI:Create("Slider")
    moveGobY:SetLabel("Y")
    moveGobY:SetValue(0)
    moveGobY:SetPoint("CENTER", UIParent, "CENTER")
    moveGobY:SetSliderValues(-100,100,0)
    brikabrokEasyScroll:AddChild(moveGobY)

    local moveGobZ = AceGUI:Create("Slider")
    moveGobZ:SetLabel("Z")
    moveGobZ:SetValue(0)
    moveGobZ:SetSliderValues(-100,100,0)
    brikabrokEasyScroll:AddChild(moveGobZ)

    local callbacks = {
    OnValueChanged = function (value, container, event, group)  end ,
    OnMouseUp = function (self) 
    SendChatMessage(".gob move "..qsGob:GetText().." "..Brikabrok.gobCoordX+moveGobX.editbox:GetText().." "..Brikabrok.gobCoordY+moveGobY.editbox:GetText().." "..Brikabrok.gobCoordZ+moveGobZ.editbox:GetText(), "GUILD") 
    C_Timer.After(1.5, function () SendChatMessage(".go object "..qsGob:GetText(),"GUILD") end) end ,
    }
    Brikabrok:addCallbacks(moveGobX, callbacks)

    local callbacks2 = {
    OnValueChanged = function (value, container, event, group)  end ,
    OnMouseUp = function (self) SendChatMessage(".gob move "..qsGob:GetText().." "..Brikabrok.gobCoordX+moveGobX.editbox:GetText().." "..Brikabrok.gobCoordY+moveGobY.editbox:GetText().." "..Brikabrok.gobCoordZ+moveGobZ.editbox:GetText(), "GUILD") 
    C_Timer.After(1.5, function () SendChatMessage(".go object "..qsGob:GetText(),"GUILD") end) end ,
    }
    Brikabrok:addCallbacks(moveGobY, callbacks2)

    local callbacks3 = {
    OnValueChanged = function (value, container, event, group)  end ,
    OnMouseUp = function (self) SendChatMessage(".gob move "..qsGob:GetText().." "..Brikabrok.gobCoordX+moveGobX.editbox:GetText().." "..Brikabrok.gobCoordY+moveGobY.editbox:GetText().." "..Brikabrok.gobCoordZ+moveGobZ.editbox:GetText(), "GUILD") 
    C_Timer.After(1.5, function () SendChatMessage(".go object "..qsGob:GetText(),"GUILD") end) end ,
    }
    Brikabrok:addCallbacks(moveGobZ, callbacks3)

    local dataButton = AceGUI:Create("Button")
    dataButton:SetText("Données")
    dataButton:SetWidth(200)
    dataButton:SetCallback("OnClick", function() 
      SendChatMessage(".gob tar", "GUILD") 
    end)
    brikabrokEasyScroll:AddChild(dataButton)

  -- no documentation needed, get the nearest gob ID
  local function findGuid (self,event,msg)
   if string.match (msg, "GUID:") then
    local startPlace,endPlace = string.find(msg, "GUID:")
    local idGob = string.sub(msg, startPlace+6,endPlace+8)
    qsGob:SetText(idGob)
    return false
   end
  end

  function Brikabrok.GetCoords(self,event,msg,...)
  if strfind(msg,"MapId: ") then
    local gpsCoords = msg:gsub('%s+', '')
    gpsCoords = gpsCoords:gsub('X:', '')
    gpsCoords = gpsCoords:gsub('Y', '')
    gpsCoords = gpsCoords:gsub('Z', '')
    gpsCoords = gpsCoords:gsub('MapId', '')
    Brikabrok.gobCoordX,Brikabrok.gobCoordY,Brikabrok.gobCoordZ,Brikabrok.gobMapID = strsplit(":",gpsCoords)
  end
  return false,msg,...
end

  for k, v in pairs({"EMOTE", "GUILD", "OFFICER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "SAY", "SYSTEM", "WHISPER", "WHISPER_INFORM", "YELL"}) do
    ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, findGuid)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, Brikabrok.GetCoords)
  end
end


--[[
**   DrawGroupSecondary3
**   Draw the 3rd tab for the secondary frame
**    container: Which container hold this
--]]
local function DrawGroupSecondary3(container)


end

--[[
**   SelectGroupSecondary
**   Callback function for OnGroupSelected
**    container: Which container hold this
**    event: ...
**    group: ...
--]]
local function SelectGroupSecondary(container, event, group)
    container:ReleaseChildren()
    container:SetLayout("Flow")


    local scrollEasyContainer = AceGUI:Create("SimpleGroup")
    scrollEasyContainer:SetRelativeWidth(1)
    scrollEasyContainer:SetFullHeight(true)
    scrollEasyContainer:SetLayout("Fill")
    container:AddChild(scrollEasyContainer)

    brikabrokEasyScroll = AceGUI:Create("ScrollFrame")
    brikabrokEasyScroll:SetFullHeight(true)
    brikabrokEasyScroll:SetLayout("Flow")
    scrollEasyContainer:AddChild(brikabrokEasyScroll)

   
   if group == "tab1" then
      DrawGroupSecondary1(container)
   elseif group == "tab2" then
      DrawGroupSecondary2(container)
   end
end

-- Create secondary frame 
local easyFrame = AceGUI:Create("Brikabrok")
easyFrame:SetTitle("Brikabrok")
easyFrame:SetLayout("Fill")
easyFrame:SetWidth(400)
easyFrame:SetHeight(520)


-- Add tabs here for the second frame
local tabEasy =  AceGUI:Create("TabGroup")
tabEasy:SetLayout("Flow")
tabEasy:SetTabs({{text="Divers", value="tab1"},{text="Gob", value="tab2"}})
tabEasy:SetCallback("OnGroupSelected", SelectGroupSecondary)
tabEasy:SelectTab("tab1")
easyFrame:AddChild(tabEasy)

function Brikabrok:OpenEasyFrame()
  if Brikabrok.db.profile.everything.autoclose then
    if Brikabrok:IsVisibleMainFrame() or Brikabrok:IsVisibleDevFrame() then
      Brikabrok:CloseMainFrame()
      Brikabrok:CloseDevFrame()
      easyFrame:Show()
    else
      easyFrame:Show()
    end
  else
    easyFrame:Show()
  end
end

function Brikabrok:CloseEasyFrame()
  easyFrame:Hide()
end

function Brikabrok:IsVisibleEasyFrame()
  if easyFrame:IsVisible() then
    return true
  else
    return false
  end
end


end