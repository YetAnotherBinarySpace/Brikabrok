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
local AceGUI = LibStub("AceGUI-3.0")
local AceComm = LibStub("AceComm-3.0")
-- Micro-Optimizations
local cachedIcon = "Interface\\Icons\\trade_engineering"
local cachedHighlight = "Interface\\QuestFrame\\UI-QuestTitleHighlight"
local SetImage = SetImage;
local SetImageSize = SetImageSize;
local SetFullWidth = SetFullWidth;
local SetFontObject = SetFontObject;
local SetText = SetText;
local SetHighlight = SetHighlight;
local SetPoint = SetPoint;
BrikabroklibUI = Brikabrok:NewModule("libUI", "AceEvent-3.0","AceComm-3.0")


function BrikabroklibUI:OnEnable()

-----------------------------------
---------  Widgets Stuff ----------
-----------------------------------

--[[
**   createHeading
**   Create a nice and clear categorie
**     text: Title of the categorie
--]]
function Brikabrok:createHeading(text)
    local heading = AceGUI:Create("Heading")
    heading:SetText(text)
    heading:SetFullWidth(true)
    Brikabrok:addToScroll(heading)
    return heading
end

--[[
**   addCallbacks
**   Add a/multiple callback(s) to a widget
**     widget: which widget
**     callbacks: Callbacks to add
**     TO:DO : Clear other useless arguments
--]]
function Brikabrok:addCallbacks(widget, callbacks)
    if callbacks ~= nil then
        for i,v in pairs(callbacks) do
            widget:SetCallback(i, v)
        end
    end
end

--[[
**   addToScroll
**   Add to main scroll a UI widget
**      widget: Widget to parent
--]]
function Brikabrok:addToScroll(widget)
    brikabrokScroll:AddChild(widget)
end

--[[
**   CreateMacro
**   Wrapper to let the user choose where they want to store the macro
**      name: Name of the macro
**      icon: Path of the icon
**      content: Content of the macro
--]]
function Brikabrok:CreateMacro(name,icon,content)
  local numglobal,numperchar = GetNumMacros()
  if Brikabrok.db.profile.macro.storage == "Account" then
    if numglobal < 120 then
      CreateMacro(name, icon, content)
      Brikabrok.formatMessage("Une macro vient d'être ajoutée, vous pouvez maintenant la mettre dans votre barre d'action .", "SUCCESS")
    else
      Brikabrok.formatMessage("Vous n'avez plus de place dans vos macros de personnage, veuillez supprimer des macros ou changer d'empalacement de sauvegarde dans les options.","DANGER")
    end
  elseif Brikabrok.db.profile.macro.storage == "Character" then
    if numperchar < 18 then
      CreateMacro(name, icon, content,1)
      Brikabrok.formatMessage("Une macro vient d'être ajoutée, vous pouvez maintenant la mettre dans votre barre d'action .", "SUCCESS")
    else
      Brikabrok.formatMessage("Vous n'avez plus de place dans vos macros de personnage, veuillez supprimer des macros ou changer d'empalacement de sauvegarde dans les options.","DANGER")
    end
  else
    Brikabrok.formatMessage("Le type de stockage défini est invalide, veuillez aller le redéfinir dans les options","DANGER")
  end
end

--[[
**   showTooltip
**   Help Tooltip that shows some informations
**     tt: Which tooltip
**     TO:DO : Clear other useless arguments
--]]
function Brikabrok:showTooltip(tt, ldb, frame)
  if frame=="spells" then
  	tt:SetText("Aide")
  	tt:AddLine("Clic gauche : Apprendre le sort",1,1,1)
  	tt:AddLine("Clic droit : Oublier le sort",1,1,1)
  	tt:SetSize(250,60)
  elseif frame=="gobs" then
  	tt:SetText("Aide")
  	tt:AddLine("Clic gauche : Faire spawn un GOB",1,1,1)
  	tt:AddLine("Clic droit : Prévisualiser le GOB",1,1,1)
  	tt:SetSize(250,60) 
  elseif frame=="animations" then
    tt:SetText("Aide")
    tt:AddLine("Clic gauche : Jouer une animation",1,1,1)
    tt:AddLine("Molette : Enlever l'animation",1,1,1)
    tt:AddLine("Clic droit : Créer une macro pour l'anim",1,1,1)
    tt:SetSize(275,80)
   elseif frame=="macros" then
    tt:SetText("Aide")
    tt:AddLine("Clic gauche : Envoyer une macro à votre cible",1,1,1)
    tt:AddLine("La cible doit être dans votre groupe (à 2 max)",1,1,1)
    tt:AddLine("L'addon n'est pas responsable de vos actions",1,1,1)
    tt:SetSize(305,80)   
  end
