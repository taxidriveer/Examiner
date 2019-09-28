-- For enchant and gem IDs, check out the following link: https://fr.classic.wowhead.com/enchanting
-- Pattern entries marked with an "alert" value will cause Examiner to show a warning message,
-- { p = "Pattern", s = "Category", alert = 1 },
-- telling that the pattern is thought of as no longer in use. These patterns should eventually be deleted.
-- Modified by Grome of EU-Sulfuron for patch 1.13.2 September 26th 2019

if GetLocale() ~= "frFR" then
	return;
end

LibGearExam.Patterns = {
	--  Base Stats  --
	{ p = "%+(%d+) Force", s = "STR" },
	{ p = "%+(%d+) Agilité", s = "AGI" },
	{ p = "%+(%d+) Endurance", s = "STA" },
	{ p = "%+(%d+) Intelligence", s = "INT" },
	{ p = "%+(%d+) Esprit", s = "SPI" },
	
	{ p = "Armure \58 (%d+)", s = "ARMOR" },
	-- OK
		
	--  Resistances (Exclude the Resist-"ance" then it picks up armor patches as well)  --
	{ p = "%+(%d+) à la résistance Arcane", s = "ARCANERESIST" },
	{ p = "%+(%d+) à la résistance Feu", s = "FIRERESIST" },
	{ p = "%+(%d+) à la résistance Nature", s = "NATURERESIST" },
	{ p = "%+(%d+) à la résistance Givre", s = "FROSTRESIST" },
	{ p = "%+(%d+) à la résistance Ombre", s = "SHADOWRESIST" },
	{ p = "%+(%d+) à toutes les résistances", s = { "ARCANERESIST", "FIRERESIST", "NATURERESIST", "FROSTRESIST", "SHADOWRESIST" } },
	-- OK

	--  Equip: Defense  --
	{ p = "Défense augmentée de (%d+)%.", s = "DEFENSE" },

	{ p = "Augmente vos chances d'esquiver une attaque de (%d+)%%%.", s = "DODGE" },

	{ p = "Augmente vos chances de bloquer les attaques avec un bouclier de (%d+)%%%.", s = "BLOCK" },
	
	{ p = "Augmente vos chances de parer une attaque de (%d+)%%%.", s = "PARRY" },
	
	{ p = "Augmente le score de blocage de votre bouclier de (%d+)%.", s = "BLOCKVALUE" },
	
	{ p = "Bloquer : (%d+)", s = "BLOCKVALUE" },
	-- OK

	--  Equip: Melee & Ranged & Magic  --
	{ p = "Augmente vos chances d'infliger un coup critique de (%d+)%%%.", s = "CRIT" },
	{ p = "Augmente vos chances de toucher de (%d+)%%%.", s = "HIT" },
	
	{ p = "Augmente vos chances d'infliger un coup critique avec vos sorts de (%d+)\37%.", s = "SPELLCRIT" },
	{ p = "Augmente vos chances de toucher avec des sorts de (%d+)\37%.", s = "SPELLHIT" },
	-- OK

    --  Equip: Melee & Ranged
	{ p = "+(%d+) à la puissance d'attaque%.", s = "AP" },
	{ p = "Augmente de (%d+) la puissance d'attaque pour les formes de félin, d'ours, d'ours redoutable et de sélénien uniquement%.", s = "APFERAL" }, -- Still exist ?
	-- OK
	
	--  Equip: Magic --
	{ p = "Augmente les dégâts et les soins produits par les sorts et effets magiques de (%d+) au maximum%.", s = { "SPELLDMG", "HEAL" } },

	{ p = "dégâts infligés par les sorts et effets des Arcanes de (%d+) au maximum%.", s = "ARCANEDMG" },
	{ p = "dégâts infligés par les sorts et effets de Feu de (%d+) au maximum%.", s = "FIREDMG" },
	{ p = "dégâts infligés par les sorts et effets de Nature de (%d+) au maximum%.", s = "NATUREDMG" },
	{ p = "dégâts infligés par les sorts et effets de Givre de (%d+) au maximum%.", s = "FROSTDMG" },
	{ p = "dégâts infligés par les sorts et effets d'Ombre de (%d+) au maximum%.", s = "SHADOWDMG" },
	{ p = "dégâts infligés par les sorts et effets du Sacré (%d+) au maximum%.", s = "HOLYDMG" },
	-- OK
	
	--  Health & Mana Per 5 Sec  --
	{ p = "%+(%d+) à la régén. de mana", s = "MP5" },
	{ p = "%+(%d+) Régén. de mana", s = "MP5" },

	{ p = "(%d+) points de vie toutes les 5 sec%.", s = "HP5" }, -- need to investigate why "rend" doesn't work
	{ p = "(%d+) points de mana toutes les 5 sec", s = "MP5" }, -- need to investigate why "rend" doesn't work
	-- OK

	--  Enchants / Socket Bonuses / Mixed / Misc  --
	{ p = "^Agilité %+(%d+)$", s = "AGI" },
	{ p = "^Endurance %+(%d+)$", s = "STA" },
	{ p = "^Force %+(%d+)$", s = "STR" },
	{ p = "^Intelligence %+(%d+)$", s = "INT" },
	{ p = "^Esprit %+(%d+)$", s = "SPI" },
	
	{ p = "^Points de vie %+(%d+)$", s = "HP" },
	{ p = "^PV %+(%d+)$", s = "HP" },
	
	{ p = "^Mana %+(%d+)$", s = "MP" },
	
	{ p = "^Armure renforcée %+(%d+)$", s = "ARMOR" },
	
	{ p = "^Lunette %(%+(%d+) .* de dégâts%)$", s = "RANGEDDMG" },
	{ p = "^Dégâts de l'arme %+(%d+)$", s = "WPNDMG" },
	
	{ p = "^Sorts de soins %+(%d+)$", s = "HEAL" },
	{ p = "^Dégâts des sorts %+(%d+)$", s = "SPELLDMG" },

	{ p = "Toutes les caractéristiques %+(%d+)", s = { "STR", "AGI", "STA", "INT", "SPI" } },

	{ p = "%+(%d+) aux dégâts des sorts des Arcanes", s = "ARCANEDMG" },
	{ p = "%+(%d+) aux dégâts des sorts de Feu", s = "FIREDMG" },
	{ p = "%+(%d+) aux dégâts des sorts de Nature", s = "NATUREDMG" },
	{ p = "%+(%d+) aux dégâts des sorts de Givre", s = "FROSTDMG" },
	{ p = "%+(%d+) aux dégâts des sorts d'Ombre", s = "SHADOWDMG" },
	{ p = "%+(%d+) aux dégâts des sorts du Sacré", s = "HOLYDMG" },
	-- OK
};