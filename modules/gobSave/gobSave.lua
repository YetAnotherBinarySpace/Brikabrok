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

	function Brikabrok.gobContains(element)
	  for _, value in pairs(Brikabrok.nearestGob) do
		if value == element then
		  return true
		end
	  end
	  return false
	end

	function Brikabrok.gobAdd(element)
		if(Brikabrok.gobContains(element) ~= true) then
			tinsert(Brikabrok.nearestGob, element)
		end		
	end
	-- CHNGE CHANGE CHANGE CHANGE CHANGE
	function Brikabrok.findNearest(self,event,msg,...)
	  -- guid
	   if strfind(msg,"Entry: %d") then
		  local pRemove = string.gsub(msg, "%b()", "") -- remove brackets
		  local wRemove = string.gsub(pRemove, '%b[]', "") --remove square brackets
		  local vRemove = string.gsub(wRemove, "%p", "") --remove some shit
		  local guid = strsplit(" ",vRemove) -- get the guid nicely
		  print(guid)
		  Brikabrok.gobAdd(guid)
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
	   local x,y,z,o = strsplit(" ", msg)
	   if ((tonumber(x) ~= nil) and (tonumber(y) ~= nil) and (tonumber(z) ~= nil) and (tonumber(o) ~= nil)) then
		Brikabrok.RefreshData();
		Brikabrok.RefreshData();
		if Brikabrok.currentId ~= nil then
			local id = Brikabrok.generateID();
			local pos = Brikabrok.Origin - vec3(x,y,z);
			local gobInfo = {};
			local text = Brikabrok.gobName:GetText();
			-- to:do add check if visible
			gobInfo["pos"] = pos;
			gobInfo["o"] = o;
			gobInfo["guid"] = Brikabrok.CurrentGuid;
			Brikabrok.db.profile.savedGobs[Brikabrok.currentId][id] = gobInfo;
		end	   
		end
	end

	function Brikabrok.ShowIssouFrame()
	end

	for k, v in pairs({"EMOTE", "GUILD", "OFFICER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "SAY", "SYSTEM", "WHISPER", "WHISPER_INFORM", "YELL"}) do
	   ChatFrame_AddMessageEventFilter("CHAT_MSG_"..v, Brikabrok.findNearest)
	end

end





