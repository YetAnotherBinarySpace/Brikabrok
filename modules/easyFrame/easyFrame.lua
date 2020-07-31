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

Brikabrok.plyCoordX, Brikabrok.plyCoordY, Brikabrok.plyCoordZ = 0,0,0


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

    Brikabrok.guidEditBox = qsGob

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
	
    local qsDoodads = AceGUI:Create("CheckBox")
    qsDoodads:SetLabel("Doodads")
    brikabrokEasyScroll:AddChild(qsDoodads)
	local boolToAct = {
		["true"] = "on",
		["false"] = "off",	
	}
	local qsDoodadsCallbacks = {
        OnValueChanged = function (value, container, event, group) SendChatMessage(string.format(".gob doodad %s %s", qsGob:GetText(), boolToAct[tostring(qsDoodads:GetValue())]), "GUILD")  end ,
    }
	Brikabrok:addCallbacks(qsDoodads, qsDoodadsCallbacks)

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

  --[[
  -- no documentation needed, get the nearest gob ID
  local function findGuid (self,event,msg)
   if string.match (msg, "GUID:") then
    local startPlace,endPlace = string.find(msg, "GUID:")
    local idGob = string.sub(msg, startPlace+6,endPlace+8)
    qsGob:SetText(idGob)
    return false
   end
  end
  --]]

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
    --ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, findGuid)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, Brikabrok.GetCoords)
  end
end


