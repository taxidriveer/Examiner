-- For enchant and gem IDs, check out the following link: https://fr.classic.wowhead.com/enchanting
-- Pattern entries marked with an "alert" value will cause Examiner to show a warning message,
-- { p = "Pattern", s = "Category", alert = 1 },
-- telling that the pattern is thought of as no longer in use. These patterns should eventually be deleted.
-- Modified by Grome of EU-Sulfuron for patch 1.13.2 October 13th 2019

if (GetLocale() ~= "deDE") then
	return;
end

LibGearExam.Patterns = {
	--  Base Stats  --
	{ p = "%+(%d+) Stärke", s = "STR" },
	{ p = "%+(%d+) Beweglichkeit", s = "AGI" },
	{ p = "%+(%d+) Ausdauer", s = "STA" },
	{ p = "%+(%d+) Intelligenz", s = "INT" },
	{ p = "%+(%d+) Willenskraft", s = "SPI" },
	
	{ p = "+?(%d+) Rüstung", s = "ARMOR" },

		
	--  Resistances (Exclude the Resist-"ance" then it picks up armor patches as well)  --
	{ p = "%+(%d+) Arkanwiderstand", s = "ARCANERESIST" },
	{ p = "%+(%d+) Feuerwiderstand", s = "FIRERESIST" },
	{ p = "%+(%d+) Naturwiderstand", s = "NATURERESIST" },
	{ p = "%+(%d+) Frostwiderstand", s = "FROSTRESIST" },
	{ p = "%+(%d+) Schattenwiderstand", s = "SHADOWRESIST" },
	{ p = "%+(%d+) zu allen Widerstandsarten.", s = { "ARCANERESIST", "FIRERESIST", "NATURERESIST", "FROSTRESIST", "SHADOWRESIST" } },


	--  Equip: Defense  --
	{ p = "Verteidigung %+(%d+)%.", s = "DEFENSE" },

	{ p = "Erhöht Eure Chance einem Angriff auszuweichen um (%d+)%%%.", s = "DODGE" },

	{ p = "Erhöht Eure Chance Angriffe mit einem Schild zu blocken um (%d+)%%%.", s = "BLOCK" },
	
	{ p = "Erhöht Eure Chance einen Angriff zu parieren um (%d+)%%%.", s = "PARRY" },
	
	{ p = "Erhöht den Blockwert Eures Schildes um (%d+)%.", s = "BLOCKVALUE" },
	
	{ p = "^(%d+) Blocken$", s = "BLOCKVALUE" },


	--  Equip: Melee & Ranged & Magic  --
	{ p = "Erhöht Eure Chance einen kritischen Treffer zu erzielen um (%d+)%%%.", s = { "CRIT" }},
	{ p = "Verbessert Eure Trefferchance um (%d+)%%%.", s = { "HIT" }},
	
	{ p = "Erhöht Eure Chance einen kritischen Treffer durch Zauber zu erzielen um (%d+)%%%.", s = { "SPELLCRIT" }},
	{ p = "Erhöht Eure Chance mit Zaubern zu treffen um (%d+)%%%.", s = { "SPELLHIT" }},
	
	
	-- Skill Bonuses
	{ p = "Dolche %+(%d+)%.", s = { "DAGGERSKILL" }},
	
	{ p = "Äxte %+(%d+)%.", s = { "ONEAXESKILL" }},
	{ p = "Zweihandäxte %+(%d+)%.", s = { "TWOAXESKILL" }},
	
	{ p = "Schwerter %+(%d+)%.", s = { "ONESWORDSKILL" }},
	{ p = "Zweihandschwerter %+(%d+)%.", s = { "TWOSWORDSKILL" }},	
	
	{ p = "Streitkolben %+(%d+)%.", s = { "ONEMACESKILL" }},
	{ p = "Zweihandstreitkolben %+(%d+)%.", s = { "TWOMACESKILL" }},
	
	{ p = "Bogen %+(%d+)%.", s = { "BOWSKILL" }},
	{ p = "Schusswaffen %+(%d+)%.", s = { "GUNSSKILL" }},
	{ p = "Armbrüste %+(%d+)%.", s = { "CROSSBOWSKILL" }},
	

    --  Equip: Melee & Ranged
	{ p = "%+(%d+) Angriffskraft%.", s = "AP" },
	{ p = "%+(%d+) Angriffskraft in Katzengestalt Bärengestalt oder Terrorbärengestalt%.", s = "APFERAL" },
	
	
	--  Equip: Magic --
	{ p = "Erhöht durch Zauber und magische Effekte zugefügten Schaden und Heilung um bis zu (%d+)%.", s = { "SPELLDMG", "HEAL" } },
	{ p = "Erhöht durch Zauber und Effekte verursachte Heilung um bis zu (%d+)%.", s = { "HEAL" } },

	{ p = "Erhöht durch Arkanzauber und Arkaneffekte zugefügten Schaden um bis zu (%d+)%.", s = "ARCANEDMG" },
	{ p = "Erhöht durch Feuerzauber und Feuereffekte zugefügten Schaden um bis zu (%d+)%.", s = "FIREDMG" },
	{ p = "Erhöht durch Naturzauber und Natureffekte zugefügten Schaden um bis zu (%d+)%.", s = "NATUREDMG" },
	{ p = "Erhöht durch Frostzauber und Frosteffekte zugefügten Schaden um bis zu (%d+)%.", s = "FROSTDMG" },
	{ p = "Erhöht durch Schattenzauber und Schatteneffekte zugefügten Schaden um bis zu (%d+)%.", s = "SHADOWDMG" },
	{ p = "Erhöht durch Heiligzauber und Heiligeffekte zugefügten Schaden um bis zu (%d+)%.", s = "HOLYDMG" },
	
	
	--  Health & Mana Per 5 Sec  --
	{ p = "Stellt alle 5 Sek%. (%d+) Punkt%(e%) Mana wieder her%.", s = "MP5" },

	{ p = "Stellt alle 5 Sek%. (%d+) Gesundheit wieder her%.", s = "HP5"},
	{ p = "Stellt alle 5 Sek%. (%d+) Punkt%(e%) Gesundheit wieder her%.", s = "HP5" },


	--  Enchants / Socket Bonuses / Mixed / Misc  --
	{ p = "^Beweglichkeit %+(%d+)$", s = "AGI" },
	{ p = "^Ausdauer %+(%d+)$", s = "STA" },
	{ p = "^Stärke %+(%d+)$", s = "STR" },
	{ p = "^Intelligenz %+(%d+)$", s = "INT" },
	{ p = "^Willenskraft %+(%d+)$", s = "SPI" },
	
	{ p = "^Gesundheit %+(%d+)$", s = "HP" },
	-- { p = "^HP %+(%d+)$", s = "HP" },
	
	{ p = "^Mana %+(%d+)$", s = "MP" },
	
	{ p = "^Verstärkte Rüstung %+(%d+)$", s = "ARMOR" },
	
	{ p = "^Zielfernrohr %(%+(%d+) Schaden%)$", s = "RANGEDDMG" },
	{ p = "^Waffenschaden %+(%d+)$", s = "WPNDMG" },
	
	{ p = "^Heilzauber %+(%d+)$", s = "HEAL" },
	{ p = "^%+(%d+) Zauberschaden$", s = "SPELLDMG" },

	{ p = "Alle Werte %+(%d+)", s = { "STR", "AGI", "STA", "INT", "SPI" } },

	-- { p = "%+(%d+) Arcane S?p?e?l?l? ?Damage", s = "ARCANEDMG" },
	{ p = "Feuerschaden %+(%d+)$", s = "FIREDMG" },
	-- { p = "%+(%d+) Nature S?p?e?l?l? ?Damage", s = "NATUREDMG" },
	{ p = "Frostschaden %+(%d+)$", s = "FROSTDMG" },
	{ p = "Schattenschaden %+(%d+)$", s = "SHADOWDMG" },
	-- { p = "%+(%d+) Holy S?p?e?l?l? ?Damage", s = "HOLYDMG" },
	
			-- AQ Enchants --
	-- Redundant
	-- { p = "Schattenschaden %+(%d+)", s = "SHADOWDMG" },
	-- { p = "Feuerschaden %+(%d+)", s = "FIREDMG" },
	-- { p = "Frostschaden %+(%d+)", s = "FROSTDMG" },
};