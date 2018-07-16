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
local libSerializer = LibStub:GetLibrary("AceSerializer-3.0");
local AceComm = LibStub("AceComm-3.0")


function BrikabrokCONFIG:OnEnable()


--[[
**   DrawGroupDev1
**   Draw the first tab for the secondary frame
**    container: Which container hold this
--]]
function Brikabrok:DrawGroupDev1(container)

    local addSpellsHeading = AceGUI:Create("Heading")
    addSpellsHeading:SetText("Ajouter des spells")
    addSpellsHeading:SetFullWidth(true)
    brikabrokDevScroll:AddChild(addSpellsHeading)

    bkbICONSpells = AceGUI:Create("EditBox")
    bkbICONSpells:SetText("Interface\\Icons\\idicône")
    bkbICONSpells:SetPoint("CENTER")
    bkbICONSpells:SetLabel("Icône du spell")
    brikabrokDevScroll:AddChild(bkbICONSpells)
	
	  bkbSpellsICON = AceGUI:Create("Icon")
    bkbSpellsICON:SetImage("Interface\\Icons\\trade_engineering")
	  bkbSpellsICON:SetImageSize(16,16)
    bkbSpellsICON:SetPoint("CENTER")
    bkbSpellsICON:SetLabel("Icône du spell")
	  local callbacks = {
		  OnClick = function (container, event, group)
			 Brikabrok:ShowBrowserFrame("spells")
		end
	  }
	  Brikabrok:addCallbacks(bkbSpellsICON, callbacks)
    brikabrokDevScroll:AddChild(bkbSpellsICON)

    local ebName = AceGUI:Create("EditBox")
    ebName:SetText("Nom du spell")
    ebName:SetPoint("CENTER")
    ebName:SetLabel("Nom du spell")
    brikabrokDevScroll:AddChild(ebName)

    local ebContent = AceGUI:Create("EditBox")
    ebContent:SetText("Contenu ( ID Spell, Macro, ... )")
    ebContent:SetPoint("CENTER")
    ebContent:SetLabel("Contenu ( ID Spell, Macro, ... )")
    brikabrokDevScroll:AddChild(ebContent)

    local cbCategorie = AceGUI:Create("CheckBox")
    cbCategorie:SetLabel("Catégorie")
    brikabrokDevScroll:AddChild(cbCategorie)
    
    local spDataType = {
        spell = "Spells",
        aura = "Aura",
        cast = "Cast",
        casttr = "Casttr",
        special = "Macro",
        spellviskit = "Spellviskit"
    } 


  local ebType= AceGUI:Create("Dropdown")
  ebType:SetList(spDataType)
  ebType:SetText("Type(semi-optionnel)")
  ebType:SetLabel("Type(semi-optionnel)")
  brikabrokDevScroll:AddChild(ebType)
  ebType:SetCallback("OnValueChanged", function(self,callback,key) keyDevDrop = key end)

  local ebResult = AceGUI:Create("MultiLineEditBox")
  ebResult:SetText("Résultat")
  ebResult:SetPoint("CENTER")
  ebResult:SetLabel("Résultat")
  brikabrokDevScroll:AddChild(ebResult)

  local ebButton = AceGUI:Create("Button")
  ebButton:SetText("Build")
  ebButton:SetWidth(200)
  ebButton:SetCallback("OnClick", function() 
    if cbCategorie:GetValue() == true and keyDevDrop then 
      ebResult:SetText('{"'..bkbICONSpells:GetText()..'","'..ebName:GetText()..'","'..'nil","'..ebContent:GetText()..'","'..keyDevDrop..'","categorie"} \n') 
      table.insert(Brikabrok.db.profile.spells,{bkbICONSpells:GetText(),ebName:GetText(),nil,ebContent:GetText(),keyDevDrop,"categorie"}) 
	elseif cbCategorie:GetValue() == true and not keyDevDrop then 
		Brikabrok.formatMessage("Veuillez sélectionner le type des données.","WARNING")
    elseif cbCategorie:GetValue() == false and keyDevDrop then 
      ebResult:SetText('{"'..bkbICONSpells:GetText()..'","'..ebName:GetText()..'","'..'nil","'..ebContent:GetText()..'","'..keyDevDrop..'"} \n') 
      table.insert(Brikabrok.db.profile.spells,{bkbICONSpells:GetText(),ebName:GetText(),nil,ebContent:GetText(),keyDevDrop}) 
	elseif cbCategorie:GetValue() == false and not keyDevDrop then 
		Brikabrok.formatMessage("Veuillez sélectionner le type des données.","WARNING")
    end
    end)
  brikabrokDevScroll:AddChild(ebButton)



  local DropdownSpells = {}
  function Brikabrok:buildTableSpells()
    for i=1,#Brikabrok.db.profile.spells do
      if not Brikabrok.db.profile.spells[i] then
          return false
      else
        local spName = Brikabrok.db.profile.spells[i][2]
        local spIcon = Brikabrok.db.profile.spells[i][1]
        if spIcon == nil then
          spIcon = "Interface\\Icons\\trade_engineering"
        end
        DropdownSpells[i] = "|T"..spIcon..":16|t "..spName
      end
    end
  end

  local function refreshTable(widget,widget1)
    DropdownSpells = {}
    Brikabrok:buildTableSpells()
  end

  local function tableSwap(table,firstValue,secondValue)
    local contentValue1 = table[firstValue]
    local contentValue2 = table[secondValue]
    table[firstValue] = contentValue2
    table[secondValue] = contentValue1
  end


  Brikabrok:buildTableSpells()


  local remSpellsHeading = AceGUI:Create("Heading")
  remSpellsHeading:SetText("Supprimer des spells")
  remSpellsHeading:SetFullWidth(true)
  brikabrokDevScroll:AddChild(remSpellsHeading)

  local ebDelete= AceGUI:Create("Dropdown")
  ebDelete:SetList(DropdownSpells)
  ebDelete:SetText("Choissisez un spell")
  ebDelete:SetLabel("Choissisez un spell")
  brikabrokDevScroll:AddChild(ebDelete)
  ebDelete:SetCallback("OnValueChanged", function(self,callback,key) keyDevDrop6 = key end)

  local ebButtonRemove = AceGUI:Create("Button")
  ebButtonRemove:SetText("Supprimer")
  ebButtonRemove:SetWidth(200)
  ebButtonRemove:SetCallback("OnClick", function() table.remove(Brikabrok.db.profile.spells,keyDevDrop6) refreshTable() ebDelete:SetList(DropdownSpells) ebDelete:SetText(DropdownSpells[keyDevDrop6+1]) end)
  brikabrokDevScroll:AddChild(ebButtonRemove)

  local ebButtonRemoveAll = AceGUI:Create("Button")
  ebButtonRemoveAll:SetText("Supprimer tout")
  ebButtonRemoveAll:SetWidth(200)
  ebButtonRemoveAll:SetCallback("OnClick", function() 
      StaticPopupDialogs["WarningDeleteSpell"] = {
      text = "Voulez-vous vraiment supprimer tout le contenu de vos spells ?",
      button1 = "Oui",
      button2 = "Non",
      OnAccept = function()
        wipe(Brikabrok.db.profile.spells)
        refreshTable()
        ebDelete:SetList(DropdownSpells)
        Brikabrok.formatMessage("Tout le contenu a été supprimé.")
      end,
      OnCancel = function()
        Brikabrok.formatMessage("Action annulée")
      end,
      timeout = 0,
      whileDead = true,
      hideOnEscape = true,
      preferredIndex = 3,
    }
    StaticPopup_Show("WarningDeleteSpell")
  end)
  brikabrokDevScroll:AddChild(ebButtonRemoveAll)

  local movSpellsHeading = AceGUI:Create("Heading")
  movSpellsHeading:SetText("Déplacer des spells")
  movSpellsHeading:SetFullWidth(true)
  brikabrokDevScroll:AddChild(movSpellsHeading)

  local ebSwap1 = AceGUI:Create("Dropdown")
  ebSwap1:SetList(DropdownSpells)
  ebSwap1:SetText("Choissisez un spell")
  ebSwap1:SetLabel("Premier spell")
  brikabrokDevScroll:AddChild(ebSwap1)
  ebSwap1:SetCallback("OnValueChanged", function(self,callback,key) keyDevDrop7 = key end)


  local ebSwap2 = AceGUI:Create("Dropdown")
  ebSwap2:SetList(DropdownSpells)
  ebSwap2:SetText("Choissisez un spell")
  ebSwap2:SetLabel("Deuxième Spell")
  brikabrokDevScroll:AddChild(ebSwap2)
  ebSwap2:SetCallback("OnValueChanged", function(self,callback,key) keyDevDrop8 = key end)

  local ebButtonSwap = AceGUI:Create("Button")
  ebButtonSwap:SetText("Swap")
  ebButtonSwap:SetWidth(200)
  ebButtonSwap:SetCallback("OnClick", function() 
   tableSwap(DropdownSpells,keyDevDrop7,keyDevDrop8)
   tableSwap(Brikabrok.db.profile.spells,keyDevDrop7,keyDevDrop8)
   refreshTable(ebSwap1,ebSwap2) 
   ebSwap1:SetList(DropdownSpells) 
   ebSwap2:SetList(DropdownSpells) 
   ebSwap2:SetText(DropdownSpells[keyDevDrop8]) 
   ebSwap1:SetText(DropdownSpells[keyDevDrop7])
   end)
  brikabrokDevScroll:AddChild(ebButtonSwap)

  local divSpellsHeading = AceGUI:Create("Heading")
  divSpellsHeading:SetText("Divers")
  divSpellsHeading:SetFullWidth(true)
  brikabrokDevScroll:AddChild(divSpellsHeading)

  local ebButtonRefresh = AceGUI:Create("Button")
  ebButtonRefresh:SetText("Actualiser")
  ebButtonRefresh:SetWidth(200)
  ebButtonRefresh:SetCallback("OnClick", function() refreshTable() ebDelete:SetList(DropdownSpells) ebSwap1:SetList(DropdownSpells)  ebSwap2:SetList(DropdownSpells) end)
  brikabrokDevScroll:AddChild(ebButtonRefresh)



