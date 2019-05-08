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


BrikabrokSliders = {
	{"Taille", 1, 10, ".modify scale "},
	{"Vitesse", 1, 50, ".modify speed "},
	{"Vitesse de marche", 1, 50, ".modify speed walk "},	
	{"Vitesse de vol", 1, 50, ".modify speed fly "},
	{"Vitesse de nage", 1, 50, ".modify speed swim "}
}
	
BrikabrokChecks = {
	{"Vol", [true] = ".gm fly on", [false] = ".gm fly off"},
	{"Invisible", [true] = ".invi", [false] = ".demorph"},
	{"GM", [true] = ".gm on", [false] = ".gm off"},
	{"Cast", [true] = ".cheat casttime on", [false] = ".cheat casttime off"},
	{"Cooldown", [true] = ".cheat cooldown on", [false] = ".cheat cooldown off"},
	{"Jesus", [true] = ".cheat waterwalk on", [false] = ".cheat waterwalk off"},
	{"Power", [true] = ".cheat power on", [false] = ".cheat power off"},
	{"Invincible", [true] = ".cheat god on", [false] = ".cheat god off"}
}

-----------------------------------
------------- easyFrame -----------
-----------------------------------


BrikabrokModulesDisable = {
}

BrikabrokModules = {
}

BrikabrokModulesDefault = {
}


-- to:do // update these
raceRPscale = {
    {"Dwarf", 137.16, 134.62},
    {"Draenei", 220.98, 213.36},
    {"Gnome", 91.44, 83.82},  
    {"Human", 182.88, 170.18},
    {"NightElf", 218.44, 200.66},
    {"Worgen", 190.5, 50},
    {"BloodElf", 185.42, 170.18},
    {"Goblin", 114.3, 124.46},
    {"Orc", 190.5, 182.88},
    {"Tauren", 218.44, 223.52},
    {"Troll", 193.04, 215.9},
    {"Scourge", 165.1 , 162.56},
    {"Pandaren", 213.36, 195.58},
    {"VoidElf", 185.42, 170.18},
    {"LightforgedDraenei", 220.98, 213.36},
    {"HighmountainTauren", 218.44, 223.52},
    {"Nightborne", 218.44, 200.66}
}
  
raceListDropdown = {Dwarf="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-DWARF:16|t Nain",
				 Draenei="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-DRAENEI:16|t Draenei",
				 Gnome="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-GNOME:16|t Gnome",
				 Human="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-HUMAN:16|t Humain",
				 NightElf="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-NIGHTELF:16|t Elfe de la nuit",
				 Worgen="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-WORGEN:16|t Worgen",
				 BloodElf="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-BLOODELF:16|t Elfe de sang",
				 Goblin="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-GOBLIN:16|t Gobelin",
				 Orc="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-ORC:16|t Orc",
				 Tauren="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-TAUREN:16|t Tauren",
				 Scourge="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-SCOURGE:16|t Non mort",
				 Pandaren="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-PANDAREN:16|t Pandaren",
				 VoidElf="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-VOIDELF:16|t Elfe du vide",
				 LightforgedDraenei="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-LIGHTFORGEDDRAENEI:16|t Sancteforge",
				 HighmountainTauren="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-HIGHMOUNTAINTAUREN:16|t Haut-Roc",
				 Nightborne="|TInterface\\CHARACTERFRAME\\TEMPORARYPORTRAIT-MALE-NIGHTBORNE:16|t Sacrenuit"
}