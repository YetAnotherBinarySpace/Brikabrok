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
BrikabrokMACRO = Brikabrok:NewModule("MACRO", "AceEvent-3.0","AceComm-3.0","AceBucket-3.0")
local AceComm = LibStub("AceComm-3.0")
local AceDB = LibStub("AceDB-3.0")
local StdUi = LibStub('StdUi');

function Brikabrok:OnEnable()
	self:RegisterComm("BKBSend")
	self:RegisterComm("BKBAccepted")
	self:RegisterComm("BKBRefused")
	self:RegisterComm("BKBReceive")
	self:RegisterComm("BKBHead")
	self:RegisterComm("BKBShareSpells")
	self:RegisterComm("BKBShareGobs")
	self:RegisterComm("BKBShareAnims")
end

function Brikabrok:OnCommReceived(prefix, message, distribution, sender)
	if Brikabrok.db.profile.transfer.data then
    if prefix == "BKBSend" then
		AceComm:SendCommMessage("BKBReceive", "", "PARTY", nil, "NORMAL")
    	local text,icon,body,player = strsplit("~", message)
        if UnitInParty(player) then
    		StaticPopupDialogs["BrikabrokMacroReceive"] = {
    		  text = player.." essaye de vous envoyer la macro suivante: "..text..", voulez-vous accepter ?",
    		  button1 = "Oui",
    		  button2 = "Non",
    		  OnAccept = function()
    		          Brikabrok:CreateMacro(text, icon, body)
                	  AceComm:SendCommMessage("BKBAccepted","", "PARTY", nil, "NORMAL")
    		  end,
    		  OnCancel = function ()
    		    	AceComm:SendCommMessage("BKBRefused", "", "PARTY", nil, "NORMAL")
    		  end,
    		  timeout = 0,
    		  whileDead = true,
    		  showAlert = true,
    		}
        else
            Brikabrok.formatMessage("La personne qui a essayé de vous envoyer une macro n'est pas dans votre groupe.", "DANGER")
        end
        StaticPopup_Show("BrikabrokMacroReceive")
	elseif prefix == "BKBAccepted" then
		Brikabrok.formatMessage("La personne à la quelle vous avez essayé d'envoyer les données a acceptée.","SUCCESS")
	elseif prefix == "BKBRefused" then
		Brikabrok.formatMessage("La personne à la quelle vous avez essayé d'envoyer les données a refusée.", "WARNING")
	elseif prefix == "BKBReceive" then
		Brikabrok.formatMessage("Données reçues ...", "WARNING")
	elseif prefix == "BKBHead" then
		Brikabrok.dataPlayer,Brikabrok.dataType = strsplit("~", message)
		if not Brikabrok.dataPlayer == sender then
			Brikabrok.formatMessage("La personne qui vous envoie les données essaye de modifier son identité !", "WARNING")
		end
	elseif prefix == "BKBShareSpells" then
		AceComm:SendCommMessage("BKBReceive", "", "PARTY", nil, "NORMAL")
		local deserializedString = Brikabrok:safeDeserialize(message)
		if UnitInParty(Brikabrok.dataPlayer) then
				  StaticPopupDialogs["BrikabrokDataReceive"] = {
				  text = Brikabrok.dataPlayer.." essaye de vous envoyer sa base de donnée de spell, voulez-vous accepter ?",
				  button1 = "Oui",
				  button2 = "Non",
				  OnAccept = function()
							  local randomName = Brikabrok.dataPlayer..random(1,999999)
							  Brikabrok.db:SetProfile(randomName)
							  Brikabrok.db.profile.spells = deserializedString
							  AceComm:SendCommMessage("BKBAccepted", "", "PARTY", nil, "NORMAL")
							  Brikabrok.formatMessage("Vous avez été automatiquement placé(e) sur un nouveau profil.", "INFO")
				  end,
				  OnCancel = function ()
						AceComm:SendCommMessage("BKBRefused", "", "PARTY", nil, "NORMAL")
				  end,
				  whileDead = true,
				  showAlert = true,
				  timeout = 0,
				}
		StaticPopup_Show("BrikabrokDataReceive")
		end
	elseif prefix == "BKBShareGobs" then
		AceComm:SendCommMessage("BKBReceive", "", "PARTY", nil, "NORMAL")
		local deserializedString = Brikabrok:safeDeserialize(message)
		if UnitInParty(Brikabrok.dataPlayer) then
				  StaticPopupDialogs["BrikabrokDataReceive"] = {
				  text = Brikabrok.dataPlayer.." essaye de vous envoyer sa base de donnée de gob, voulez-vous accepter ?",
				  button1 = "Oui",
				  button2 = "Non",
				  OnAccept = function()
							  local randomName = Brikabrok.dataPlayer..random(1,999999)
							  Brikabrok.db:SetProfile(randomName)
							  Brikabrok.db.profile.gobs = deserializedString
							  AceComm:SendCommMessage("BKBAccepted", "", "PARTY", nil, "NORMAL")
							  Brikabrok.formatMessage("Vous avez été automatiquement placé(e) sur un nouveau profil.", "INFO")
				  end,
				  OnCancel = function ()
						AceComm:SendCommMessage("BKBRefused", "", "PARTY", nil, "NORMAL")
				  end,
				  whileDead = true,
				  showAlert = true,
				  timeout = 0,
				}
		StaticPopup_Show("BrikabrokDataReceive")
		end
	elseif prefix == "BKBShareAnims" then
		AceComm:SendCommMessage("BKBReceive", "", "PARTY", nil, "NORMAL")
		local deserializedString = Brikabrok:safeDeserialize(message)
		if UnitInParty(Brikabrok.dataPlayer) then
				  StaticPopupDialogs["BrikabrokDataReceive"] = {
				  text = Brikabrok.dataPlayer.." essaye de vous envoyer sa base de donnée d'anim, voulez-vous accepter ?",
				  button1 = "Oui",
				  button2 = "Non",
				  OnAccept = function()
							  local randomName = Brikabrok.dataPlayer..random(1,999999)
							  Brikabrok.db:SetProfile(randomName)
							  Brikabrok.db.profile.anim = deserializedString
							  AceComm:SendCommMessage("BKBAccepted", "", "PARTY", nil, "NORMAL")
							  Brikabrok.formatMessage("Vous avez été automatiquement placé(e) sur un nouveau profil.", "INFO")
				  end,
				  OnCancel = function ()
						AceComm:SendCommMessage("BKBRefused", "", "PARTY", nil, "NORMAL")
				  end,
				  whileDead = true,
				  showAlert = true,
				  timeout = 0,
				}
		StaticPopup_Show("BrikabrokDataReceive")
		end
    end
