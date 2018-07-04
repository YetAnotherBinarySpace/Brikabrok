--[[

        _______      ______   ______ _____ _______ _______ ______   ______  _____  _______
 |      |______      |_____] |_____/   |   |       |_____| |_____] |_____/ |     | |      
 |_____ |______      |_____] |    \_ __|__ |_____  |     | |_____] |    \_ |_____| |_____ 
                                                                                          

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
**	 Comment formater vos données
**		nom: Nom du gob
**		entryid: L'ID du Gob utilisé pour le faire spawn
**		catégorie(optionnel): La catégorie de l'objet, sera sûrement utilisé plus tard
**		icône(optionnel): Une icône que vous souhaitez mettre pour l'objet
**		type(optionnel): Doit être "categorie" si c'est une catégorie
**  Exemple : {"nom", "entryid","catégorie","icône","type"},
--]]

brikabrokGobs = {
	-- Small objets categorie / color : "cSmallObject"
	{"PETITS OBJETS", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Livre","546202","cSmallObject","Interface\\Icons\\Inv_misc_book_09"},
	{"Bandage","520512","cSmallObject","Interface\\Icons\\inv_first_aid_70_bandage"},
	{"Rondin de Bois","545046","cSmallObject"},
	{"Perfusion","520570","cSmallObject"},
	{"Robinet","550515","cSmallObject"},
	{"Petite Potion Noir","386496","cSmallObject","Interface\\Icons\\inv_potion_121"},
	{"Petite Potion Violet","520659","cSmallObject","Interface\\Icons\\Inv_misc_potionsetd"},
	{"Alchimie Dalaran","559282","cSmallObject"},
	{"Alchimie Kit","533066","cSmallObject"},
	{"Architecte Taff","547290","cSmallObject"},
	{"Table de stratégie","559903","cSmallObject","Interface\\Icons\\achievement_garrison_tier01_alliance"},
	{"Livre","547340","cSmallObject"},
	{"Livre tat","564728","cSmallObject"},
	{"Ours","514460","cSmallObject"},
	{"Sapin","206077","cSmallObject"},
	{"Aquarium","520322","cSmallObject"},
	{"Miroir","524154","cSmallObject"},
	{"Pendule","512626","cSmallObject"},
	{"Mini Bol","556891","cSmallObject"},
	{"Cage pour animaux","520425","cSmallObject"},
	{"Cage","520372","cSmallObject"},
	{"Bottle","203533","cSmallObject"},
	{"Caravane","550730","cSmallObject"},
	{"Arrosoire","536927","cSmallObject"},
	{"Rocher qui tombe","146086","cSmallObject"},
	{"Horde Ship","210061","cSmallObject"},
	{"Caillou","245490","cSmallObject"},
	{"Terre Noire","209252","cSmallObject"},
	{"Paille","509914","cSmallObject"},
	{"Cible","514463","cSmallObject"},
	-- Fire relateed objects / color : "cFire"
	{"-FEU-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Feu HD","546438","cFire"},
	{"Feu Camp Pandaren","215858","cFire"},
	{"Feu de camp avec Poel","251089","cFire"},
	{"-BOUGIE-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Bougie Orange","187573", "cFire"},
	{"Bougie Blache","180338", "cFire"},
	{"Lanterne","507943", "cFire"},
	-- Wood relateed objects / color : "cWood"
	{"-PORTE-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Porte Pandaren","213639", "cWood"},
	{"Portail Orc","186728", "cWood"},
	{"-TABLE-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Table avec Livre","547320", "cWood"},
	{"Table en Bois Vide","547317", "cWood"},
	{"Table Grand/Bureau Ecrire","552738", "cWood"},
	{"Petite Table","214015", "cWood"},
	{"Petite Table Ron de Bois","554445", "cWood"},
	{"Comtoir Beau","560384", "cWood"},
	{"Table basse","520472", "cWood"},
	{"Table Basse2 Violet","558289", "cWood"},
	{"Table Chevalier de la Mort","1490270", "cWood"},
	{"-CHAISE-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Chaise en Bois Haute","201693", "cWood"},
	{"Chaise en Bois HD Dossier Long","234639", "cWood"},
	{"Petite Chaise en Bois HD","234640", "cWood"},
	{"Fauteuil Bascule","202628", "cWood"},
	{"Ancienne Chaise","246410", "cWood"},
	{"-Armoire-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Armoire en bois","545191", "cWood"},
	{"Bibio Géante","548169", "cWood"},
	{"Biblio Parchemin","561863", "cWood"},
	{"Armoire","Livre", "cWood"},
	{"Bibliothéque en bois","514611", "cWood"},
	{"Large Bibilioteque","562896", "cWood"},
	{"Armurerie alliance bouclier up","545195", "cWood"},
	{"-COFFRE-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Coffre en Bois","545164", "cWood"},
	{"Coffre Noir","545624", "cWood"},
	{"-BARRICADE-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Sac de sable","526880","cWood"},
	{"Petite barricade en bois","565023","cWood"},
	{"Petite","mais large barricade en bois","cWood"},
	{"Harche en pierre","527489","cWood"},
	-- Carpets / color "cCarpet"
	{"-TAPIS-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Tapis Bleu Rond","562410", "cCarpet"},
	{"Long Tapis Bleu","526572", "cCarpet"},
	{"Tapis Douche","529061", "cCarpet"},
	{"Tapis Rouge","181396", "cCarpet"},
	{"Tapis Violet","564036", "cCarpet"},
	{"Couchette pour Chat/Chien","561694","cCarpet"},
	-- Medical relateed objects / color : "cMedical"
	{"-LIT-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Lit Hopital","547362", "cMedical"},
	{"Lit Worgen","524225","cMedical"},
	{"Lit 1 Place","524228","cMedical"},
	{"Sac de couchage","250877","cMedical"},
	-- Water relateed objects / color : "cWater"
	{"-BASSINE-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Bassine d'eau","522376","cWater"},
	{"Bassin d'eau","200296","cWater"},
	{"Bassin de Fel","557843","cWater"},
	{"Tonneau Marron en bois","546227","cWater"},
	{"Tonneau HD Beau","524264","cWater"},
	{"-BOITE -", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Boite Medical","515622","cMedical"},
	{"-SCEAU-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Petit sceau en bois","546147","cWater"},
	-- Building relateed objects / color : "cBuilding"
	{"-BATIMENTS-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Maison Garde","551411","cBuilding"},
	{"Tour de mage","500077","cBuilding"},
	{"Auberge","543588","cBuilding"},
	{"Magic Tower","543698","cBuilding"},
	{"Ferme Maison","543709","cBuilding"},
	{"Tente Pandaren","209654","cBuilding"},
	{"Planche Contruction","547933","cBuilding"},
	{"Pierre Contruction","552379","cBuilding"},
	{"-BARRIERE-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Elwynn","509909","cBuilding"},
	{"-GRILLE-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Grille","564339","cBuilding"},
	{"-PLANTE-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Plante peau marron","554467","cBuilding"},
	{"Rose","507991+Peaupourlesrose","cBuilding"},
	{"Bonsai!","532898","cBuilding"},
	-- Food relateed objects / color : "cFood"
	{"-Nourriture-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Plateau de nourriture","546735","cFood"},
	{"Boisson","549676","cFood"},
	{"Cochon","193056","cFood"},
	{"Table de Cuisine","556880","cFood"},
	{"Four","513206","cFood"},
	{"Poisson","21146","cFood"},
	{"Charcuterie","555762","cFood"},
	{"Raisin","549073","cFood"},
	{"Pain","546731","cFood"},
	{"Brochette","549072","cFood"},
	{"Plusieurs aliments","246433","cFood"},
	{"Grand bouteille","192824","cFood"},
	{"Tonneau Bouteille","514572","cFood"},
	-- Earth relateed objects / color : "cEarth"
	{"-DE TERRE-", "0","cSmallObjectT","Interface\\Icons\\misc_arrowdown","categorie"},
	{"Nagrand","501416","cEarth"},
	{"Barque","36812","cEarth"}
}