end


--[[
**   DrawGroupDev2
**   Draw the 2nd tab for the secondary frame
**    container: Which container hold this
--]]
function Brikabrok:DrawGroupDev2(container)

    local ebNameGob = AceGUI:Create("EditBox")
    ebNameGob:SetText("Nom du gob")
    ebNameGob:SetPoint("CENTER")
    ebNameGob:SetLabel("Nom du gob")
    brikabrokDevScroll:AddChild(ebNameGob)

    local ebContentGob = AceGUI:Create("EditBox")
    ebContentGob:SetText("EntryID du Gob")
    ebContentGob:SetPoint("CENTER")
    ebContentGob:SetLabel("EntryID du Gob")
    brikabrokDevScroll:AddChild(ebContentGob)
        
    bkbICONGob = AceGUI:Create("EditBox")
    bkbICONGob:SetText("Interface\\Icons\\idicône")
    bkbICONGob:SetPoint("CENTER")
    bkbICONGob:SetLabel("Icône du Gob")
    brikabrokDevScroll:AddChild(bkbICONGob)
	
	  bkbGobICON = AceGUI:Create("Icon")
    bkbGobICON:SetImage("Interface\\Icons\\trade_engineering")
	  bkbGobICON:SetImageSize(16,16)
    bkbGobICON:SetPoint("CENTER")
    bkbGobICON:SetLabel("Icône du gob")
	  local callbacks = {
		  OnClick = function (container, event, group)
			Brikabrok:ShowBrowserFrame("gobs")
		end
	  }
	  Brikabrok:addCallbacks(bkbGobICON, callbacks)
    brikabrokDevScroll:AddChild(bkbGobICON)
    
    local gobDataType = {
        categorie = "Catégorie",
        other = "Gob",
    } 

  local ebTypeGob = AceGUI:Create("Dropdown")
  ebTypeGob:SetList(gobDataType)
  ebTypeGob:SetText("Type")
  ebTypeGob:SetLabel("Type")
  brikabrokDevScroll:AddChild(ebTypeGob)
  ebTypeGob:SetCallback("OnValueChanged", function(self,callback,key) keyDev2Drop = key end)

  local ebResultGob = AceGUI:Create("MultiLineEditBox")
  ebResultGob:SetText("Résultat")
  ebResultGob:SetPoint("CENTER")
  ebResultGob:SetLabel("Résultat")
  brikabrokDevScroll:AddChild(ebResultGob)

  local ebButtonGob = AceGUI:Create("Button")
  ebButtonGob:SetText("Build")
  ebButtonGob:SetWidth(200)
  ebButtonGob:SetCallback("OnClick", function() 
    if keyDev2Drop then
		ebResultGob:SetText('{"'..ebNameGob:GetText()..'","'..ebContentGob:GetText()..'","'..'nil","'..bkbICONGob:GetText()..'","'..keyDev2Drop..'"} \n') 
		table.insert(Brikabrok.db.profile.gobs,{ebNameGob:GetText(),ebContentGob:GetText(),nil,bkbICONGob:GetText(),keyDev2Drop})
	elseif not keyDev2Drop then
		Brikabrok.formatMessage("Veuillez sélectionner le type des données.","WARNING")
	end
	end)
  brikabrokDevScroll:AddChild(ebButtonGob)

  local DropdownGobs = {}
  function Brikabrok:buildTableGobs()
    for i=1,#Brikabrok.db.profile.gobs do
      if not Brikabrok.db.profile.gobs[i] then
          return false
      else
        local gobName = Brikabrok.db.profile.gobs[i][1]
        local gobIcon = Brikabrok.db.profile.gobs[i][4]
        if gobIcon == nil then
          gobIcon = "Interface\\Icons\\trade_engineering"
        end
        DropdownGobs[i] = "|T"..gobIcon..":16|t "..gobName
      end
    end
  end

  local function refreshTableGobs()
    DropdownGobs = {}
    Brikabrok:buildTableGobs()
  end

  local function tableSwap(table,firstValue,secondValue)
    local contentValue1 = table[firstValue]
    local contentValue2 = table[secondValue]
    table[firstValue] = contentValue2
    table[secondValue] = contentValue1
  end


  Brikabrok:buildTableGobs()

  local remGobsHeading = AceGUI:Create("Heading")
  remGobsHeading:SetText("Supprimer des gobs")
  remGobsHeading:SetFullWidth(true)
  brikabrokDevScroll:AddChild(remGobsHeading)

  local ebDeleteGob = AceGUI:Create("Dropdown")
  ebDeleteGob:SetList(DropdownGobs)
  ebDeleteGob:SetText("Choissisez un gob")
  ebDeleteGob:SetLabel("Choissisez un gob")
  brikabrokDevScroll:AddChild(ebDeleteGob)
  ebDeleteGob:SetCallback("OnValueChanged", function(self,callback,key) keyDevDrop9 = key end)

  local ebButtonRemoveGob = AceGUI:Create("Button")
  ebButtonRemoveGob:SetText("Supprimer")
  ebButtonRemoveGob:SetWidth(200)
  ebButtonRemoveGob:SetCallback("OnClick", function() table.remove(Brikabrok.db.profile.gobs,keyDevDrop9) refreshTableGobs() ebDeleteGob:SetList(DropdownGobs) ebDeleteGob:SetText(DropdownGobs[keyDevDrop9+1]) end)
  brikabrokDevScroll:AddChild(ebButtonRemoveGob)

  local ebButtonRemoveAllGob = AceGUI:Create("Button")
  ebButtonRemoveAllGob:SetText("Supprimer tout")
  ebButtonRemoveAllGob:SetWidth(200)
  ebButtonRemoveAllGob:SetCallback("OnClick", function() 
      StaticPopupDialogs["WarningDeleteGob"] = {
      text = "Voulez-vous vraiment supprimer tout le contenu de vos gobs ?",
      button1 = "Oui",
      button2 = "Non",
      OnAccept = function()
        wipe(Brikabrok.db.profile.gobs)
        refreshTableGobs() 
        ebDeleteGob:SetList(DropdownGobs)
        Brikabrok.formatMessage("Tout le contenu a été supprimé.")
      end,
      OnCancel = function()
        Brikabrok.formatMessage("Action annulée")
      end,
      timeout = 0,
      whileDead = true,
      hideOnEscape = true,
      preferredIndex = 3,
    }
    StaticPopup_Show("WarningDeleteGob")
  end)
  brikabrokDevScroll:AddChild(ebButtonRemoveAllGob)

  local movGobsHeading = AceGUI:Create("Heading")
  movGobsHeading:SetText("Déplacer des gobs")
  movGobsHeading:SetFullWidth(true)
  brikabrokDevScroll:AddChild(movGobsHeading)

  local ebSwap1Gob = AceGUI:Create("Dropdown")
  ebSwap1Gob:SetList(DropdownGobs)
  ebSwap1Gob:SetText("Choissisez un gob")
  ebSwap1Gob:SetLabel("Premier Gob")
  brikabrokDevScroll:AddChild(ebSwap1Gob)
  ebSwap1Gob:SetCallback("OnValueChanged", function(self,callback,key) keyDevDrop10 = key end)

  local ebSwap2Gob = AceGUI:Create("Dropdown")
  ebSwap2Gob:SetList(DropdownGobs)
  ebSwap2Gob:SetText("Choissisez un gob")
  ebSwap2Gob:SetLabel("Deuxième Gob")
  brikabrokDevScroll:AddChild(ebSwap2Gob)
  ebSwap2Gob:SetCallback("OnValueChanged", function(self,callback,key) keyDevDrop11 = key end)

  local ebButtonSwapGob = AceGUI:Create("Button")
  ebButtonSwapGob:SetText("Swap")
  ebButtonSwapGob:SetWidth(200)
  ebButtonSwapGob:SetCallback("OnClick", function() 
   tableSwap(DropdownGobs,keyDevDrop10,keyDevDrop11)
   tableSwap(Brikabrok.db.profile.gobs,keyDevDrop10,keyDevDrop11)
   refreshTableGobs() 
   ebSwap1Gob:SetList(DropdownGobs) 
   ebSwap2Gob:SetList(DropdownGobs) 
   ebSwap2Gob:SetText(DropdownGobs[keyDevDrop11]) 
   ebSwap1Gob:SetText(DropdownGobs[keyDevDrop10])
   end)
  brikabrokDevScroll:AddChild(ebButtonSwapGob)

  local divGobHeading = AceGUI:Create("Heading")
  divGobHeading:SetText("Divers")
  divGobHeading:SetFullWidth(true)
  brikabrokDevScroll:AddChild(divGobHeading)

  local ebButtonRefreshGob = AceGUI:Create("Button")
  ebButtonRefreshGob:SetText("Actualiser")
  ebButtonRefreshGob:SetWidth(200)
  ebButtonRefreshGob:SetCallback("OnClick", function() refreshTableGobs() ebDeleteGob:SetList(DropdownGobs) ebSwap1Gob:SetList(DropdownGobs) ebSwap2Gob:SetList(DropdownGobs)end)
  brikabrokDevScroll:AddChild(ebButtonRefreshGob)