end

function Brikabrok:hideTooltip()
    GameTooltip:Hide()
end

--[[
**   createLabelSpells
**   Create UI widget for each spell/macro and handle them
**      text: Name of the gob
**      icon: Icon of the gob
**      sID: ID of the gob
**      sMacro : Type of the spell
**      callbacks: Callback for the spell
**      TO:DO : Clear other useless arguments
--]]
function Brikabrok:createLabelSpells(text, icon, sID,sMacro,sType,sName,callbacks, type)
    local f = AceGUI:Create("InteractiveLabel")
  	f:SetHighlight(cachedHighlight)
    f:SetFontObject(SystemFont_Shadow_Med1)
    f:SetPoint("Top", 10, 10)
    f:SetFullWidth(true)

    if text ~= nil then
        f:SetText(text)
    end
    if icon ~= nil then
        f:SetImage(icon)
        f:SetImageSize(32, 32)
    end
  
  local callbacks
  if not callbacks then
    callbacks = {
      OnClick = function (container, event, group)  
            buttonMod = GetMouseButtonClicked()
            if buttonMod == "LeftButton" then
            if sMacro == "cast" then 
              Brikabrok:CreateMacro(sName, "INV_MISC_QUESTIONMARK", ".cast".." "..sID);
            elseif sMacro == "aura" then 
              Brikabrok:CreateMacro(sName, "INV_MISC_QUESTIONMARK", ".aura".." "..sID);
              Brikabrok:CreateMacro(sName, "INV_MISC_QUESTIONMARK", sID);
            elseif sMacro == "casttr" then 
              Brikabrok:CreateMacro(sName, "INV_MISC_QUESTIONMARK", ".cast".." "..sID.." ".."tr");
            elseif sMacro == "spellviskit" then 
              Brikabrok:CreateMacro(sName, "INV_MISC_QUESTIONMARK", ".spellviskit".." "..sID);
            elseif sMacro == "spell" then 
              SendChatMessage(".learn "..sID, "SAY")
            elseif sMacro == "starterpack" then
              -- Handle multiple things
              Brikabrok:StarterPack(sID,sName)
              Brikabrok.formatMessage("Vous venez d'utiliser un Starter Pack ! Vous pouvez les macros mettre dans votre barre d'action.", "SUCCESS")
            elseif sID == "0" then
              Brikabrok.formatMessage("Pfah ... ! Pas possible d'apprendre une catégorie en tant que sort, désolé", "WARNING")
            else
              SendChatMessage(".learn "..sID, "SAY")
            end
            elseif buttonMod == "RightButton" then
              if sMacro == nil then
                Brikabrok.formatMessage("Vous ne connaissez plus ce sort.", "WARNING")
                SendChatMessage(".unlearn "..sID, "SAY")
              elseif sMacro == "starterpack" then
                Brikabrok:RemoveStarterPack(sID,sName)
                Brikabrok.formatMessage("Tout le contenu du starter pack a été supprimé.", "SUCCESS")
              elseif sMacro == "cast" or "special" then
                DeleteMacro(sName)
                Brikabrok.formatMessage("Une macro vient d'être supprimée.", "SUCCESS")
              end
            end
      end,
            OnEnter = function (container, event, group) GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR") Brikabrok:showTooltip(GameTooltip, nil, "spells")  end ,
            OnLeave = function (container, event, group) Brikabrok:hideTooltip() end ,
                }
    else
         callbacks = v.callbacks
  end
  
  self:addCallbacks(f, callbacks)
    return f
end

function Brikabrok:StarterPack(sID,sName)
  for m = 1, #starterpack do
    if starterpack[m][1] == sID then
      for i = 2,100 do -- I really doubt that you have more than that xD, hardcoded value as I can't check number of elements for each value
        local modlearn = starterpack[m][i]
        if type(modlearn) == "number" and modlearn ~= nil  then
          SendChatMessage(".learn "..modlearn, "SAY")
        elseif type(modlearn) == "string" and modlearn ~= nil then
          local oName,oContent = strsplit("~", modlearn)
          Brikabrok:CreateMacro(oName, "INV_MISC_QUESTIONMARK", oContent);  
        end
      end
    end
  end