--[[
**   DrawGroupSecondary3
**   Draw the 3rd tab for the secondary frame
**    container: Which container hold this
--]]
local function DrawGroupSecondary3(container)

    local move = {forward = "Devant", backward = "Derrière",left = "Gauche",right = "Droite",down = "Bas",top = "Haut"}

    local rotate = {north = "Nord",south = "Sud ", east = "Est" , west = "Ouest", right = "Droite", left="Gauche"}

    local headingMove = AceGUI:Create("Heading")
    headingMove:SetText("Move")
    headingMove:SetFullWidth(true)
    brikabrokEasyScroll:AddChild(headingMove)

    local xCurrentPos = AceGUI:Create("Label")
    if Brikabrok.plyCoordX ~= nil then
      xCurrentPos:SetText("X: "..Brikabrok.plyCoordX)
    else
      xCurrentPos:SetText("X: Inconnu")
    end
    brikabrokEasyScroll:AddChild(xCurrentPos)

    local yCurrentPos = AceGUI:Create("Label")
    if Brikabrok.plyCoordY ~= nil then
      yCurrentPos:SetText("Y: "..Brikabrok.plyCoordY)
    else
      yCurrentPos:SetText("Y: Inconnu")
    end
    brikabrokEasyScroll:AddChild(yCurrentPos)

    local zCurrentPos = AceGUI:Create("Label")
    if Brikabrok.plyCoordX ~= nil then
      zCurrentPos:SetText("Z: "..Brikabrok.plyCoordZ)
    else
      zCurrentPos:SetText("Z: Inconnu")
    end
    brikabrokEasyScroll:AddChild(zCurrentPos)

    local oCurrentPos = AceGUI:Create("Label")
    if Brikabrok.plyOrientation ~= nil then
      oCurrentPos:SetText("Orientation: "..Brikabrok.plyOrientation)
    else
      oCurrentPos:SetText("Orientation: Inconnue")
    end
    brikabrokEasyScroll:AddChild(oCurrentPos)

    local moveAxeX = AceGUI:Create("EditBox")
    moveAxeX:SetText("0")
    moveAxeX:SetLabel("Se déplacer")
    moveAxeX:SetWidth(160)
    moveAxeX:SetCallback("OnTextChanged", function() 
    end)
    brikabrokEasyScroll:AddChild(moveAxeX)

    local ChooseMoveAxeX = AceGUI:Create("Dropdown")
    ChooseMoveAxeX:SetList(move)
    ChooseMoveAxeX:SetLabel("Définissez la direction")
    ChooseMoveAxeX:SetWidth(160)
    brikabrokEasyScroll:AddChild(ChooseMoveAxeX)
    ChooseMoveAxeX:SetCallback("OnValueChanged", function(self,callback,key) Brikabrok.directionX = key  end)


    local moveAxeY = AceGUI:Create("EditBox")
    moveAxeY:SetText("0")
    moveAxeY:SetLabel("Se déplacer")
    moveAxeY:SetWidth(160)
    moveAxeY:SetCallback("OnTextChanged", function() 
    end)
    brikabrokEasyScroll:AddChild(moveAxeY)

    local ChooseMoveAxeY = AceGUI:Create("Dropdown")
    ChooseMoveAxeY:SetList(move)
    ChooseMoveAxeY:SetLabel("Définissez la direction")
    ChooseMoveAxeY:SetWidth(160)
    brikabrokEasyScroll:AddChild(ChooseMoveAxeY)
    ChooseMoveAxeY:SetCallback("OnValueChanged", function(self,callback,key) Brikabrok.directionY = key end)

    local moveAxeZ = AceGUI:Create("EditBox")
    moveAxeZ:SetText("0")
    moveAxeZ:SetLabel("Se déplacer")
    moveAxeZ:SetWidth(160)
    moveAxeZ:SetCallback("OnTextChanged", function() 
    end)
    brikabrokEasyScroll:AddChild(moveAxeZ)

    local ChooseMoveAxeZ = AceGUI:Create("Dropdown")
    ChooseMoveAxeZ:SetList(move)
    ChooseMoveAxeZ:SetLabel("Définissez la direction")
    ChooseMoveAxeZ:SetWidth(160)
    brikabrokEasyScroll:AddChild(ChooseMoveAxeZ)
    ChooseMoveAxeZ:SetCallback("OnValueChanged", function(self,callback,key) Brikabrok.directionZ = key  end)

    local moveAxeO = AceGUI:Create("EditBox")
    moveAxeO:SetText("0")
    moveAxeO:SetLabel("Orientation ( Degré(s) )")
    moveAxeO:SetWidth(160)
    moveAxeO:SetCallback("OnTextChanged", function() 
    end)
    brikabrokEasyScroll:AddChild(moveAxeO)

    local ChooseMoveAxeO = AceGUI:Create("Dropdown")
    ChooseMoveAxeO:SetList(rotate)
    ChooseMoveAxeO:SetLabel("Pivoter à")
    ChooseMoveAxeO:SetWidth(160)
    brikabrokEasyScroll:AddChild(ChooseMoveAxeO)
    ChooseMoveAxeO:SetCallback("OnValueChanged", function(self,callback,key) Brikabrok.directionO = key  end)

    local dataButton = AceGUI:Create("Button")
    dataButton:SetText("Données")
    dataButton:SetWidth(200)
    dataButton:SetCallback("OnClick", function() 
      SendChatMessage(".gps", "GUILD")
    end)
    brikabrokEasyScroll:AddChild(dataButton)

  function Brikabrok.convertTeleport()

      local modX,modY,modZ,modO = moveAxeX:GetText(),moveAxeY:GetText(),moveAxeZ:GetText(),moveAxeO:GetText()
      local x,y,z,o,mapID = Brikabrok.plyCoordX,Brikabrok.plyCoordY,Brikabrok.plyCoordZ,Brikabrok.plyOrientation,Brikabrok.currentMap
      local oldX,oldY,oldZ,oldO = x,y,z,o

      -- X part
      if (Brikabrok.directionX == "forward") then
        x = Brikabrok.plyCoordX + modX
      elseif (Brikabrok.directionX == "backward") then
        x = Brikabrok.plyCoordX - modX
      elseif (Brikabrok.directionX == "left") then
        y = Brikabrok.plyCoordY + modX
      elseif (Brikabrok.directionX == "right") then
        y = Brikabrok.plyCoordY - modX
      elseif (Brikabrok.directionX == "top") then
        z = Brikabrok.plyCoordZ + modX
      elseif (Brikabrok.directionX == "down") then
        z = Brikabrok.plyCoordZ - modX
      end
      -- Y part
      if (Brikabrok.directionY == "forward") then
        x = Brikabrok.plyCoordX + modY
      elseif (Brikabrok.directionY == "backward") then
        x = Brikabrok.plyCoordX - modY
      elseif (Brikabrok.directionY == "left") then
        y = Brikabrok.plyCoordY + modY
      elseif (Brikabrok.directionY == "right") then
        y = Brikabrok.plyCoordY - modY
      elseif (Brikabrok.directionY == "top") then
        z = Brikabrok.plyCoordZ + modY
      elseif (Brikabrok.directionY == "down") then
        z = Brikabrok.plyCoordZ - modY
      end
      -- Z part
      if (Brikabrok.directionZ == "forward") then
        x = Brikabrok.plyCoordX + modZ
      elseif (Brikabrok.directionZ == "backward") then
        x = Brikabrok.plyCoordX - modZ
      elseif (Brikabrok.directionZ == "left") then
        y = Brikabrok.plyCoordY + modZ
      elseif (Brikabrok.directionZ == "right") then
        y = Brikabrok.plyCoordY - modZ
      elseif (Brikabrok.directionZ == "top") then
        z = Brikabrok.plyCoordZ + modZ
      elseif (Brikabrok.directionZ == "down") then
        z = Brikabrok.plyCoordZ - modZ
      end
      -- Orientation part
      if (Brikabrok.directionO == "north") then
        o = 0
        moveAxeO:SetText(math.deg(o))
      elseif (Brikabrok.directionO == "south") then
        o = math.pi
        moveAxeO:SetText(math.deg(o))
      elseif (Brikabrok.directionO == "west") then
        o = math.pi/2
        moveAxeO:SetText(math.deg(o))
      elseif (Brikabrok.directionO == "east") then
        o = 3*math.pi/2
        moveAxeO:SetText(math.deg(o))
      elseif (Brikabrok.directionO == "right") then
        o =  Brikabrok.plyOrientation + (-math.rad(modO))
      elseif (Brikabrok.directionO == "left") then
        o =  Brikabrok.plyOrientation + math.rad(modO)
      end

    return x,y,z,o,Brikabrok.currentMap,oldX,oldY,oldZ,oldO
  end

    local move = AceGUI:Create("Button")
    move:SetText("Se déplacer")
    move:SetWidth(200)
    move:SetCallback("OnClick", function() 
      local x,y,z,o,map = Brikabrok.convertTeleport()
      x,y,z,o,map = tostring(x),tostring(y),tostring(z),tostring(o),tostring(map)
      x,y,z,o = x:sub(1,8), y:sub(1,8), z:sub(1,8), o:sub(1,8)
      SendChatMessage(".go xyz "..x.." "..y.. " "..z.." "..map.." "..o, "SAY")
      C_Timer.After(0.4, function () SendChatMessage(".gps", "GUILD")
        if (Brikabrok.plyCoordX or Brikabrok.plyCoordY or Brikabrok.plyCoordZ) == (x or y or z) then
          SendChatMessage(".gps", "GUILD")
        end
      end)
    end)
    brikabrokEasyScroll:AddChild(move)

    local moveBack = AceGUI:Create("Button")
    moveBack:SetText("Revenir en arrière")
    moveBack:SetWidth(200)
    moveBack:SetCallback("OnClick", function() 
      SendChatMessage(".recall", "SAY")
    end)
    brikabrokEasyScroll:AddChild(moveBack)


  function Brikabrok.GetCoordsPlayer(self,event,msg,...)
      if strfind(msg,"Orientation:") and strfind(msg,"X:") then
        local playerCoords = msg:gsub('%s+', '')
        playerCoords = playerCoords:gsub('X:', '')
        playerCoords = playerCoords:gsub('Y', '')
        playerCoords = playerCoords:gsub('Z', '')
        playerCoords = playerCoords:gsub('Orientation', '')
        Brikabrok.plyCoordX,Brikabrok.plyCoordY,Brikabrok.plyCoordZ,Brikabrok.plyOrientation = strsplit(":",playerCoords)
		  if Brikabrok:IsVisibleEasyFrame() then
			  local degrees = tostring(math.deg(Brikabrok.plyOrientation))
			  local shortDegrees = degrees:sub(1,5)
			  xCurrentPos:SetText("X: "..Brikabrok.plyCoordX)
			  yCurrentPos:SetText("Y: "..Brikabrok.plyCoordY) 
			  zCurrentPos:SetText("Z: "..Brikabrok.plyCoordZ)
			  oCurrentPos:SetText("Orientation: "..Brikabrok.plyOrientation.." radian(s) soit "..shortDegrees.." degré(s)")
		  end
      elseif strfind(msg,"Map:") then
        for map in string.gmatch(msg, "Map: (%d+) %(%)") do
            Brikabrok.currentMap = map
        end
      end
    return false,msg,...
  end

  for k, v in pairs({"EMOTE", "GUILD", "OFFICER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "SAY", "SYSTEM", "WHISPER", "WHISPER_INFORM", "YELL"}) do
    --ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, findGuid)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, Brikabrok.GetCoordsPlayer)
  end


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
   elseif group == "tab3" then
      DrawGroupSecondary3(container)
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
tabEasy:SetTabs({{text="Divers", value="tab1"},{text="Gob", value="tab2"},{text="Move", value="tab3"}})
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