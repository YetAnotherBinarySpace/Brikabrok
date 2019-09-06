--[[
        _______      ______   ______ _____ _     _ _______ ______   ______  _____  _     _
 |      |______      |_____] |_____/   |   |____/  |_____| |_____] |_____/ |     | |____/ 
 |_____ |______      |_____] |    \_ __|__ |    \_ |     | |_____] |    \_ |_____| |    \_
                                                                                          
    MIT License
    Copyright (c) 2019 BinarySpace
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
local StdUi = LibStub('StdUi');

   local itemCategories = {
      
      {value="INVTYPE_AMMO", text='Ammo'},
      {value="INVTYPE_HEAD", text='Head'},
      {value="INVTYPE_NECK", text='Neck'},
      {value="INVTYPE_SHOULDER", text='Shoulder'},
      {value="INVTYPE_BODY", text='Shirt'},
      {value="INVTYPE_CHEST", text='Chest'},
      {value="INVTYPE_ROBE", text='Chest'},
      {value="INVTYPE_WAIST", text='Waist'},
      {value="INVTYPE_LEGS", text='Legs'},
      {value="INVTYPE_FEET", text='Feet'},
      {value="INVTYPE_WRIST", text='Wrist'},
      {value="INVTYPE_HAND", text='Hands'},
      {value="INVTYPE_FINGER", text='Fingers'},
      {value="INVTYPE_TRINKET", text='Trinket'},
      {value="INVTYPE_CLOAK", text='Cloaks'},
      {value="INVTYPE_WEAPON", text='One-Hand'},
      {value="INVTYPE_SHIELD", text='Shield'},
      {value="INVTYPE_2HWEAPON", text='Two-Handed'},
      {value="INVTYPE_WEAPONMAINHAND", text='Main-Hand Weapon'},
      {value="INVTYPE_WEAPONOFFHAND", text='Off-Hand Weapon'},
      {value="INVTYPE_HOLDABLE", text='Held In Off-Hand'},
      {value="INVTYPE_RANGED", text='Bows'},
      {value="INVTYPE_THROWN", text='Ranged'},
      {value="INVTYPE_RANGEDRIGHT", text='Wands, Guns, and Crossbows'},
      {value="INVTYPE_RELIC", text='Relics'},
      {value="INVTYPE_TABARD", text='Tabard'},
      {value="INVTYPE_BAG", text='Containers'},
      {value="INVTYPE_QUIVER", text='Quivers'},
   };


function Brikabrok.getPatchItemsList(filter, category)
   filter = filter:lower();
   local newList = {};
   
   for _, patchItem in pairs(titanForgedPatchData) do
      local itemName = patchItem[1];
      local itemDisplayID = patchItem[2];
      local iName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemDisplayID);
      
      if category ~= nil then
         if Brikabrok.safeMatch(itemName:lower(), filter) and itemEquipLoc == category then
            
            if Brikabrok.safeMatch(itemName:lower(), filter) then
               tinsert(newList, { name = itemName, displayID = itemDisplayID, location});
            end
         end       
      else         
         if Brikabrok.safeMatch(itemName:lower(), filter) then
            tinsert(newList, { name = itemName, displayID = itemDisplayID, location});
         end       
      end    
   end
   
   return newList;
end