end

function Brikabrok:RemoveStarterPack(sID,sName)
  for m = 1, #starterpack do
    if starterpack[m][1] == sID then
      for i = 2,100 do -- I really doubt that you have more than that xD, hardcoded value as I can't check number of elements for each value
        local modlearn = starterpack[m][i]
        if type(modlearn) == "number" and modlearn ~= nil  then
          SendChatMessage(".unlearn "..modlearn, "SAY")
        elseif type(modlearn) == "string" and modlearn ~= nil then
          local oName,oContent = strsplit("~", modlearn)
          DeleteMacro(oName);  
        end
      end
    end
  end
end

--[[
**   CreateLabelGobs
**   Create UI widget for each gob and handle them
**      text: Name of the gob
**      icon: Icon of the gob
**      sID: ID of the gob
**      callbacks: Callback for the gob
--]]
function Brikabrok:CreateLabelGobs(text, icon, sID, callbacks)
    local f = AceGUI:Create("InteractiveLabel")
    f:SetHighlight("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    f:SetFontObject(SystemFont_Shadow_Med1)
    f:SetPoint("Top", 10, 10)
    f:SetFullWidth(true)

    if text ~= nil then
        f:SetText(text)
    end
    if icon ~= nil then
        f:SetImage(icon)
        f:SetImageSize(32, 32)
   else
      f:SetImage(cachedIcon)
      f:SetImageSize(32, 32)
   end
  
    local callbacks
  if not callbacks then
    callbacks = {
      OnClick = function (container, event, group)  
        buttonMod = GetMouseButtonClicked()
        if buttonMod == "LeftButton" then
          if sID=="0" then
            Brikabrok.formatMessage("Mhhh ... ? C'est pas spawnable, désolé", "WARNING")
          else  
            SendChatMessage(".gob add "..sID, "GUILD")
          end
        elseif buttonMod == "RightButton" then
            --Brikabrok.ShowPreview(nil)
            Brikabrok.formatMessage("Fonctionnalité en cours de développement, désolé.", "INFO")
        end
      end,
            OnEnter = function (container, event, group) GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR") Brikabrok:showTooltip(GameTooltip, nil, "gobs")  end ,
            OnLeave = function (container, event, group)  Brikabrok:hideTooltip() end ,
                }
    else
         callbacks = v.callbacks
  end
  
  self:addCallbacks(f, callbacks)
    return f
end

--[[
**  CreateLabelAnimations
**   Create UI widget for each animation and handle them
**      text: Name of the animation
**      icon: Icon of the animation
**      sID: ID of the animation
**      callbacks: Callback for the animation
--]]
function Brikabrok:CreateLabelAnimations(text, icon, sID, callbacks)
    local f = AceGUI:Create("InteractiveLabel")
    f:SetHighlight(cachedHighlight)
    f:SetFontObject(SystemFont_Shadow_Med1)
    f:SetPoint("Top", 10, 10)
    f:SetFullWidth(true)

    if text ~= nil then
        f:SetText(text)
    end
    if icon ~= nil then
        f:SetImage(icon)
        f:SetImageSize(32, 32)
  else
    f:SetImage(cachedIcon)
    f:SetImageSize(32, 32)
  end
  
    local callbacks
  if not callbacks then
    callbacks = {
      OnClick = function (container, event, group)  
        buttonMod = GetMouseButtonClicked()
        if buttonMod == "LeftButton" then
          SendChatMessage(".animkit "..sID, "GUILD")
        elseif buttonMod == "MiddleButton" then
          SendChatMessage(".animkit 0","GUILD")
        elseif buttonMod == "RightButton" then
            --Brikabrok.ShowPreview(nil)
            Brikabrok:CreateMacro(text, "INV_MISC_QUESTIONMARK", ".animkit ".." "..sID);
        end
      end,
            OnEnter = function (container, event, group) GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR") Brikabrok:showTooltip(GameTooltip, nil, "animations")  end ,
            OnLeave = function (container, event, group)  Brikabrok:hideTooltip() end ,
                }
    else
         callbacks = v.callbacks
  end
  
  self:addCallbacks(f, callbacks)
    return f
end

--[[
**  CreateLabelMacros
**   Create UI widget for each macro and handle them
**      text: Name of the macro
**      icon: Icon of the macro
**      body: content of the macro
**      callbacks: Callback for the macro
--]]
function Brikabrok:CreateLabelMacros(text, icon, body, callbacks)
    local f = AceGUI:Create("InteractiveLabel")
    f:SetHighlight(cachedHighlight)
    f:SetFontObject(SystemFont_Shadow_Med1)
    f:SetPoint("Top", 10, 10)
    f:SetFullWidth(true)

    if text ~= nil then
        f:SetText(text)
    end
    if icon ~= nil then
        f:SetImage(icon)
        f:SetImageSize(32, 32)
  else
    f:SetImage(cachedIcon)
    f:SetImageSize(32, 32)
  end
    local callbacks
  if not callbacks then
    callbacks = {
      OnClick = function (container, event, group)  
        buttonMod = GetMouseButtonClicked()
        if buttonMod == "LeftButton" then
          local playerName = UnitName("player")
          local shortString = text.."~"..icon.."~"..body.."~"..playerName
          if UnitInParty("target") then
            AceComm:SendCommMessage("BKBSend", shortString, "PARTY", nil, "NORMAL") 
            Brikabrok.formatMessage("Macro envoyé avec succès, en attente d'une réponse ... :", "SUCCESS") 
          else 
            Brikabrok.formatMessage("Veuillez sélectionner votre cible et être dans un groupe !", "WARNING") 
          end
        end
      end,
            OnEnter = function (container, event, group) GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR") Brikabrok:showTooltip(GameTooltip, nil, "macros")  end ,
            OnLeave = function (container, event, group)  Brikabrok:hideTooltip() end ,
                }
    else
         callbacks = v.callbacks
  end
  
  self:addCallbacks(f, callbacks)
    return f
end

function Brikabrok:CreateScrollLabel(...)
    self:addToScroll(self:createLabelSpells(...))
end

function Brikabrok:CreateScrollLabel2(...)
    self:addToScroll(self:CreateLabelGobs(...))
end

function Brikabrok:CreateScrollLabel3(...)
    self:addToScroll(self:CreateLabelAnimations(...))
end

function Brikabrok:CreateScrollLabel4(...)
    self:addToScroll(self:CreateLabelMacros(...))
end


--[[
**   BuildSpData
**   Build Spells Data on corresponding tab
**      table: data to rebuild
--]]
function Brikabrok.BuildSpData(table)
  local filterspells = AceGUI:Create("EditBox")
  filterspells:SetLabel("Filtrer:")
  filterspells:SetPoint("TOPRIGHT")
  filterspells:SetWidth(200)
  filterspells:SetCallback("OnEnterPressed", function(widget, event, text) if text=="" then brikabrokScroll:ReleaseChildren() Brikabrok.BuildSpData(Brikabrok.db.profile.spells) else Brikabrok:SpellsReload(text) Brikabrok:ReloadScroll(spellsfiltertable) end end)
  brikabrokScroll:AddChild(filterspells)

 for i = 1, #table do

  local sID = table[i][4]
  local sTexture = table[i][1]
  local sName = table[i][2]
  local sColor = table[i][3]
  local sMacro = table[i][5]
  local sType = table[i][6]

  if sTexture == nil or sName == nil then 
	 sName, rank, sTexture = GetSpellInfo(sID)
  end
  
  if sType=="categorie" then
    local headingtest = AceGUI:Create("Heading")
    headingtest:SetText(sName)
    headingtest:SetFullWidth(true)
    Brikabrok:addToScroll(headingtest)
  else 
      Brikabrok:CreateScrollLabel(sName, sTexture, sID, sMacro, sType, sName)
  end

end

end


--[[
**   BuildGobsData
**   Build Gob Data on corresponding tab
**      table: data to rebuild
--]]
function Brikabrok.BuildGobsData(table)
  local filtersgobs = AceGUI:Create("EditBox")
  filtersgobs:SetLabel("Filtrer:")
  filtersgobs:SetPoint("TOPRIGHT")
  filtersgobs:SetWidth(200)
  filtersgobs:SetCallback("OnEnterPressed", function(widget, event, text) if text=="" then brikabrokScroll:ReleaseChildren() Brikabrok.BuildGobsData(Brikabrok.db.profile.gobs) else Brikabrok:GobsReload(text) Brikabrok:ReloadScroll(gobsfiltertable) end end)
  brikabrokScroll:AddChild(filtersgobs)

 for i = 1, #table do

    local sName = table[i][1]
    local sID = table[i][2]
    local sColor = table[i][3]
    local sTexture = table[i][4]
    local sType = table[i][5]
  
    
    if sType=="categorie" then
      local headingtest = AceGUI:Create("Heading")
      headingtest:SetText(sName)
      headingtest:SetFullWidth(true)
      Brikabrok:addToScroll(headingtest)
    end
      
    if sType ~= "categorie" then
      Brikabrok:CreateScrollLabel2(sName, sTexture, sID)
    end

  end
end

--[[
**   BuildAnimationsData
**   Build Animation Data on corresponding tab
**      table: data to rebuild
--]]
function Brikabrok.BuildAnimationsData(tablea)
  local filtersanimation = AceGUI:Create("EditBox")
  filtersanimation:SetLabel("Filtrer:")
  filtersanimation:SetPoint("TOPRIGHT")
  filtersanimation:SetWidth(200)
  filtersanimation:SetCallback("OnEnterPressed", function(widget, event, text) if text=="" then brikabrokScroll:ReleaseChildren() Brikabrok.BuildAnimationsData(Brikabrok.db.profile.anim) else Brikabrok:AnimationReload(text) Brikabrok:ReloadScroll(AnimKitFilterTable) end end)
  brikabrokScroll:AddChild(filtersanimation)

 for i = 1, #tablea do

    local sID = tablea[i][1]
    local sName = tablea[i][2]
    local sType = tablea[i][3]
    local sTexture = tablea[i][4]
  
    
    if sType=="categorie" then
      local headingtest = AceGUI:Create("Heading")
      headingtest:SetText(sName)
      headingtest:SetFullWidth(true)
      Brikabrok:addToScroll(headingtest)
    end
      
    if sType ~= "categorie" then
      Brikabrok:CreateScrollLabel3(sName, sTexture, sID)
    end

  end
end


--[[
**   table_count
**   Count the number of times a value occurs in a table 
**      tt: data to count
**      item : the value
--]]
function Brikabrok.table_count(tt, item)
  local count
  count = 0
  for ii,xx in pairs(tt) do
    if item == xx then count = count + 1 end
  end
  return count
end

--[[
**   table_unique
**   Remove duplicates from a table array
**      tt: the table
--]]
function Brikabrok.table_unique(tt)
  local newtable
  newtable = {}
  for ii,xx in ipairs(tt) do
    if(Brikabrok.table_count(newtable, xx) == 0) then
      newtable[#newtable+1] = xx
    end
  end
  return newtable
end

Brikabrok.MacrosS = {}


--[[
**   BuildMacrosData
**   Build Macro Data on corresponding tab
--]]

function Brikabrok.BuildMacrosData()
 
  local filtersmacros = AceGUI:Create("EditBox")
  filtersmacros:SetLabel("Filtrer:")
  filtersmacros:SetPoint("TOPRIGHT")
  filtersmacros:SetWidth(200)
  filtersmacros:SetCallback("OnEnterPressed", function(widget, event, text) if text=="" then brikabrokScroll:ReleaseChildren() Brikabrok.RebuildMacrosData(Brikabrok.MacrosS) else Brikabrok:MacroReload(text) Brikabrok.table_unique(Brikabrok.MacrosFilter) Brikabrok:ReloadScroll(Brikabrok.MacrosFilter) end end)
  brikabrokScroll:AddChild(filtersmacros)

  local numglobal,numperchar = GetNumMacros()
  local numAccountMacros, numCharacterMacros = GetNumMacros();

 for i = 1, 512 do
    local name, iconTexture, body, isLocal = GetMacroInfo(i);

    if iconTexture == nil then
    else
      table.insert(Brikabrok.MacrosS, {name,iconTexture,body})
      Brikabrok:CreateScrollLabel4(name, iconTexture, body)
    end
  end
  Brikabrok.table_unique(Brikabrok.MacrosS)
end

--[[
**   RebuildMacrosData
**   Rebuild Macro Data on corresponding tab
--]]

function Brikabrok.RebuildMacrosData(table)

  local filtersmacros = AceGUI:Create("EditBox")
  filtersmacros:SetLabel("Filtrer:")
  filtersmacros:SetPoint("TOPRIGHT")
  filtersmacros:SetWidth(200)
  filtersmacros:SetCallback("OnEnterPressed", function(widget, event, text) if text=="" then brikabrokScroll:ReleaseChildren() Brikabrok.RebuildMacrosData(Brikabrok.MacrosS) else Brikabrok:MacroReload(text) Brikabrok:ReloadScroll(Brikabrok.MacrosFilter) end end)
  brikabrokScroll:AddChild(filtersmacros)

 for i = 1, #table do
    local sName = table[i][1]
    local sTexture = table[i][2]
    local sID = table[i][3]
    --print(sTexture)
  
    Brikabrok:CreateScrollLabel4(sName, sTexture, sID)
  end

end

--[[
**   ReloadScroll
**   Clear all children from the scrollframe and rebuild data
**      table: data to rebuild
--]]
function Brikabrok:ReloadScroll(table)
  if table == savetable or table == brikabrokSpells or table == spellsfiltertable or table == Brikabrok.db.profile.spells then
        brikabrokScroll:ReleaseChildren()
        Brikabrok.BuildSpData(table)
  elseif table == brikabrokGobs or table == savetablegobs or table == gobsfiltertable or table == Brikabrok.db.profile.gobs then
        brikabrokScroll:ReleaseChildren()
        Brikabrok.BuildGobsData(table)
  elseif table == brikabrokAnimKit or table == savetableanimations or table == AnimKitFilterTable or table == Brikabrok.db.profile.anim then
        brikabrokScroll:ReleaseChildren()
        Brikabrok.BuildAnimationsData(table) 
  elseif table == Brikabrok.MacrosFilter or table == Brikabrok.MacrosS then
        brikabrokScroll:ReleaseChildren()
        Brikabrok.RebuildMacrosData(table)
  end
end

--[[
**   SpellsReload
**   Reload spells data according to the filter message and rebuild them
**      text: filter message
--]]
function Brikabrok:SpellsReload(text)
  spellsfiltertable = {}
  for i = 1, #Brikabrok.db.profile.spells do
    if not Brikabrok.db.profile.spells[i] then
      print (i)
        return false
    end
    local sMeme = Brikabrok.db.profile.spells[i][2]
    local sIDs = Brikabrok.db.profile.spells[i][4]
    if Brikabrok.stringMatch(text,sIDs,sMeme,"") then
      if Brikabrok.db.profile.spells[i][6]~="categorie" then
        table.insert(spellsfiltertable, Brikabrok.db.profile.spells[i])
      end
    elseif text=="" then
    end
end
end

--[[
**   GobsReload
**   Reload gobs data according to the filter message and rebuild them
**      text: filter message
--]]
function Brikabrok:GobsReload(text)
  gobsfiltertable = {}
  for i = 1, #Brikabrok.db.profile.gobs do
    if not Brikabrok.db.profile.gobs[i] then
        return false
    end
    local sMeme = Brikabrok.db.profile.gobs[i][1]
    local sIDs = Brikabrok.db.profile.gobs[i][2]
    if Brikabrok.stringMatch(text,sIDs,sMeme,"") then
        table.insert(gobsfiltertable, Brikabrok.db.profile.gobs[i])
    elseif text=="" then
    end
end
end

--[[
**   AnimationReload
**   Reload animations data according to the filter message and rebuild them
**      text: filter message
--]]
function Brikabrok:AnimationReload(text)
  AnimKitFilterTable = {}
  for i = 1, #Brikabrok.db.profile.anim do
    if not Brikabrok.db.profile.anim[i] then
        return false
    end
    local sIDs = Brikabrok.db.profile.anim[i][1]
    local sMeme = Brikabrok.db.profile.anim[i][2]
    if Brikabrok.stringMatch(text,sIDs,sMeme,"") then
        table.insert(AnimKitFilterTable, Brikabrok.db.profile.anim[i])
    elseif text=="" then
    end
end
end

--[[
**   MacroReload
**   Reload macros data according to the filter message and rebuild them
**      text: filter message
--]]
function Brikabrok:MacroReload(text)
  Brikabrok.MacrosFilter = {}
  for i = 1, #Brikabrok.MacrosS do
    if not Brikabrok.MacrosS[i] then
        return false
    end
    local sIDs = Brikabrok.MacrosS[i][3]
    local sMeme = Brikabrok.MacrosS[i][1]
    if Brikabrok.stringMatch(text,sIDs,sMeme,"") then
        table.insert(Brikabrok.MacrosFilter, Brikabrok.MacrosS[i])
    elseif text=="" then
    end
end
end

end
