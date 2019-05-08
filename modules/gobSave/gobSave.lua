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
BrikabrokGOBSAVE = Brikabrok:NewModule("GOBSAVE", "AceHook-3.0")
local StdUi = LibStub('StdUi');

function BrikabrokGOBSAVE:OnEnable()
	Brikabrok.nearestGob = {}
	Brikabrok.temporaryGob = {}
	Brikabrok.Origin = vec3();
	-- broken need 2 calls, need some fixes
	function Brikabrok.RefreshData()
		SendChatMessage(".gps" ,"SAY")
	end


	function Brikabrok.IsInSphere(radius, vector)
		Brikabrok.RefreshData();
		Brikabrok.RefreshData();
		if  (math.pow (vector.x-Brikabrok.plyCoordX,2) + math.pow (vector.y-Brikabrok.plyCoordY,2) + math.pow (vector.z-Brikabrok.plyCoordZ,2)) < math.pow (radius, 2) then
			return true
		else
			return false
		end	
	end

	-- CHNGE CHANGE CHANGE CHANGE CHANGE
	function Brikabrok.findNearest(self,event,msg,...)
	  -- guid
	   if strfind(msg,"Entry: %d") then
	   	  local parseEntry = string.match(msg, "Entry: %d+");
	   	  local realEntry = string.gsub(parseEntry, "Entry: ", "");
		  local pRemove = string.gsub(msg, "%b()", "") -- remove brackets
		  local wRemove = string.gsub(pRemove, '%b[]', "") --remove square brackets
		  local vRemove = string.gsub(wRemove, "%p", "") --remove some shit
		  local guid = strsplit(" ",vRemove) -- get the guid nicely
		  Brikabrok.nearestGob[guid] = realEntry;
	   end
	   -- pos
	   if strfind(msg,"Orientation:") and strfind(msg,"X:") then
			local playerCoords = msg:gsub('%s+', '')
			playerCoords = playerCoords:gsub('X:', '')
			playerCoords = playerCoords:gsub('Y', '')
			playerCoords = playerCoords:gsub('Z', '')
			playerCoords = playerCoords:gsub('Orientation', '')
			Brikabrok.Origin.x,Brikabrok.Origin.y,Brikabrok.Origin.z = strsplit(":",playerCoords)
		end
	   


		local name = ""
		local coordinates = {}
		for word in string.gmatch(msg, "%S+") do
		   if tonumber(word) == nil then 
		      name = name.." "..word
		   else
		      tinsert(coordinates, word);
		   end  
		end

	   if ((name ~= nil) and (#coordinates == 4)) then
		--Brikabrok.RefreshData();
		--Brikabrok.RefreshData();
		if Brikabrok.currentId ~= nil and name:find("GroundZ") == nil and name:find("Orientation") == nil  and Brikabrok.gobBWindow ~= nil then
			local id = Brikabrok.generateID();
			local pos = vec3(coordinates[1],coordinates[2],coordinates[3]);
			local gobInfo = {};
			gobInfo["guid"] = Brikabrok.tempTableSync[1][1];
			gobInfo["entry"] = Brikabrok.tempTableSync[1][2];
			table.remove(Brikabrok.tempTableSync, 1);

			--local text = Brikabrok.gobName:GetText();
			-- to:do add check if visible
			gobInfo["name"] = name;
			gobInfo["pos"] = pos;
			gobInfo["o"] = coordinates[4];
			Brikabrok.db.profile.savedGobs[Brikabrok.currentId]["sname"] = Brikabrok.saveName:GetText()
			Brikabrok.db.profile.savedGobs[Brikabrok.currentId][id] = gobInfo;
		end	   
		end
	end

	function Brikabrok.ShowSaveFrame()
		-- Will clean code later here
		local function GetFileName(url)
		   return url:match("^.+/(.+)$")
		end

		local waitTable = {};
		local waitFrame = nil;

		local function wait(delay, func, ...)
		   if(type(delay)~="number" or type(func)~="function") then
		      return false;
		   end
		   if(waitFrame == nil) then
		      waitFrame = CreateFrame("Frame","WaitFrame", UIParent);
		      waitFrame:SetScript("onUpdate",function (self,elapse)
		            local count = #waitTable;
		            local i = 1;
		            while(i<=count) do
		               local waitRecord = tremove(waitTable,i);
		               local d = tremove(waitRecord,1);
		               local f = tremove(waitRecord,1);
		               local p = tremove(waitRecord,1);
		               if(d>elapse) then
		                  tinsert(waitTable,i,{d-elapse,f,p});
		                  i = i + 1;
		               else
		                  count = count - 1;
		                  f(unpack(p));
		               end
		            end
		      end);
		   end
		   tinsert(waitTable,{delay,func,{...}});
		   return true;
		end

		local function parseGobs()
		   Brikabrok.formatMessage("Récupération des informations ...")
		   Brikabrok.currentId = Brikabrok.generateID();
		   Brikabrok.db.profile.savedGobs[Brikabrok.currentId] = {}
		   Brikabrok.tempTableSync = {};
		   local i = 0;
		   for k,v in pairs(Brikabrok.nearestGob) do
		      i = i + 1;
		      Brikabrok.tempTableSync[i] = {k,v}
		      SendChatMessage(".addonhelper brikabrok gobpos "..k)
		   end
		end


		local function getGobsList(filter)
		   -- No filter or bad filter
		   local fullTable = {}
		   if filter == nil or filter:len() == 0 then     
		      for _, gob in pairs(Brikabrok.db.profile.savedGobs) do
		         tinsert(fullTable, { name = gob["sname"], real = gob}) 
		      end
		      return fullTable;
		   end
		   filter = filter:lower();
		   local newList = {};
		   for _, gob in pairs(Brikabrok.db.profile.savedGobs) do
		      if Brikabrok.safeMatch(gob["sname"]:lower(), filter) then
		         tinsert(newList, { name = gob["sname"], pos = gob}) 
		      end
		   end
		   return newList;
		end


		local window = StdUi:Window(UIParent, 'Brikabrok Wayback Machine', 700, 500);
		window:SetPoint('CENTER');

		local searchBox = StdUi:SearchEditBox(window, 400, 30, 'Écrivez le mot clé ici');
		searchBox:SetFontSize(16);
		searchBox:SetScript('OnEnterPressed', function()
		      local input = searchBox:GetText()
		      buildTable = getGobsList(input)
		      window.searchResults:SetData(buildTable, true);
		end);
		StdUi:GlueTop(searchBox, window, 20, -50, 'LEFT');


		local searchButton = StdUi:Button(window, 80, 30, 'Chercher');
		searchButton:SetScript("OnClick", function()
		      local input = searchBox:GetText()
		      buildTable = getGobsList(input)
		      window.searchResults:SetData(buildTable, true);
		end)
		StdUi:GlueRight(searchButton, searchBox, 5, 0);

		local fs = StdUi:FontString(window, 'Nom');
		StdUi:GlueTop(fs, window, 0, -30);
		Brikabrok.BMWL = fs;


		local addFavoritesButton = StdUi:Button(window, 30, 30, '');
		addFavoritesButton.texture = StdUi:Texture(addFavoritesButton, 17, 17, [[Interface\Common\ReputationStar]]);
		addFavoritesButton.texture:SetPoint('CENTER');
		addFavoritesButton.texture:SetBlendMode('ADD');
		addFavoritesButton.texture:SetTexCoord(0, 0.5, 0, 0.5);
		StdUi:GlueRight(addFavoritesButton, searchButton, 5, 0);

		--[[
		               if type(v) == "table" then
		                  local nP = v["pos"];
		                  local eT = v["entry"];
		                  local oR = v["o"] + math.pi;
		                  --SendChatMessage(".addonhelper brikabrok gobaddxyz "..eT.." "..nP.x.." "..nP.y.." "..nP.z.." "..oR)
		               end
		]]

		local cols = {
		   {
		      name         = 'Nom',
		      width        = 250,
		      align        = 'LEFT',
		      index        = 'name',
		      format       = 'string',
		      events         = {
		         OnClick = function(table, cellFrame, rowFrame, rowData, columnData, rowIndex)
		            local minKey = "";
		            for k,v in pairs(rowData.real) do
		               if type(v) == "table" then
		                  minKey = k
		                  break;
		               end
		            end
		            local refentialPos = rowData.real[minKey]["pos"];
		            for k,v in pairs(rowData.real) do
		               if type(v) == "table" then    
		                 
		                  local nPX = (v["pos"].x - refentialPos.x) + Brikabrok.Origin.x;
		                  local nPY = (v["pos"].y - refentialPos.y) + Brikabrok.Origin.y;
		                  local nPZ = (v["pos"].z - refentialPos.z) + Brikabrok.Origin.z;
		                  local eT = v["entry"];
		                  local oR = v["o"] + math.pi + math.rad(Brikabrok.gobOrientation:GetText());
		                  SendChatMessage(".addonhelper brikabrok gobaddxyz "..eT.." "..nPX.." "..nPY.." "..nPZ.." "..oR)
		               end
		            end
		            
		         end,
		         
		      },
		   },
		}

		window.searchResults = StdUi:ScrollTable(window, cols, 8, 40);
		window.searchResults:EnableSelection(true);
		StdUi:GlueBelow(window.searchResults, searchBox, 0, - 40, 'LEFT') ;


		local selectionButton = StdUi:Button(window, 100, 30, 'Spawn');
		selectionButton:SetScript("OnClick", function()
		end)
		StdUi:GlueBelow(selectionButton, window.searchResults, 0, -10, 'CENTER') ;

		local radius = StdUi:NumericBox(window, 150, 24, 15);
		radius:SetMaxValue(100);
		radius:SetMinValue(1);
		StdUi:GlueTop(radius, window, -180, -135, 'RIGHT');

		Brikabrok.saveName = StdUi:EditBox(window, 150, 24, "Sauvegarde X");
		StdUi:GlueBelow(Brikabrok.saveName, radius, 0, -10);


		local label = StdUi:AddLabel(window, radius, 'Rayon', 'TOP');

		local button = StdUi:Button(window, 100, 20, 'Récupérer');
		StdUi:GlueBelow(button, radius, 20, -40, 'LEFT');
		button:SetScript("OnClick", function() 
		      --Brikabrok.db.profile.savedGobs = {}
		      Brikabrok.nearestGob = {} 
		      Brikabrok.formatMessage("Récupération de la liste de gobs ...")
		      SendChatMessage(".gob near "..radius:GetText()); 
		      wait(2.5, parseGobs)   
		end)


		Brikabrok.gobOrientation = StdUi:NumericBox(window, 150, 24, 0);
		Brikabrok.gobOrientation:SetMaxValue(360);
		Brikabrok.gobOrientation:SetMinValue(0);
		StdUi:GlueBelow(Brikabrok.gobOrientation, radius, 0, -95);
		local label = StdUi:AddLabel(window, Brikabrok.gobOrientation, "Modificaton d'orientation", 'TOP');
		-- Label
		local xL = StdUi:FontString(window, 'X: ');
		StdUi:GlueTop(xL, window, -150, -135, 'RIGHT');
		local yL = StdUi:FontString(window, 'Y:');
		StdUi:GlueBelow(yL, xL, 0, -10);
		local zL = StdUi:FontString(window, 'Z:');
		StdUi:GlueBelow(zL, yL, 0, -10);

		-- Actual coordinates
		local x = StdUi:FontString(window, '0');
		StdUi:GlueRight(x, xL, 0, 0);
		local y = StdUi:FontString(window, '0');
		StdUi:GlueRight(y, yL, 0, 0);
		local z = StdUi:FontString(window, '0');
		StdUi:GlueRight(z, zL, 0, 0);

		local gps = StdUi:Button(window, 100, 20, 'GPS');
		StdUi:GlueBelow(gps, zL, 15, -10, 'LEFT');
		gps:SetScript("OnClick", function() 
		      Brikabrok.RefreshData()
		      x:SetText(Brikabrok.Origin.x)
		      y:SetText(Brikabrok.Origin.y)
		      z:SetText(Brikabrok.Origin.z)
		end)

		allSaves = getGobsList("");
		window.searchResults:SetData(allSaves, true);
	end


	function Brikabrok:commandSAVE(input)
	  Brikabrok.ShowSaveFrame()
	end


	for k, v in pairs({"EMOTE", "GUILD", "OFFICER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "SAY", "SYSTEM", "WHISPER", "WHISPER_INFORM", "YELL"}) do
	   ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, Brikabrok.findNearest)
	end

end