end
function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end

--[[
**   DrawGroupDev3
**   Draw the 3rd tab for the secondary frame
**    container: Which container hold this
--]]


function Brikabrok:DrawGroupDev3(container)

    local ebContentAnim = AceGUI:Create("EditBox")
    ebContentAnim:SetText("ID de l'animkit")
    ebContentAnim:SetPoint("CENTER")
    ebContentAnim:SetLabel("ID de l'animkit")
    brikabrokDevScroll:AddChild(ebContentAnim)

    local ebNameAnim = AceGUI:Create("EditBox")
    ebNameAnim:SetText("Nom de l'animation")
    ebNameAnim:SetPoint("CENTER")
    ebNameAnim:SetLabel("Nom de l'animation")
    brikabrokDevScroll:AddChild(ebNameAnim)
	
	bkbICONAnim = AceGUI:Create("EditBox")
    bkbICONAnim:SetText("Interface\\Icons\\idicône")
    bkbICONAnim:SetPoint("CENTER")
    bkbICONAnim:SetLabel("Icône de l'anim")
    brikabrokDevScroll:AddChild(bkbICONAnim)
	
	bkbAnimICON = AceGUI:Create("Icon")
    bkbAnimICON:SetImage("Interface\\Icons\\trade_engineering")
	bkbAnimICON:SetImageSize(16,16)
    bkbAnimICON:SetPoint("CENTER")
    bkbAnimICON:SetLabel("Icône de l'anim")
	local callbacks = {
		OnClick = function (container, event, group)
			Brikabrok:ShowBrowserFrame("anims")
		end
	}
	Brikabrok:addCallbacks(bkbAnimICON, callbacks)
    brikabrokDevScroll:AddChild(bkbAnimICON)

    local animDataType = {
        categorie = "Catégorie",
        other = "Anim",
    } 

  local ebTypeAnim = AceGUI:Create("Dropdown")
  ebTypeAnim:SetList(animDataType)
  ebTypeAnim:SetText("Type")
  ebTypeAnim:SetLabel("Type")
  brikabrokDevScroll:AddChild(ebTypeAnim)
  ebTypeAnim:SetCallback("OnValueChanged", function(self,callback,key) keyDev3Drop = key if keyDev3Drop==other then keyDev3Drop="nil" end end)

  local ebResultAnim = AceGUI:Create("MultiLineEditBox")
  ebResultAnim:SetText("Résultat")
  ebResultAnim:SetPoint("CENTER")
  ebResultAnim:SetLabel("Résultat")
  brikabrokDevScroll:AddChild(ebResultAnim)

  local ebButtonAnim = AceGUI:Create("Button")
  ebButtonAnim:SetText("Build")
  ebButtonAnim:SetWidth(200)
  ebButtonAnim:SetCallback("OnClick", function() 
    if keyDev3Drop then
      ebResultAnim:SetText('{"'..ebContentAnim:GetText()..'","'..ebNameAnim:GetText()..'","'..keyDev3Drop..'"}') 
      table.insert(Brikabrok.db.profile.anim,{ebContentAnim:GetText(),ebNameAnim:GetText(),keyDev3Drop,bkbICONAnim:GetText()}) 
    else
      Brikabrok.formatMessage("Veuillez sélectionner le type des données.","WARNING")
    end
  end)
  brikabrokDevScroll:AddChild(ebButtonAnim)

  local DropdownAnims = {}
  function Brikabrok:buildTableAnims()
    for i=1,#Brikabrok.db.profile.anim do
      if not Brikabrok.db.profile.anim[i] then
          return false
      else
        local animName = Brikabrok.db.profile.anim[i][2]
        local animIcon = Brikabrok.db.profile.anim[i][4]
        if animIcon == nil then
          animIcon = "Interface\\Icons\\trade_engineering"
        end
        DropdownAnims[i] = "|T"..animIcon..":16|t "..animName
      end
    end
  end

  local function refreshTableAnims()
    DropdownAnims = {}
    Brikabrok:buildTableAnims()
  end

  local function tableSwap(table,firstValue,secondValue)
    local contentValue1 = table[firstValue]
    local contentValue2 = table[secondValue]
    table[firstValue] = contentValue2
    table[secondValue] = contentValue1
  end


  Brikabrok:buildTableAnims()

  local remAnimHeading = AceGUI:Create("Heading")
  remAnimHeading:SetText("Supprimer des animations")
  remAnimHeading:SetFullWidth(true)
  brikabrokDevScroll:AddChild(remAnimHeading)

  local ebDeleteAnim = AceGUI:Create("Dropdown")
  ebDeleteAnim:SetList(DropdownAnims)
  ebDeleteAnim:SetText("Choissisez un animkit")
  ebDeleteAnim:SetLabel("Choissisez un animkit")
  brikabrokDevScroll:AddChild(ebDeleteAnim)
  ebDeleteAnim:SetCallback("OnValueChanged", function(self,callback,key) keyDevDrop12 = key end)

  local ebButtonRemoveAnim = AceGUI:Create("Button")
  ebButtonRemoveAnim:SetText("Supprimer")
  ebButtonRemoveAnim:SetWidth(200)
  ebButtonRemoveAnim:SetCallback("OnClick", function() table.remove(Brikabrok.db.profile.anim,keyDevDrop12) refreshTableAnims() ebDeleteAnim:SetList(DropdownAnims) ebDeleteAnim:SetText(DropdownAnims[keyDevDrop12+1]) end)
  brikabrokDevScroll:AddChild(ebButtonRemoveAnim)

  local ebButtonRemoveAllAnim = AceGUI:Create("Button")
  ebButtonRemoveAllAnim:SetText("Supprimer tout")
  ebButtonRemoveAllAnim:SetWidth(200)
  ebButtonRemoveAllAnim:SetCallback("OnClick", function() 
      StaticPopupDialogs["WarningDeleteAnim"] = {
      text = "Voulez-vous vraiment supprimer tout le contenu de vos animations ?",
      button1 = "Oui",
      button2 = "Non",
      OnAccept = function()
        wipe(Brikabrok.db.profile.anim)
        refreshTableAnims() 
        ebDeleteAnim:SetList(DropdownAnims) 
        Brikabrok.formatMessage("Tout le contenu a été supprimé.")
      end,
      OnCancel = function()
        Brikabrok.formatMessage("Action annulée")
      end,
      timeout = 0,
      whileDead = true,
      hideOnEscape = true,
      preferredIndex = 3,
    }
    StaticPopup_Show("WarningDeleteAnim")
    end)
  brikabrokDevScroll:AddChild(ebButtonRemoveAllAnim)

  local movAnimsHeading = AceGUI:Create("Heading")
  movAnimsHeading:SetText("Déplacer des animkits")
  movAnimsHeading:SetFullWidth(true)
  brikabrokDevScroll:AddChild(movAnimsHeading)

  local ebSwap1Anim = AceGUI:Create("Dropdown")
  ebSwap1Anim:SetList(DropdownAnims)
  ebSwap1Anim:SetText("Choissisez un animkit")
  ebSwap1Anim:SetLabel("Premier Animkit")
  brikabrokDevScroll:AddChild(ebSwap1Anim)
  ebSwap1Anim:SetCallback("OnValueChanged", function(self,callback,key) keyDevDrop13 = key end)

  local ebSwap2Anim = AceGUI:Create("Dropdown")
  ebSwap2Anim:SetList(DropdownAnims)
  ebSwap2Anim:SetText("Choissisez un animkit")
  ebSwap2Anim:SetLabel("Deuxième Animkit")
  brikabrokDevScroll:AddChild(ebSwap2Anim)
  ebSwap2Anim:SetCallback("OnValueChanged", function(self,callback,key) keyDevDrop14 = key end)

  local ebButtonSwapAnim = AceGUI:Create("Button")
  ebButtonSwapAnim:SetText("Swap")
  ebButtonSwapAnim:SetWidth(200)
  ebButtonSwapAnim:SetCallback("OnClick", function() 
   tableSwap(DropdownAnims,keyDevDrop13,keyDevDrop14)
   tableSwap(Brikabrok.db.profile.anim,keyDevDrop13,keyDevDrop14)
   refreshTableAnims() 
   ebSwap1Anim:SetList(DropdownAnims) 
   ebSwap2Anim:SetList(DropdownAnims) 
   ebSwap2Anim:SetText(DropdownAnims[keyDevDrop14]) 
   ebSwap1Anim:SetText(DropdownAnims[keyDevDrop13])
   end)
  brikabrokDevScroll:AddChild(ebButtonSwapAnim)

  local divAnimHeading = AceGUI:Create("Heading")
  divAnimHeading:SetText("Divers")
  divAnimHeading:SetFullWidth(true)
  brikabrokDevScroll:AddChild(divAnimHeading)

  local ebButtonRefreshAnim = AceGUI:Create("Button")
  ebButtonRefreshAnim:SetText("Actualiser")
  ebButtonRefreshAnim:SetWidth(200)
  ebButtonRefreshAnim:SetCallback("OnClick", function() refreshTableAnims() ebDeleteAnim:SetList(DropdownAnims) ebSwap1Anim:SetList(DropdownAnims)  ebSwap2Anim:SetList(DropdownAnims)end)
  brikabrokDevScroll:AddChild(ebButtonRefreshAnim)