function Brikabrok.ShowPatchBrowserFrame()


   Brikabrok.itemPatchWindow = StdUi:Window(UIParent, 'Brikabrok Patch Viewer', 715, 500);
   Brikabrok.itemPatchWindow:SetPoint('CENTER');



   Brikabrok.BMWS = 1;

   local searchBox = StdUi:SearchEditBox(Brikabrok.itemPatchWindow, 400, 30, 'Écrivez le mot clé ici');
   searchBox:SetFontSize(16);
   searchBox:SetScript('OnEnterPressed', function()
         local input = searchBox:GetText()
         buildTable = Brikabrok.getPatchItemsList(input, nil)
         Brikabrok.itemPatchWindow.searchResults:SetData(buildTable, true);
   end);
   StdUi:GlueTop(searchBox, Brikabrok.itemPatchWindow, 20, -50, 'LEFT');


   local searchButton = StdUi:Button(Brikabrok.itemPatchWindow, 80, 30, 'Chercher');
   searchButton:SetScript("OnClick", function()
         local input = searchBox:GetText()
         buildTable = Brikabrok.getPatchItemsList(input, nil)
         Brikabrok.itemPatchWindow.searchResults:SetData(buildTable, true);
   end)
   StdUi:GlueRight(searchButton, searchBox, 5, 0);

   local lookButton = StdUi:Button(Brikabrok.itemPatchWindow, 80, 30, '.add');
   lookButton:SetScript("OnClick", function()
         if Brikabrok.BMWL:GetText() ~= "Nom" then
            local nameGob = Brikabrok.BMWL:GetText();
            SendChatMessage(".add "..nameGob);
         end     
   end)
   StdUi:GlueRight(lookButton, searchButton, 40, 0);

   local resetButton = StdUi:Button(Brikabrok.itemPatchWindow, 80, 30, 'Reset');
   resetButton:SetScript("OnClick", function()
         Brikabrok.BMWP:Undress();
   end)
   StdUi:GlueRight(resetButton, lookButton, 5, 0);

   local itemCategory = StdUi:Dropdown(Brikabrok.itemPatchWindow, 140, 20, itemCategories);
   itemCategory:SetPlaceholder('-- Catégorie d\'items --');
   StdUi:GlueBelow(itemCategory, resetButton, -40, -10);
   itemCategory.OnValueChanged = function(self, value)
      local input = searchBox:GetText()
      buildTable = Brikabrok.getPatchItemsList(input, value)
      Brikabrok.itemPatchWindow.searchResults:SetData(buildTable, true);
   end;


   local fs = StdUi:FontString(Brikabrok.itemPatchWindow, 'Nom');
   StdUi:GlueTop(fs, Brikabrok.itemPatchWindow, 0, -30);
   Brikabrok.BMWL = fs;

   local addFavoritesButton = StdUi:Button(Brikabrok.itemPatchWindow, 30, 30, '');
   addFavoritesButton.texture = StdUi:Texture(addFavoritesButton, 17, 17, [[Interface\Common\ReputationStar]]);
   addFavoritesButton.texture:SetPoint('CENTER');
   addFavoritesButton.texture:SetBlendMode('ADD');
   addFavoritesButton.texture:SetTexCoord(0, 0.5, 0, 0.5);
   StdUi:GlueRight(addFavoritesButton, searchButton, 5, 0);


   local cols = {
      {
         name         = 'Nom',
         width        = 250,
         align        = 'LEFT',
         index        = 'name',
         format       = 'string',
         events         = {
            OnClick = function(table, cellFrame, rowFrame, rowData, columnData, rowIndex)
               Brikabrok.BMWP:TryOn(rowData.displayID);
               Brikabrok.BMWL:SetText(rowData.displayID);
            end,
            
         },
      },
   }

   Brikabrok.itemPatchWindow.searchResults = StdUi:ScrollTable(Brikabrok.itemPatchWindow, cols, 8, 40);
   Brikabrok.itemPatchWindow.searchResults:EnableSelection(true);
   StdUi:GlueBelow(Brikabrok.itemPatchWindow.searchResults, searchBox, 0, - 40, 'LEFT') ;


   local selectionButton = StdUi:Button(Brikabrok.itemPatchWindow, 100, 30, 'Apprendre');
   selectionButton:SetScript("OnClick", function()
   end)

   local previewModel = CreateFrame("DressUpModel", nil, Brikabrok.itemPatchWindow, "ModelWithZoomTemplate")
   previewModel:SetUnit("player");
   previewModel:Undress();

   previewModel:SetPoint("TOP", searchButton, "TOP",-55,-55)
   previewModel:SetPoint("BOTTOM", Brikabrok.itemPatchWindow, "BOTTOM")
   previewModel:SetPoint("LEFT", Brikabrok.itemPatchWindow.searchResults, "LEFT");
   previewModel:SetPoint("RIGHT", Brikabrok.itemPatchWindow, "RIGHT");
   StdUi:GlueRight(previewModel, Brikabrok.itemPatchWindow.searchResults, 5, 0);
   previewModel:SetPortraitZoom(0)
   Brikabrok.BMWP = previewModel;
   previewModel:SetScript('OnMouseWheel', function(self, value)
         if value == 1 then -- scrolling up
            if Brikabrok.BMWS > 2  then
               Brikabrok.BMWS = Brikabrok.BMWS - 1;
               Brikabrok.BMWP:SetCamDistanceScale(Brikabrok.BMWS)
            else
               Brikabrok.BMWS = Brikabrok.BMWS - 0.1;
               if Brikabrok.BMWS > 0 then
                  Brikabrok.BMWP:SetCamDistanceScale(Brikabrok.BMWS)
               end
            end
         else -- scrolling down
            Brikabrok.BMWS = Brikabrok.BMWS + 1;
            Brikabrok.BMWP:SetCamDistanceScale(Brikabrok.BMWS)
         end
   end);
end