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

--[[
** Spells / Macro / Etc ..
**	 Comment formater vos données
**		icône(semi-optionnel): L'addon ira chercher une icône directement pour spells néanmoins vous être libre d'en préciser une par vous même.
**		nom: Nom du spell/macro, etc...
**		catégorie(optionnel): La catégorie du spell, sera sûrement utilisé plus tard
**		ID: L'ID du Spell/Macro/Cast ou le code de votre macro, pour mettre des retours à la ligne utiliser \n
**		type(semi-optionnel): rien si "spell" "aura" pour une aura "cast" pour un cast "casttr" pour un cast tr et "special" pour une macro extérieure et starterPack pour un starter pack ; "spellviskit" pour un spell visual.
**  Exemple : {"icône", "nom","catégorie","ID","type"},
--]]

--[[
** Starter Pack
**	Comment formater vos données
** 		id_starter_pack: Cet ID doit correspondre à celui spécifié dans les spells à l'emplacement ID ;
**		elements : Tous éléments que vous voulez mettre séparer par une virgule ; 
**      sans "" pour un spell et pour une macro ou autre entre "" ;
**		si entre "", veuillez mettre d'abord le nom de la macro/etc à gauche ( ex : Destruction ) ;
**      puis séparer le reste du contenu de la macro (ex : .cast 5825) par un ~ ;
**		ce qui donne Destruction~.cast 5825
--]]


-- Test Data
starterPack = {
	{"starterPackfire",85256,8562,52652,"Lol~25205","Risitas~issou"},
	{"starterPackpepe",3630,8562,52652,"Lol~25205","Risitas~issou"},
}