end

--[[
**   DrawGroupDev4
**   Draw the 4th tab for the secondary frame
**    container: Which container hold this
--]]


function Brikabrok:DrawGroupDev4(container)

  local headingExport = AceGUI:Create("Heading")
  headingExport:SetText("Exporter")
  headingExport:SetFullWidth(true)
  brikabrokDevScroll:AddChild(headingExport)


  local exportDataType = {
    spells = "Spells",
    gobs = "Gobs",
    anims = "Animations",
  } 

  local ebTypeDataS = AceGUI:Create("Dropdown")
  ebTypeDataS:SetList(exportDataType)
  ebTypeDataS:SetText("Type des données")
  ebTypeDataS:SetLabel("Type des données")
  brikabrokDevScroll:AddChild(ebTypeDataS)
  ebTypeDataS:SetCallback("OnValueChanged", function(self,callback,key) keyDev23Drop = key end)

  local ebExportR = AceGUI:Create("MultiLineEditBox")
  ebExportR:SetText("Données à exporter")
  ebExportR:SetPoint("CENTER")
  ebExportR:SetLabel("Données à exporter")
  brikabrokDevScroll:AddChild(ebExportR)

  local bExport = AceGUI:Create("Button")
  bExport:SetText("Récupérer")
  bExport:SetWidth(200)
  bExport:SetCallback("OnClick", function()
    if keyDev23Drop == "spells" then
      local serializedExport = Brikabrok:SerializeTable(Brikabrok.db.profile.spells)
      ebExportR:SetText(serializedExport) 
      Brikabrok.formatMessage("Exportation des données réussis") 
    elseif keyDev23Drop == "gobs" then
      local serializedExport = Brikabrok:SerializeTable(Brikabrok.db.profile.gobs)
      ebExportR:SetText(serializedExport) 
      Brikabrok.formatMessage("Exportation des données réussis") 
    elseif  keyDev23Drop == "anims" then
      local serializedExport = Brikabrok:SerializeTable(Brikabrok.db.profile.anim)
      ebExportR:SetText(serializedExport) 
      Brikabrok.formatMessage("Exportation des données réussis") 
    else 
      Brikabrok.formatMessage("Données non valides", "WARNING")
    end
    end)
  brikabrokDevScroll:AddChild(bExport)

  local headingImport = AceGUI:Create("Heading")
  headingImport:SetText("Importer")
  headingImport:SetFullWidth(true)
  brikabrokDevScroll:AddChild(headingImport)

  local ebImportR = AceGUI:Create("MultiLineEditBox")
  ebImportR:SetText("Données à importer")
  ebImportR:SetPoint("CENTER")
  ebImportR:SetLabel("Données à importer")
  brikabrokDevScroll:AddChild(ebImportR )

  local importDataType = {
    spells = "Spells",
    gobs = "Gobs",
    anims = "Animations",
  } 

  local ebTypeData = AceGUI:Create("Dropdown")
  ebTypeData:SetList(importDataType)
  ebTypeData:SetText("Type des données")
  ebTypeData:SetLabel("Type des données")
  brikabrokDevScroll:AddChild(ebTypeData)
  ebTypeData:SetCallback("OnValueChanged", function(self,callback,key) keyDev4Drop = key end)

  local ebImport = AceGUI:Create("Button")
  ebImport:SetText("Importer")
  ebImport:SetWidth(200)
  ebImport:SetCallback("OnClick", function()
    local code = ebImportR:GetText()
    local object = Brikabrok:safeDeserialize(code)
    if object and type(object) == "table" then
        if keyDev4Drop == "spells" then
            Brikabrok.db.profile.spells = object
             Brikabrok.formatMessage("Importation des spells réussis")
        elseif keyDev4Drop == "gobs" then
            Brikabrok.db.profile.gobs = object
            Brikabrok.formatMessage("Importation des gobs réussis")
        elseif keyDev4Drop == "anims" then 
            Brikabrok.db.profile.anim = object
            Brikabrok.formatMessage("Importation des animations réussis")
        else
            Brikabrok.formatMessage("Type de données non reconnues")
        end
    else
        Brikabrok.formatMessage("Échec de l'importation, veuillez vérifier l'intégrité des données.")
    end
  end)
  brikabrokDevScroll:AddChild(ebImport)
  
  local headingShare = AceGUI:Create("Heading")
  headingShare:SetText("Partager avec un ami")
  headingShare:SetFullWidth(true)
  brikabrokDevScroll:AddChild(headingShare)
  
  local ebShareType = AceGUI:Create("Dropdown")
  ebShareType:SetList(exportDataType)
  ebShareType:SetText("Type des données")
  ebShareType:SetLabel("Type des données")
  brikabrokDevScroll:AddChild(ebShareType)
  ebShareType:SetCallback("OnValueChanged", function(self,callback,key) keyDev28Drop = key end)
  
  ebImportS = AceGUI:Create("MultiLineEditBox")
  ebImportS:SetText("Veuillez être dans un groupe seul avec votre cible pour transférer vos données.")
  ebImportS:SetPoint("CENTER")
  ebImportS:SetLabel("Informations")
  brikabrokDevScroll:AddChild(ebImportS)
  
  local ebShare = AceGUI:Create("Button")
  ebShare:SetText("Envoyer")
  ebShare:SetWidth(200)
  ebShare:SetCallback("OnClick", function()
	local playerName = UnitName("player") 
	if UnitInParty("target") and GetNumGroupMembers() == 2 then
		if keyDev28Drop == "spells" then
			local header = playerName.."~"..keyDev28Drop
			AceComm:SendCommMessage("BKBHead", header, "PARTY", nil, "NORMAL")
			local shortString = Brikabrok:SerializeTable(Brikabrok.db.profile.spells)
			AceComm:SendCommMessage("BKBShareSpells", shortString, "PARTY", nil, "NORMAL")
		elseif keyDev28Drop == "gobs" then
			local header = playerName.."~"..keyDev28Drop
			AceComm:SendCommMessage("BKBHead", header, "PARTY", nil, "NORMAL")
			local shortString = Brikabrok:SerializeTable(Brikabrok.db.profile.gobs)
			AceComm:SendCommMessage("BKBShareGobs", shortString, "PARTY", nil, "NORMAL")
		elseif keyDev28Drop == "anims" then 
			local header = playerName.."~"..keyDev28Drop
			AceComm:SendCommMessage("BKBHead", header, "PARTY", nil, "NORMAL")
			local shortString = Brikabrok:SerializeTable(Brikabrok.db.profile.anim)
			AceComm:SendCommMessage("BKBShareAnims", shortString, "PARTY", nil, "NORMAL")
		end
		Brikabrok.formatMessage("Données envoyées avec succès, en attente d'une réponse ... ( le transfert peut être relativement long en fonction de la taille des données ):", "SUCCESS")
    Brikabrok.formatMessage("Vous avez été automatiquement placé(e) sur un nouveau profil.", "INFO")
    else
		Brikabrok.formatMessage("Veuillez sélectionner votre cible et être dans un groupe à deux!", "WARNING") 
	end
  end)
  brikabrokDevScroll:AddChild(ebShare)


  local headingImportProfile = AceGUI:Create("Heading")
  headingImportProfile:SetText("Importer d'un profil")
  headingImportProfile:SetFullWidth(true)
  brikabrokDevScroll:AddChild(headingImportProfile)
  
  local ebTypeImportProfile = AceGUI:Create("Dropdown")
  ebTypeImportProfile:SetList(exportDataType)
  ebTypeImportProfile:SetText("Type des données")
  ebTypeImportProfile:SetLabel("Type des données")
  brikabrokDevScroll:AddChild(ebTypeImportProfile)
  ebTypeImportProfile:SetCallback("OnValueChanged", function(self,callback,key) keyDev32Drop = key end)

  local tableProfiles = Brikabrok.db:GetProfiles()

  local ebProfileList = AceGUI:Create("Dropdown")
  ebProfileList:SetList(tableProfiles)
  ebProfileList:SetText("Profil")
  ebProfileList:SetLabel("Profil")
  brikabrokDevScroll:AddChild(ebProfileList)
  ebProfileList:SetCallback("OnValueChanged", function(self,callback,key) keyDev35Drop = key end)

  local bRefreshProfiles = AceGUI:Create("Button")
  bRefreshProfiles:SetText("Rafraîchir les profils")
  bRefreshProfiles:SetWidth(200)
  brikabrokDevScroll:AddChild(bRefreshProfiles)
  bRefreshProfiles:SetCallback("OnClick", function()
      local tableProfiles = Brikabrok.db:GetProfiles()
      ebProfileList:SetList(tableProfiles)
  end)

  local bImportProfile = AceGUI:Create("Button")
  bImportProfile:SetText("Récupérer")
  bImportProfile:SetWidth(200)
  bImportProfile:SetCallback("OnClick", function()
    if keyDev32Drop  == "spells" then
      local currentProfile = Brikabrok.db:GetCurrentProfile()
      Brikabrok.db:SetProfile(keyDev32Drop)
      local dataProfile = Brikabrok.db.profile.spells
      Brikabrok.db:SetProfile(currentProfile)
      Brikabrok.db.profile.spells = dataProfile
      Brikabrok.formatMessage("Données importées avec succès du profil !", "SUCCESS")
    elseif keyDev32Drop == "gobs" then
      local currentProfile = Brikabrok.db:GetCurrentProfile()
      Brikabrok.db:SetProfile(keyDev32Drop)
      local dataProfile = Brikabrok.db.profile.gobs
      Brikabrok.db:SetProfile(currentProfile)
      Brikabrok.db.profile.spells = dataProfile
      Brikabrok.formatMessage("Données importées avec succès du profil !", "SUCCESS")
    elseif keyDev32Drop == "anims" then 
      local currentProfile = Brikabrok.db:GetCurrentProfile()
      Brikabrok.db:SetProfile(keyDev32Drop)
      local dataProfile = Brikabrok.db.profile.anim
      Brikabrok.db:SetProfile(currentProfile)
      Brikabrok.db.profile.spells = dataProfile
      Brikabrok.formatMessage("Données importées avec succès du profil !", "SUCCESS")
    end
  end)
  brikabrokDevScroll:AddChild(bImportProfile)
  


