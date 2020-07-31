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
local StdUi = LibStub('StdUi');


	local function GetFileName(url)
	   return url:match("^.+/(.+)$")
	end

	--function Brikabrok.ShowGobBrowserFrame()
	--end


	function Brikabrok.getGobsList(filter)
	   -- No filter or bad filter
	   if filter == nil or filter:len() == 0 then
		  return cleanTable;
	   end
	   filter = filter:lower();
	   local newList = {};
	   for iFileData, gob in pairs(BrikabrokGobList) do
	      if string.match(gob:lower(), filter) then
	      	tinsert(newList, { name = GetFileName(gob), real = gob, fileData = iFileData});
	      end
	   end
	   return newList;
	end
	Brikabrok.BMWS = 1;
	
	function Brikabrok.ShowGobBrowserFrame()
		Brikabrok.gobBWindow = StdUi:Window(UIParent, 'Brikabrok Model Viewer', 700, 500);
		Brikabrok.gobBWindow:SetPoint('CENTER');

		local searchBox = StdUi:SearchEditBox(Brikabrok.gobBWindow, 400, 30, 'Écrivez le mot clé ici');
		searchBox:SetFontSize(16);
		searchBox:SetScript('OnEnterPressed', function()
			  local input = searchBox:GetText()
			  buildTable = Brikabrok.getGobsList(input)
			  Brikabrok.gobBWindow.searchResults:SetData(buildTable, true);
		end);
		StdUi:GlueTop(searchBox, Brikabrok.gobBWindow, 20, -50, 'LEFT');


		local searchButton = StdUi:Button(Brikabrok.gobBWindow, 80, 30, 'Chercher');
		searchButton:SetScript("OnClick", function()
			  local input = searchBox:GetText()
			  buildTable = Brikabrok.getGobsList(input)
			  Brikabrok.gobBWindow.searchResults:SetData(buildTable, true);
		end)
		StdUi:GlueRight(searchButton, searchBox, 5, 0);
		
		local lookButton = StdUi:Button(Brikabrok.gobBWindow, 80, 30, '.lo ob');
		lookButton:SetScript("OnClick", function()
			if Brikabrok.BMWL:GetText() ~= "Nom" then
			 local nameGob = GetFileName(Brikabrok.BMWL:GetText());
			 SendChatMessage(".lo ob "..nameGob);
			end     
		end)
		StdUi:GlueRight(lookButton, searchButton, 40, 0);


		local fs = StdUi:FontString(Brikabrok.gobBWindow, 'Nom');
		StdUi:GlueTop(fs, Brikabrok.gobBWindow, 0, -30);
		Brikabrok.BMWL = fs;


		local addFavoritesButton = StdUi:Button(Brikabrok.gobBWindow, 30, 30, '');
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
					Brikabrok.BMW:SetModel(rowData.fileData);
					Brikabrok.BMWL:SetText(rowData.real);
				 end,
				 
			  },
		   },
		}

		Brikabrok.gobBWindow.searchResults = StdUi:ScrollTable(Brikabrok.gobBWindow, cols, 8, 40);
		Brikabrok.gobBWindow.searchResults:EnableSelection(true);
		StdUi:GlueBelow(Brikabrok.gobBWindow.searchResults, searchBox, 0, - 40, 'LEFT') ;


		local selectionButton = StdUi:Button(Brikabrok.gobBWindow, 100, 30, 'Apprendre');
		selectionButton:SetScript("OnClick", function()
		end)

		local previewModel = CreateFrame("DressUpModel", nil, Brikabrok.gobBWindow, "ModelWithZoomTemplate")
		previewModel:SetModel("Interface\\Buttons\\talktomequestionmark.m2")

		previewModel:SetPoint("TOP", searchButton, "TOP",-55,-55)
		previewModel:SetPoint("BOTTOM", Brikabrok.gobBWindow, "BOTTOM")
		previewModel:SetPoint("LEFT", Brikabrok.gobBWindow.searchResults, "LEFT");
		previewModel:SetPoint("RIGHT", Brikabrok.gobBWindow, "RIGHT");
		StdUi:GlueRight(previewModel, Brikabrok.gobBWindow.searchResults, 5, 0);
		previewModel:SetPortraitZoom(0)
		Brikabrok.BMW = previewModel;
		previewModel:SetScript('OnMouseWheel', function(self, value)
			  if value == 1 then -- scrolling up
				 if Brikabrok.BMWS > 2  then
					Brikabrok.BMWS = Brikabrok.BMWS - 1;
					Brikabrok.BMW:SetCamDistanceScale(Brikabrok.BMWS)
				 else
					Brikabrok.BMWS = Brikabrok.BMWS - 0.1;
					if Brikabrok.BMWS > 0 then
					   Brikabrok.BMW:SetCamDistanceScale(Brikabrok.BMWS)
					end
				 end
			  else -- scrolling down
				 Brikabrok.BMWS = Brikabrok.BMWS + 1;
				 Brikabrok.BMW:SetCamDistanceScale(Brikabrok.BMWS)
			  end
		end);
	end






