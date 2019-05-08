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


-----------------------------------
--------------- Libs --------------
-----------------------------------

Brikabrok = LibStub("AceAddon-3.0"):NewAddon("Brikabrok", "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0", "AceBucket-3.0","AceComm-3.0")
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
local AceComm = LibStub("AceComm-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceDB = LibStub("AceDB-3.0")
local aboutPanel = LibStub("LibAboutPanel", true)
local ac = LibStub("AceConfig-3.0")
local acd = LibStub("AceConfigDialog-3.0")
local StdUi = LibStub('StdUi');

-----------------------------------
----------- Variables -------------
-----------------------------------

Brikabrok.name = "Brikabrok"
Brikabrok.channel = "xtensionxtooltip2"
Brikabrok.channelname = GetChannelName(Brikabrok.channel)
Brikabrok.versionmode ="1.09"
Brikabrok.version = "Brikabrok~1.09"

local defaults = {
  profile = {
        update = {
            notification = true,
            data = true,
        },
        transfer = {
            data = true,
        },
        macro = {
            storage = "Character",
        },
		modules = {
            activated = BrikabrokModulesDefault,
        },
        dynamic_links = {
            active = true,
			color = "cffffff00",
        },
        everything = {
            autoclose = false,
            autofetch = false,
        },
        chat = {
            bubble = true,
        }
  },
}

local function UpdateConfig()
    return {
        name = "Mise à jour",
        type = "group",
        order = 1,
        args = {
            update_notification = {
                name = "Notifications",
                desc = "Permet d'activer les notifications in-game des mises à jour.",
                type = "toggle",
                order = 1,
                width = "full",
                set = function(info,val) Brikabrok.db.profile.update.notification = val end,
                get = function() return Brikabrok.db.profile.update.notification end
            },
            update_transfer = {
                name = "Envoi des mises à jour",
                desc = "Permet de communiquer avec les autres joueurs votre version de l'addon.",
                type = "toggle",
                order = 2,
                width = "full",
                set = function(info,val) Brikabrok.db.profile.update.data = val end,
                get = function() return Brikabrok.db.profile.update.data  end
            },
        }
    }
end

local macroStorage = {
    ["Account"] = "Compte",
    ["Character"] = "Personnage"
}

local function MacroConfig()
    return {
        name = "Données",
        type = "group",
        order = 1,
        args = {
            macro_transfer = {
                name = "Transfert de données",
                desc = "Permet aux joueurs de s'échanger des données en groupe.",
                type = "toggle",
                order = 1,
                width = "full",
                set = function(info,val) Brikabrok.db.profile.transfer.data = val end,
                get = function() return Brikabrok.db.profile.transfer.data end,
            },
            macro_storage = {
                name = "Sauvegarde des macros",
                desc = "Choississez où seront sauvegardées vos macros ( compte ou personnage )",
                type = "select",
                order = 2,
                values = macroStorage,
                set = function(info,val) Brikabrok.db.profile.macro.storage = val end,
                get = function() return Brikabrok.db.profile.macro.storage end
            },
        }
    }
end

local function ModulesConfig()
    return {
        name = "Modules à charger",
        type = "group",
        order = 1,
        args = {
            macro_storage = {
                name = "Modules optionnels",
                desc = "Choississez quels modules seront chargés.",
                type = "multiselect",
                order = 2,
                values = BrikabrokModules,
                set = function(_, key, value) Brikabrok.db.profile.modules.activated[key] = value  Brikabrok.formatMessage("Merci de faire un /reload pour rechargez les modules", "INFO") end,
                get = function(_, key) return Brikabrok.db.profile.modules.activated[key] end
            },
        }
    }
end

local function rgbToHex(rgb)
   local hexadecimal = 'cff'
   
   for key = 1, #rgb do
      local value = rgb[key] 
      local hex = ''
      
      while(value > 0)do
         local index = math.fmod(value, 16) + 1
         value = math.floor(value / 16)
         hex = string.sub('0123456789ABCDEF', index, index) .. hex            
      end
      
      if(string.len(hex) == 0)then
         hex = '00'
      elseif(string.len(hex) == 1)then
         hex = '0' .. hex
      end
      hexadecimal = hexadecimal .. hex
   end
   
   return hexadecimal:lower()
end

local function ColorPicker()
	StdUi:ColorPickerFrame(1, 1, 1, 1, function(colorSelect)
		  local r,g,b= colorSelect:GetColorRGBA();
		  local hex = rgbToHex({r*255,g*255,b*255});
		  Brikabrok.db.profile.dynamic_links.color = hex;
	end);
end

local function LinksConfig()
    return {
        name = "Liens dynamiques",
        type = "group",
        order = 1,
        args = {
            dynamic_links = {
                name = "Liens ( Remplacement dynamique )",
                desc = "Active des boutons cliquables dans le chat",
                type = "toggle",
                order = 1,
                width = "full",
                set = function(info,val) Brikabrok.db.profile.dynamic_links.active = val end,
                get = function() return Brikabrok.db.profile.dynamic_links.active end
            },
			color_picker = {
                name = "Couleur des liens",
                desc = "Changer la couleur des boutons dans le chat",
                type = "execute",
				func = function() ColorPicker() end,
                order = 2,
            },
			
			
        }
    }
end


local function EverythingConfig()
    return {
        name = "Divers",
        type = "group",
        order = 1,
        args = {
            frame_autoclose = {
                name = "Fermeture automatique des autres fenêtres",
                desc = "Ferme automatiquement les autres fenêtres du Brikabrok lors de l'ouverture d'une nouvelle",
                type = "toggle",
                order = 1,
                width = "full",
                set = function(info,val) Brikabrok.db.profile.everything.autoclose = val end,
                get = function() return Brikabrok.db.profile.everything.autoclose end
            },
            autofetch_id = {
                name = "Récupération automatique des IDs",
                desc = "Permet de récupérer automatiquement l'ID pour la fonctionnalité rotate quand un gob est spawn",
                type = "toggle",
                order = 1,
                width = "full",
                set = function(info,val) Brikabrok.db.profile.everything.autofetch = val end,
                get = function() return Brikabrok.db.profile.everything.autofetch end
            },
        }
    }
end

local function BubbleConfig()
    return {
        name = "Bulle de chat",
        type = "group",
        order = 1,
        args = {
            chat_bubble = {
                name = "Activer la bulle de chat",
                desc = "Affiche une bulle au dessus de votre tête lorsque vous écrivez",
                type = "toggle",
                order = 1,
                width = "full",
                set = function(info,val) Brikabrok.db.profile.chat.bubble = val end,
                get = function() return Brikabrok.db.profile.chat.bubble end
            },
        }
    }
end


-----------------------------------
-------------- Main ---------------
-----------------------------------

function Brikabrok:OnInitialize()
    -- Init DB
    self.db = LibStub("AceDB-3.0"):New("BrikabrokDB", defaults, true)
    self.profileOptions = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    -- Init modules
    self:EnableModule("libUI")
    self:EnableModule("CONFIG")
    self:EnableModule("UI")
    self:EnableModule("SECONDARY")
    self:EnableModule("MACRO")
    self:EnableModule("TRINITYLINKS")
    self:EnableModule("GOBSAVE")
    self:EnableModule("BUBBLE")
	for k,v in pairs(Brikabrok.db.profile.modules.activated) do
		if v then
			self:EnableModule(k)
        else
            self:DisableModule(k)
        end
	end
	
	for k,v in pairs(BrikabrokModulesDisable) do
		if Brikabrok.db.profile.modules.activated[k] then
			for i=1,#v do
				self:DisableModule(v[i])
			end
		end
	end

	self:EnableModule("MINIMAP")

    -- nasty loop to create base for users and AVOID overwrite existing DB
    if self.db.profile.spells == nil and self.db.profile.gobs == nil and self.db.profile.anim == nil then
        self.db.profile.spells = brikabrokSpells
        self.db.profile.gobs = brikabrokGobs
        self.db.profile.anim = brikabrokAnimKit
    -- spells
    elseif self.db.profile.spells == nil and self.db.profile.gobs == nil then
        self.db.profile.spells = brikabrokSpells
        self.db.profile.gobs = brikabrokGobs
    elseif self.db.profile.spells == nil and self.db.profile.anim  == nil then
        self.db.profile.spells = brikabrokSpells
        self.db.profile.anim = brikabrokAnimKit
    elseif self.db.profile.spells == nil and not self.db.profile.gobs == nil and not self.db.profile.anim  == nil  then 
        self.db.profile.spells = brikabrokSpells
    -- gobs
    elseif self.db.profile.gobs == nil and self.db.profile.anim  == nil then
        self.db.profile.gobs = brikabrokGobs
        self.db.profile.anim = brikabrokAnimKit
     elseif self.db.profile.gobs == nil and not self.db.profile.spells == nil and not self.db.profile.anim  == nil  then
        self.db.profile.gobs = brikabrokGobs
    --  anim
     elseif self.db.profile.anim  == nil and not self.db.profile.spells == nil and not self.db.profile.gobs  == nil  then
        self.db.profile.anim = brikabrokAnimKit
    end
    -- Register Config
    aboutPanel.new(nil, "Brikabrok")
    -- Register Options UI
    ac:RegisterOptionsTable("Brikabrok ".."Mises à jour", UpdateConfig())
    acd:AddToBlizOptions("Brikabrok ".."Mises à jour", "Mises à jour", "Brikabrok")
    ac:RegisterOptionsTable("Brikabrok ".."Macros", MacroConfig())
    acd:AddToBlizOptions("Brikabrok ".."Macros", "Macros", "Brikabrok")
    ac:RegisterOptionsTable("BrikabrokProfiles", self.profileOptions)
    acd:AddToBlizOptions("BrikabrokProfiles", "Profils", "Brikabrok")
    ac:RegisterOptionsTable("Brikabrok ".."Liens",LinksConfig())
    acd:AddToBlizOptions("Brikabrok ".."Liens", "Liens", "Brikabrok")
    ac:RegisterOptionsTable("Brikabrok ".."Divers",EverythingConfig())
    acd:AddToBlizOptions("Brikabrok ".."Divers", "Divers", "Brikabrok")
    ac:RegisterOptionsTable("Brikabrok ".."Bulle",BubbleConfig())
    acd:AddToBlizOptions("Brikabrok ".."Bulle", "Bulle", "Brikabrok")
	ac:RegisterOptionsTable("Brikabrok ".."Modules",ModulesConfig())
    acd:AddToBlizOptions("Brikabrok ".."Modules", "Modules", "Brikabrok")
    self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
    -- Register events here
    self:RegisterBucketEvent({"ADDON_LOADED"}, 1, "SendMessageChat")
    self:RegisterEvent("CHAT_MSG_CHANNEL")
    self:RegisterChatCommand("bkbdev", "ShowDevFrame")
    self:RegisterChatCommand("bkbconvert","ConvertID")
    self:RegisterChatCommand("brikabrok","ShowHelp")
    self:RegisterChatCommand("bkb","ShowHelp")
    self:RegisterChatCommand("in","commandIN")
    self:RegisterChatCommand("bkbin","commandIN")
	self:RegisterChatCommand("bkbglances","commandGlances")
	self:RegisterChatCommand("bkbviewer","CommandViewer")
    self:RegisterChatCommand("bkbsave","commandSAVE")
    C_Timer.After(5, function () Brikabrok.formatMessage("Chargé, utilisez /bkbdev pour créer vos propres listes ou cliquer sur l'îcone de la minimap.") end)
    if Brikabrok.db.profile.dynamic_links.active and IsAddOnLoaded("TrinityAdmin") then
        C_Timer.After(5.5, function () Brikabrok.formatMessage("Vous avez TrinityAdmin d'activé ainsi que l'option 'Liens', ce qui peut causer un conflit, veuillez désactiver l'un des deux.","WARNING") end)
    end
end

function Brikabrok:OnEnable()
    -- nasty loop to create base for users and AVOID overwrite existing DB
    if self.db.profile.spells == nil and self.db.profile.gobs == nil and self.db.profile.anim == nil then
        self.db.profile.spells = brikabrokSpells
        self.db.profile.gobs = brikabrokGobs
        self.db.profile.anim = brikabrokAnimKit
    -- spells
    elseif self.db.profile.spells == nil and self.db.profile.gobs == nil then
        self.db.profile.spells = brikabrokSpells
        self.db.profile.gobs = brikabrokGobs
    elseif self.db.profile.spells == nil and self.db.profile.anim  == nil then
        self.db.profile.spells = brikabrokSpells
        self.db.profile.anim = brikabrokAnimKit
    elseif self.db.profile.spells == nil and not self.db.profile.gobs == nil and not self.db.profile.anim  == nil  then 
        self.db.profile.spells = brikabrokSpells
    -- gobs
    elseif self.db.profile.gobs == nil and self.db.profile.anim  == nil then
        self.db.profile.gobs = brikabrokGobs
        self.db.profile.anim = brikabrokAnimKit
     elseif self.db.profile.gobs == nil and not self.db.profile.spells == nil and not self.db.profile.anim  == nil  then
        self.db.profile.gobs = brikabrokGobs
    --  anim
     elseif self.db.profile.anim  == nil and not self.db.profile.spells == nil and not self.db.profile.gobs  == nil  then
        self.db.profile.anim = brikabrokAnimKit
    end
    
      StaticPopupDialogs["BrikabrokInstall"] = {
      text = "[IMPORTANT] Voulez-vous recharger l'interface pour charger les données de base correctement ?",
      button1 = "Oui",
      button2 = "Non",
      OnAccept = function()
          ReloadUI()
      end,
      OnCancel = function()
        Brikabrok.formatMessage("Les données de base n'ont pas été chargées et n'apparaîtront potentiellement qu'à la prochaine reconnection.")
      end,
      timeout = 0,
      whileDead = true,
      hideOnEscape = true,
      preferredIndex = 3,
    }
    StaticPopup_Show("BrikabrokInstall")
end

function Brikabrok:RefreshConfig()
    -- nasty loop to create base for users and AVOID overwrite existing DB
    if self.db.profile.spells == nil and self.db.profile.gobs == nil and self.db.profile.anim == nil then
        self.db.profile.spells = brikabrokSpells
        self.db.profile.gobs = brikabrokGobs
        self.db.profile.anim = brikabrokAnimKit
    -- spells
    elseif self.db.profile.spells == nil and self.db.profile.gobs == nil then
        self.db.profile.spells = brikabrokSpells
        self.db.profile.gobs = brikabrokGobs
    elseif self.db.profile.spells == nil and self.db.profile.anim  == nil then
        self.db.profile.spells = brikabrokSpells
        self.db.profile.anim = brikabrokAnimKit
    elseif self.db.profile.spells == nil and not self.db.profile.gobs == nil and not self.db.profile.anim  == nil  then 
        self.db.profile.spells = brikabrokSpells
    -- gobs
    elseif self.db.profile.gobs == nil and self.db.profile.anim  == nil then
        self.db.profile.gobs = brikabrokGobs
        self.db.profile.anim = brikabrokAnimKit
     elseif self.db.profile.gobs == nil and not self.db.profile.spells == nil and not self.db.profile.anim  == nil  then
        self.db.profile.gobs = brikabrokGobs
    --  anim
     elseif self.db.profile.anim  == nil and not self.db.profile.spells == nil and not self.db.profile.gobs  == nil  then
        self.db.profile.anim = brikabrokAnimKit
    end
      StaticPopupDialogs["BrikabrokReload"] = {
      text = "Voulez-vous recharger l'interface pour changer de profil correctement?",
      button1 = "Oui",
      button2 = "Non",
      OnAccept = function()
          ReloadUI()
      end,
      OnCancel = function()
        Brikabrok.formatMessage("Vous venez de changer de profil, mais vous n'avez pas rechargé votre interface, il peut arriver que vous ne voyez pas apparaître les spells/gobs/etc ... dans l'interface de l'addon.","WARNING")
      end,
      timeout = 0,
      whileDead = true,
      hideOnEscape = true,
      preferredIndex = 3,
    }
    StaticPopup_Show("BrikabrokReload")
end


function Brikabrok:SendMessageChat()
    if Brikabrok.db.profile.update.data then
        C_Timer.After(5, function () JoinChannelByName(Brikabrok.channelname) SendChatMessage(Brikabrok.version , "CHANNEL", nil, Brikabrok.channelname) end)
    end
end


function Brikabrok:CHAT_MSG_CHANNEL(event,message,author,language,channelname,target,afk,zoneid,channelnumber,channel)
    if Brikabrok.db.profile.update.notification then
        if channel == Brikabrok.channel then
            local name,version = strsplit("~", message)
                if not antispam and tonumber(version) and tonumber(version) > tonumber(Brikabrok.versionmode) then
                    StaticPopupDialogs["BrikabrokUpdate"] = {
                        text = "Veuillez mettre l'addon Brikabrok à jour.\nVersion: "..version,
                        button1 = "Ok",
                        OnAccept = function()
                            antispam = true
                            Brikabrok.formatMessage("Les mises à jour du Brikabrok permettent de rajouter du contenu régulièrement, v."..version.." , vous pouvez télécharger celle-ci sur le topic du forum.", "INFO")
                        end,
                        timeout = 0,
                        whileDead = true
                    }
                    StaticPopup_Show("BrikabrokUpdate")
                end
        end
    end
end