end

--[[
**   SelectGroupDev
**   Callback function for OnGroupSelected
**    container: Which container hold this
**    event: ...
**    group: ...
--]]
local function SelectGroupDev(container, event, group)
    container:ReleaseChildren()
    container:SetLayout("Flow")


    local scrollDevContainer = AceGUI:Create("SimpleGroup")
    scrollDevContainer:SetRelativeWidth(1)
    scrollDevContainer:SetFullHeight(true)
    scrollDevContainer:SetLayout("Fill")
    container:AddChild(scrollDevContainer)

    brikabrokDevScroll = AceGUI:Create("ScrollFrame")
    brikabrokDevScroll:SetFullHeight(true)
    brikabrokDevScroll:SetLayout("Flow")
    scrollDevContainer:AddChild(brikabrokDevScroll)

   
   if group == "tab1" then
      Brikabrok:DrawGroupDev1(container)
   elseif group == "tab2" then
      Brikabrok:DrawGroupDev2(container)
   elseif group == "tab3" then
      Brikabrok:DrawGroupDev3(container)
   elseif group == "tab4" then
      Brikabrok:DrawGroupDev4(container)
   end
end

-- Create secondary frame 
easyDev = AceGUI:Create("Brikabrok")
easyDev:SetTitle("Brikabrok")
easyDev:SetLayout("Fill")
easyDev:SetWidth(400)
easyDev:SetHeight(520)


-- Add tabs here for the second frame
local tabDev =  AceGUI:Create("TabGroup")
tabDev:SetLayout("Flow")
tabDev:SetTabs({{text="Spells", value="tab1"},{text="Gobs", value="tab2"},{text="Anims", value="tab3"},{text="Export/Import", value="tab4"}})
tabDev:SetCallback("OnGroupSelected", SelectGroupDev)
tabDev:SelectTab("tab1")
easyDev:AddChild(tabDev)

function Brikabrok:ShowDevFrame()
  easyDev:Show()
end

end