end
end


function Brikabrok:GetAllUserMacros(character)
   
   local macroBase;
   local macroMax;
   local numAccountMacros, numCharacterMacros = GetNumMacros();
   local numMacros;
   local userMacros = {};
   
   if character then
      macroBase = MAX_ACCOUNT_MACROS;
      macroMax = MAX_CHARACTER_MACROS;
   else
      macroBase = 0;
      macroMax = MAX_ACCOUNT_MACROS;
   end
   
   if ( macroBase == 0 ) then
      numMacros = numAccountMacros;
   else
      numMacros = numCharacterMacros;
   end
   
   local maxMacroButtons = max(MAX_ACCOUNT_MACROS, MAX_CHARACTER_MACROS);
   for i=1, maxMacroButtons do
      if ( i <= macroMax ) then
         if ( i <= numMacros ) then
            local name, texture, body = GetMacroInfo(macroBase + i);
            if name ~= nil then
               tinsert(userMacros, { mID = macroBase + i, mName = name, mTexture = texture, mBody = body});
            end
            
         end
      end
   end
   
   return userMacros;
end


function Brikabrok:ShowIconFrame()
   local searchWindow = StdUi:Window(UIParent, 'Créer des macros', 500, 550);
   StdUi:GlueRight(searchWindow, Brikabrok.MacroWindow, 5, 0);
   Brikabrok.IconWindow = searchWindow;
   
   searchWindow:SetScript('OnHide', function()
         Brikabrok.EditMacro = false;
   end)
   
   
   local contentPanel, contentFrame, contentChild, contentBar = StdUi:ScrollFrame(searchWindow, 480, 450)
   StdUi:GlueTop(contentPanel, searchWindow, 10, -80, "LEFT")
   searchWindow.content = {
      panel = contentPanel,
      frame = contentFrame,
      child = contentChild,
      bar = contentBar,
      children = {}
   }
   
   local function createData(parent, data, row, col)
   end
   
   local function updateData(parent, item, data, row, col)
   end
   
   
   local searchBox = StdUi:SearchEditBox(searchWindow, 400, 30, 'Écrivez le mot clé ici');
   searchBox:SetFontSize(16);
   searchBox:SetScript('OnEnterPressed', function()
         
         local input = searchBox:GetText():lower();
         local buildTable = Brikabrok.getIconList(input)
         
         -- Hide previous searchs
         if widgetDataIcons ~= nil then      
            local nMath = #widgetDataIcons
            for i=1,nMath do
               for j=1,12 do  
                  if widgetDataIcons[i][j] ~= nil then              
                     widgetDataIcons[i][j]:Hide();
                     widgetDataIcons[i][j] = nil;
                  end              
               end
            end
            collectgarbage(); -- good bye heap
         end
         
         
         widgetDataIcons = {}
         
		 if (#buildTable > 5000) then
		  return 
		 end
         
         local myMath = math.ceil(#buildTable/12)
         
         
         local cIndex = 0;
         
         
         for i=1,myMath do
            widgetDataIcons[i] = {} 
            for j=1,12 do    
               cIndex = cIndex + 1;
               if(cIndex <= #buildTable) then
                  local widget = StdUi:Button(searchWindow.content.child, 32, 32, '');
                  widget:SetNormalTexture(buildTable[cIndex].iconTexture);
                  widget.selTex = buildTable[cIndex].iconTexture;
                  widget:SetScript("OnClick", function()
                        Brikabrok.IconGlobal:SetNormalTexture(widget.selTex);
                        Brikabrok.IconCur:SetNormalTexture(widget.selTex);
                        Brikabrok.IconSel = widget.selTex;
                        
                        
                  end)
                  widgetDataIcons[i][j] = widget;
               else
                  local widget = StdUi:Button(searchWindow.content.child, 32, 32, '');
                  widget:SetNormalTexture("");
                  widgetDataIcons[i][j] = widget;
               end
               
            end
         end
         
         local grid = StdUi:ObjectGrid(searchWindow.content.child, widgetDataIcons, createData, updateData, widgetDataIcons, 5, 5, 10, -30); 
   end);
   
   StdUi:GlueTop(searchBox, searchWindow, 10, -40, 'LEFT');
   
   local searchButton = StdUi:Button(searchWindow, 80, 30, 'Chercher');
   searchButton:SetScript("OnClick", function()
         local input = searchBox:GetText()
         buildTable = Brikabrok.getIconList(input) 
   end)
   StdUi:GlueRight(searchButton, searchBox, 5, 0);
   
   local cancelButton = StdUi:HighlightButton(searchWindow, 75, 20, 'Annuler');
   StdUi:GlueBelow(cancelButton, searchWindow, 0, 20, 'RIGHT');
   cancelButton:SetScript("OnClick", function()
         Brikabrok.IconWindow:Hide()
   end);
   
   
   
   
   
   local nameMacro = StdUi:SimpleEditBox(searchWindow, 150, 20, 'Nom de la macro');
   StdUi:GlueBelow(nameMacro, searchWindow, 10, 20, 'LEFT');
   nameMacro:SetScript("OnTextChanged", function()
         local input = nameMacro:GetText()
         Brikabrok.TextCur:SetText(input);
         Brikabrok.TextGlobal:SetText(input);
   end)
   Brikabrok.CreateNameMacro = nameMacro;
   
   local acceptButton = StdUi:HighlightButton(searchWindow, 75, 20, 'OK');
   StdUi:GlueLeft(acceptButton, cancelButton);
   acceptButton:SetScript("OnClick", function()
         
         local shortTexture;
         if Brikabrok.IconSel ~= nil then
            shortTexture = string.gsub(Brikabrok.IconSel, "Interface\\Icons\\", "")
            shortTexture = string.gsub(shortTexture, ".blp", "")
         end
         
         
         
         if Brikabrok.EditMacro then
            if Brikabrok.CurSelectionMacro ~= nil then
               
               local mTexture =  Brikabrok.CurSelectionMacro.macroData.mTexture;
               
               if Brikabrok.IconSel == nil then
                  Brikabrok.IconSel = mTexture;
               end
               
               
               
               
               local mID = Brikabrok.CurSelectionMacro.macroData.mID;
               local mName =  Brikabrok.CurSelectionMacro.macroData.mName;
               local mBody =  Brikabrok.CurSelectionMacro.macroData.mBody;
               Brikabrok.CurSelectionMacro.macroData.mName = nameMacro:GetText();
               Brikabrok.CurSelectionMacro.macroData.mTexture = shortTexture;

               EditMacro(mID, nameMacro:GetText(), shortTexture, mBody, 1, nil);
               Brikabrok.CurSelectionMacro:SetNormalTexture(Brikabrok.IconSel);
               Brikabrok.CurSelectionMacro:SetText(nameMacro:GetText());
            end
         else   
            
            if Brikabrok.IconSel == nil then
               Brikabrok.IconSel = "inv_misc_questionmark"
            end
            
            if Brikabrok.TabFrame.selectedTab.title == "Macros générales" then  
               local crContent = Brikabrok.MacroBodyGlobal:GetText();
               local crIcon = Brikabrok.IconSel;
               local crName = Brikabrok.TextGlobal:GetText();
               CreateMacro(crName, shortTexture , crContent, nil);
               Brikabrok.BuildGridGlobal(true);
            else
               local crContent = Brikabrok.MacroBodyCur:GetText();
               local crIcon = Brikabrok.IconSel;
               local crName = Brikabrok.TextCur:GetText();
               CreateMacro(crName, shortTexture , crContent, 1);
               Brikabrok.BuildGridCur(true);
            end     
         end
         
         
   end)
   
end


function Brikabrok:ShowMacroFrame()
   
   local t = {
      {
         name = 'firstTab',
         title = 'Macros générales',
      },
      {
         name = 'secondTab',
         title = 'Macros de Testmacro',
      },
   }
   
   
   local window = StdUi:Window(UIParent, 'Créer des macros', 400, 500);
   window:SetPoint('CENTER');
   
   
   
   window:SetScript('OnHide', function()
         if Brikabrok.CurSelectionMacro ~= nil then
            local mID = Brikabrok.CurSelectionMacro.macroData.mID;
            local mName =  Brikabrok.CurSelectionMacro.macroData.mName;
            local mTexture =  Brikabrok.CurSelectionMacro.macroData.mTexture;
            local mLastText = Brikabrok.CurSelectionMacro.macroData.mLastText;
            
            EditMacro(mID, mName, mTexture, mLastText, 1, nil); 
            
         end
   end)
   
   local tabFrame = StdUi:TabPanel(window, nil, nil, t);
   Brikabrok.TabFrame = tabFrame;
   StdUi:GlueAcross(tabFrame, window, 10, -40, -10, 20);
   
   tabFrame:EnumerateTabs(function(tab)
         local fTab = tab.frame;
         local contentPanel, contentFrame, contentChild, contentBar = StdUi:ScrollFrame(fTab, 380, 220)
         
         fTab.content = {
            panel = contentPanel,
            frame = contentFrame,
            child = contentChild,
            bar = contentBar,
            children = {}
         }
         
         StdUi:GlueTop(contentPanel, fTab, 0, 0, "LEFT")
         
         local iconButton = StdUi:Button(fTab, 40, 40, '');
         iconButton:SetNormalTexture("Interface\\Icons\\Ability_Mage_FrostJaw");
         StdUi:GlueBelow(iconButton, fTab.content.panel, 5, -20, 'LEFT');
         
         local macroName = StdUi:Label(fTab, 'Nom', 20, nil, 160);
         StdUi:GlueRight(macroName, iconButton, 10, 10);
         
         local editButton = StdUi:HighlightButton(fTab, 150, 20, 'Modifier Nom/Icône');
         StdUi:GlueBelow(editButton, macroName, -17, 0);
         editButton:SetScript('OnClick', function()  
               if Brikabrok.CurSelectionMacro ~= nil then
                  local mID = Brikabrok.CurSelectionMacro.macroData.mID;
                  local mName =  Brikabrok.CurSelectionMacro.macroData.mName;
                  local mTexture =  Brikabrok.CurSelectionMacro.macroData.mTexture;
                  Brikabrok:ShowIconFrame();
                  Brikabrok.EditMacro = true;                 
                  Brikabrok.CreateNameMacro:SetText(mName)                 
               end               
         end);
         
         
         
         local macroBody = StdUi:MultiLineBox(fTab, 360, 106, 'Contenu');
         StdUi:GlueTop(macroBody.panel, iconButton, 325, -50, 'RIGHT');
         --macroBody:SetMaxLetters(255)
         macroBody:SetScript('OnTextChanged', function()  
               if Brikabrok.CurSelectionMacro ~= nil then
                  Brikabrok.CurSelectionMacro.macroData.mLastText  = macroBody:GetText();
               end
			   
               
               if tab.title == "Macros générales" then 
                  Brikabrok.MacroLettersGlobal:SetText(Brikabrok.CurSelectionMacro.macroData.mLastText:len().."/1023 caractères")
               else
                  Brikabrok.MacroLettersCur:SetText(Brikabrok.CurSelectionMacro.macroData.mLastText:len().."/1023 caractères")
               end
               
         end)
         
         local saveButton = StdUi:HighlightButton(fTab, 75, 20, 'Sauver');
         StdUi:GlueRight(saveButton, macroName, 90, 0);
         saveButton:SetScript('OnClick', function()  
               if Brikabrok.CurSelectionMacro ~= nil then
                  local mID = Brikabrok.CurSelectionMacro.macroData.mID;
                  local mName =  Brikabrok.CurSelectionMacro.macroData.mName;
                  local mTexture =  Brikabrok.CurSelectionMacro.macroData.mTexture;
                  EditMacro(mID, mName, mTexture, macroBody:GetText(), 1, nil); 
                  
               end
               
         end);
         
         
         
         local cancelButton = StdUi:HighlightButton(fTab, 75, 20, 'Annuler');
         StdUi:GlueBelow(cancelButton, saveButton, 0, 0);
         cancelButton:SetScript('OnClick', function()  
               if Brikabrok.CurSelectionMacro ~= nil then
                  if Brikabrok.CurSelectionMacro.macroData.mBody ~= macroBody:GetText() then
                     macroBody:SetText(Brikabrok.CurSelectionMacro.macroData.mBody);
                  end
                  
                  
               end
         end);
         
         local deleteButton = StdUi:HighlightButton(fTab, 75, 20, 'Supprimer');
         StdUi:GlueBelow(deleteButton, macroBody.panel, 0, 0, 'LEFT');
         deleteButton:SetScript('OnClick', function()  
               if Brikabrok.CurSelectionMacro ~= nil then
                  DeleteMacro(Brikabrok.CurSelectionMacro.macroData.mID);
                  if tab.title == "Macros générales" then
                     Brikabrok.BuildGridGlobal(true);
                  else
                     Brikabrok.BuildGridCur(true);
                  end
                  
               end
         end);
         
         
         
         local quitButton = StdUi:HighlightButton(fTab, 75, 20, 'Quitter');
         StdUi:GlueBelow(quitButton, macroBody.panel, 0, 0, 'RIGHT');
         quitButton:SetScript('OnClick', function()  
               Brikabrok.MacroWindow:Hide();
               if Brikabrok.IconWindow ~= nil then
                  Brikabrok.IconWindow:Hide();
               end
         end);
         
         
         local newButton = StdUi:HighlightButton(fTab, 75, 20, 'Nouvelle');
         StdUi:GlueLeft(newButton, quitButton, 0, 0);
         newButton:SetScript('OnClick', function()  
               Brikabrok:ShowIconFrame();
         end);
         
         local macroLetters = StdUi:FontString(fTab, '0/255 caractères');
         StdUi:GlueRight(macroLetters, deleteButton, 5, 0);
         
         local iconsData = {}
         local widgetDataMacros = {}
         local index = 1;
         
         -- Data needed to build widget
         local macroStorage = 0;
         local maxStorage = 0;
         local curStorage = 0;
         
         local function refreshData()
            local accountM, curM = GetNumMacros();
            if tab.title == "Macros générales" then         
               macroStorage = Brikabrok:GetAllUserMacros(false);
               maxStorage = MAX_ACCOUNT_MACROS;  
               curStorage = accountM;
               
            else
               macroStorage = Brikabrok:GetAllUserMacros(true);
               maxStorage = MAX_CHARACTER_MACROS;
               curStorage = curM; 
            end
         end
         
         refreshData();
         
         local function buildGrid(refresh) 
            refreshData();
            local rowNeeded = math.ceil(maxStorage/8);
            
            
            if refresh then
               if widgetDataMacros ~= nil then      
                  local nMath = #widgetDataMacros
                  for i=1,nMath do
                     for j=1,8 do  
                        if widgetDataMacros[i][j] ~= nil then              
                           widgetDataMacros[i][j]:Hide();
                           widgetDataMacros[i][j] = nil;
                        end              
                     end
                  end        
               end 
               collectgarbage();
            end
            
            
            
            widgetDataMacros = {}
            index = 1;
            for i=1,rowNeeded do
               iconsData[i] = {} 
               widgetDataMacros[i] = {} 
               for j=1,8 do    
                  
                  -- Highlight
                  local widget = StdUi:HighlightButton(fTab.content.child, 40, 40, '');
                  local fidTexture;
                  if (index <= curStorage) then                     
                     fidTexture = macroStorage[index].mTexture   
                     widget:SetText(macroStorage[index].mName)
                     widget.macroData = macroStorage[index];
                     widget:SetScript('OnClick', function()
                           
                           
                           if Brikabrok.CurSelectionMacro ~= widget and Brikabrok.CurSelectionMacro ~= nil then
                             
                              Brikabrok.CurSelectionMacro:UnlockHighlight();
                              local mID = Brikabrok.CurSelectionMacro.macroData.mID;
                              local mName =  Brikabrok.CurSelectionMacro.macroData.mName;
                              local mTexture =  Brikabrok.CurSelectionMacro.macroData.mTexture;
                              local mLastText = Brikabrok.CurSelectionMacro.macroData.mLastText;
                              Brikabrok.CurSelectionMacro.macroData.mBody = mLastText;
                              EditMacro(mID, mName, mTexture, mLastText, 1, nil); 
                           end
                           
                           
                           Brikabrok.CurSelectionMacro = widget;
                           widget:LockHighlight()
                           
                           
                           
                           iconButton:SetNormalTexture(widget.macroData.mTexture);
                           macroName:SetText(widget.macroData.mName);
                           macroBody:SetText(widget.macroData.mBody);
                     end);
                     widget:RegisterForDrag("LeftButton");
                     widget:SetScript('OnDragStart', function()
                           
                           PickupMacro(widget.macroData.mID);
                     end);
                     index = index + 1;
                  end
                  
                  
                  if texture == nil then
                     texture = ""
                  end
                  
                  widget:SetNormalTexture(fidTexture);
                  widgetDataMacros[i][j] = widget;
                  iconsData[i][j] = texture;
               end
            end
            
            local function createData(parent, data, row, col)
            end
            
            local function updateData(parent, item, data, row, col)
            end
			
			
			if not refresh and Brikabrok.CurSelectionMacro == nil then
				Brikabrok.CurSelectionMacro = widgetDataMacros[1][1];
			end
            
            local grid = StdUi:ObjectGrid(fTab.content.child, widgetDataMacros, createData, updateData, iconsData, 5, 5, 5, -30);
            
         end
         
         buildGrid(false);
         
         
         Brikabrok.MacroWindow = window;
         -- Define globals
         if tab.title == "Macros générales" then         
            Brikabrok.TextGlobal = macroName;
            Brikabrok.IconGlobal = iconButton;
            Brikabrok.MacroBodyGlobal = macroBody;
            Brikabrok.WidgetsListGlobal = widgetDataMacros;
            Brikabrok.BuildGridGlobal = buildGrid;
            Brikabrok.MacroLettersGlobal = macroLetters;
         else           
            Brikabrok.TextCur = macroName;
            Brikabrok.IconCur = iconButton;
            Brikabrok.MacroBodyCur = macroBody;
            Brikabrok.WidgetsListCur = widgetDataMacros;
            Brikabrok.BuildGridCur = buildGrid;
            Brikabrok.MacroLettersCur = macroLetters;
         end
         
         
         
         
         
         
   end);
   
   
end