brikabrokSpells = {
	{"Interface\\Icons\\misc_arrowdown", "-Sacré-","cTitle","0", "title","categorie"},
	{"Interface\\Icons\\spell_holy_surgeoflight", "Canalisation","cHoly",".debug anim 469 \n .aura 34228","special"},
	{"Interface\\Icons\\spell_holy_surgeoflight", "Imprégnation arme","cHoly",".cast 236813 \n .aura 123276","special"},
	{"Interface\\Icons\\spell_holy_surgeoflight", "Charge sanctifiée","cHoly","176637"},
	{"Interface\\Icons\\spell_holy_heal", "Coup sacré","cHoly","204019"},
	{"Interface\\Icons\\spell_holy_heal", "Coup sacré tourbilol","cHoly","183006"},
	{"Interface\\Icons\\spell_holy_heal", "Parade sacrée","cHoly","62884"},
	{"Interface\\Icons\\spell_holy_surgeoflight", "Jugement marteau","cHoly","224704"},
	{"Interface\\Icons\\spell_holy_improvedresistanceauras", "Nova de lumière","cHoly","234408"},
	{"Interface\\Icons\\spell_holy_surgeoflight", "Pénitence","cHoly","241463"},
	{"Interface\\Icons\\spell_holy_surgeoflight", "Marteau lumière stun","cHoly","158408", "aura"},
	{"Interface\\Icons\\spell_holy_surgeoflight", "Rayon de lumière","cHoly","137494"},
	{"Interface\\Icons\\spell_holy_surgeoflight", "Rayon de lumière 2","cHoly","210616"},
	{"Interface\\Icons\\spell_holy_surgeoflight", "Bouclier petit","cHoly","172627"},
	{"Interface\\Icons\\spell_holy_surgeoflight", "Bouclier devant","cHoly"," 204150", "cast"},
	{"Interface\\Icons\\misc_arrowdown", "-Ombre-","cTitle","0", "title","categorie"},
	{nil, "Ombre de lâcheté","cShadow","79353"},
	{"Interface\\Icons\\spell_shadow_summonvoidwalker", "Forme d'Ombre","cShadow","22917"},
	{"Interface\\Icons\\spell_shadow_chilltouch", "Canalisation d'ombre","cShadow","38469"},
	{"Interface\\Icons\\spell_shadow_shadesofdarkness", "Essence sombre","cShadow","65684"},
	{"Interface\\Icons\\spell_shadow_shadetruesight", "Impulsion d'ombre","cShadow","78649"},
	{"Interface\\Icons\\spell_shadow_shadowmend", "Guérison de l'ombre","cShadow","69564"},
	{"Interface\\Icons\\inv_misc_shadowegg", "Bouclier de l'ombre","cShadow","77471"},
	{"Interface\\Icons\\inv_elemental_primal_shadow", "Tempête d’ombre","cShadow","87990"},
	{"Interface\\Icons\\spell_shadow_summonvoidwalker", "Aura ténébreuse","cShadow","73304"},
	{"Interface\\Icons\\spell_shadow_summonvoidwalker", "Aura ténébreuse - Grande","cShadow","73305"},
	{"Interface\\Icons\\misc_arrowdown", "-Eau-","cTitle","0", "title","categorie"},
	{"Interface\\Icons\\trade_engineering", "Effet de marche sous l'eau","cWater","73305"},
	{"Interface\\Icons\\inv_potion_17", "Respiration aquatique","cWater","7178"},
	{"Interface\\Icons\\spell_frost_frostnova", "Nova d'eau","cWater","38237"},
	{"Interface\\Icons\\spell_frost_frostnova", "Nova bleue","cWater","40333"},
	{"Interface\\Icons\\spell_shaman_tidalwaves", "Déferlante","cWater","57652"},
	{"Interface\\Icons\\inv_spear_04", "Bénédiction des Courcinglants","cWater","67591"},
	{"Interface\\Icons\\misc_arrowdown", "-Froid-","cTitle","0", "title","categorie"},
	{"Interface\\Icons\\spell_frost_icestorm", "Blizzard","cFrost","58693"},
	{"Interface\\Icons\\spell_frost_manarecharge", "Canalisation du givre","cFrost","75427"},
	{"Interface\\Icons\\spell_fire_fire", "Canalisation (tourbillon)","cFrost","45846"},
	{"Interface\\Icons\\spell_deathknight_iceboundfortitude", "Robustesse glaciale","cFrost","58837"},
	{"Interface\\Icons\\spell_frost_frostnova", "Grenade de givre","cFrost","39965"},
	{"Interface\\Icons\\spell_arcane_arcaneresilience", "Etat tempête de neige","cFrost","54717"},
	{"Interface\\Icons\\spell_frost_frostnova", "Souffle de givre","cFrost","73061"},
	{"Interface\\Icons\\spell_frost_frostnova", "Souffle de givre(Petit)","cFrost","16099"},
	{"Interface\\Icons\\inv_jewelcrafting_icediamond_02", "Eclats de glace","cFrost","93527"},
	{"Interface\\Icons\\trade_engineering", "Orbe gelé","cFrost","92269"},
	{"Interface\\Icons\\misc_arrowdown", "-Nature-","cTitle","0", "title","categorie"},
	{"Interface\\Icons\\trade_engineering", "Racines montantes","cNature","62923"},
	{"Interface\\Icons\\spell_nature_wispsplodegreen", "Rage de Marcherêve","cNature","71189"},
	{"Interface\\Icons\\spell_nature_elementalshields", "Vigueur d'émeraude","cNature","70873"},
	{"Interface\\Icons\\inv_misc_trailofflowers", "Sentier de Cénarius","cNature","65745"},
	{"Interface\\Icons\\trade_engineering", "Balance de la nature","cNature","74408"},
	{"Interface\\Icons\\spell_shadow_callofbone", "Nuage de spores","cNature","35005"},
	{"Interface\\Icons\\spell_nature_giftofthewaterspirit", "Puits guérisseur","cNature","88201"},
	{"Interface\\Icons\\trade_engineering", "Force de la nature","cNature","37846"},
	{"Interface\\Icons\\misc_arrowdown", "-Terre-","cTitle","0", "title","categorie"},
	{"Interface\\Icons\\spell_nature_earthquake", "Nova de pierre","cEarth","63978"},
	{"Interface\\Icons\\ability_warrior_shockwave", "Onde de choc","cEarth","87759"},
	{"Interface\\Icons\\inv_stone_15", "Ciblage d'éclat sismique","cEarth","80511"},
	{"Interface\\Icons\\spell_nature_earthquake", "Colère assourdissante","cEarth","62776"},
	{"Interface\\Icons\\misc_arrowdown", "-Électricité-","cTitle","0", "title","categorie"},
	{"Interface\\Icons\\spell_nature_lightningoverload", "Coup de tonnerre","cElectric","83067"},
	{"Interface\\Icons\\spell_nature_lightning", "Salve d'éclairs","cElectric","38839"},
	{"Interface\\Icons\\spell_nature_lightning", "Eclair","cElectric","12167"},
	{"Interface\\Icons\\spell_nature_unrelentingstorm", "Se disperser","cElectric","52770"},
	{"Interface\\Icons\\spell_nature_stormreach", "Nova de foudre","cElectric","87768"},
	{"Interface\\Icons\\trade_engineering", "Tempête d'éclair","cElectric","87685"},
	{"Interface\\Icons\\spell_lightning_lightningbolt01", "Arc électrique","cElectric","43659"},
	{"Interface\\Icons\\spell_nature_lightning", "Canalisation de la foudre","cElectric","82872"},
	{"Interface\\Icons\\spell_nature_lightning", "Canalisation de la foudre","cElectric","71043"},
	{"Interface\\Icons\\spell_nature_lightning", "Canalisation de la foudre","cElectric","74742"},
	{"Interface\\Icons\\spell_nature_lightning", "Canalisation de la foudre","cElectric","69149"},
	{"Interface\\Icons\\spell_nature_lightningoverload", "Suprématie de l'orage","cElectric","86715"},
	{"Interface\\Icons\\spell_shaman_thunderstorm", "Tourmentin","cElectric","87906"},
	{"Interface\\Icons\\spell_nature_lightningoverload", "Foudre en boule","cElectric","56319"},
	{"Interface\\Icons\\spell_nature_astralrecalgroup", "Frénésie d'étincelles","cElectric","56322"},	
}
