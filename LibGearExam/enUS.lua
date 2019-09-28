-- For enchant and gem IDs, check out the following link: https://fr.classic.wowhead.com/enchanting
-- Pattern entries marked with an "alert" value will cause Examiner to show a warning message,
-- { p = "Pattern", s = "Category", alert = 1 },
-- telling that the pattern is thought of as no longer in use. These patterns should eventually be deleted.
-- Modified by Grome of EU-Sulfuron for patch 1.13.2 September 26th 2019

LibGearExam.Patterns = {
	--  Base Stats  --
	{ p = "%+(%d+) Strength", s = "STR" },
	{ p = "%+(%d+) Agility", s = "AGI" },
	{ p = "%+(%d+) Stamina", s = "STA" },
	{ p = "%+(%d+) Intellect", s = "INT" },
	{ p = "%+(%d+) Spirit", s = "SPI" },
	
	{ p = "+?(%d+) Armor", s = "ARMOR" },

		
	--  Resistances (Exclude the Resist-"ance" then it picks up armor patches as well)  --
	{ p = "%+(%d+) Arcane Resist", s = "ARCANERESIST" },
	{ p = "%+(%d+) Fire Resist", s = "FIRERESIST" },
	{ p = "%+(%d+) Nature Resist", s = "NATURERESIST" },
	{ p = "%+(%d+) Frost Resist", s = "FROSTRESIST" },
	{ p = "%+(%d+) Shadow Resist", s = "SHADOWRESIST" },
	{ p = "%+(%d+) t?o? ?All Resistances", s = { "ARCANERESIST", "FIRERESIST", "NATURERESIST", "FROSTRESIST", "SHADOWRESIST" } },


	--  Equip: Defense  --
	{ p = "Increased Defense %+(%d+)%.", s = "DEFENSE" },

	{ p = "Increases your chance to dodge an attack by (%d+)%%%.", s = "DODGE" },

	{ p = "Increases your chance to block attacks with a shield by (%d+)%%%.", s = "BLOCK" },
	
	{ p = "Increases your chance to parry an attack by (%d+)%%%.", s = "PARRY" },
	
	{ p = "Increases the block value of your shield by (%d+)%.", s = "BLOCKVALUE" },
	
	{ p = "^(%d+) Block$", s = "BLOCKVALUE" },


	--  Equip: Melee & Ranged & Magic  --
	{ p = "Improves your chance to get a critical strike by (%d+)%%%.", s = { "CRIT" }},
	{ p = "Improves your chance to hit by (%d+)%%%.", s = { "HIT" }},
	
	{ p = "Improves your chance to get a critical strike with spells by (%d+)%%%.", s = { "SPELLCRIT" }},
	{ p = "Improves your chance to hit with spells by (%d+)%%%.", s = { "SPELLHIT" }},
	-- OK

    --  Equip: Melee & Ranged
	{ p = "%+(%d+) Attack Power", s = "AP" },
	{ p = "Augmente de (%d+) la puissance d'attaque pour les formes de félin, d'ours, d'ours redoutable et de sélénien uniquement%.", s = "APFERAL" }, -- Still exist ?
	-- Feral ?
	
	--  Equip: Magic --
	{ p = "Increases damage and healing done by magical spells and effects by up to (%d+)%.", s = { "SPELLDMG", "HEAL" } },

	{ p = "Increases damage done by arcane spells and effects by up to (%d+)%.", s = "ARCANEDMG" },
	{ p = "Increases damage done by fire spells and effects by up to (%d+)%.", s = "FIREDMG" },
	{ p = "Increases damage done by nature spells and effects by up to (%d+)%.", s = "NATUREDMG" },
	{ p = "Increases damage done by Frost spells and effects by up to (%d+)%.", s = "FROSTDMG" },
	{ p = "Increases damage done by shadow spells and effects by up to (%d+)%.", s = "SHADOWDMG" },
	{ p = "Increases damage done by holy spells and effects by up to (%d+)%.", s = "HOLYDMG" },
	-- OK
	
	--  Health & Mana Per 5 Sec  --
	{ p = "Restores (%d+) mana per 5 sec%.", s = "MP5" },
	{ p = "%+(%d+) Mana Regen", s = "MP5" },

	{ p = "Restores (%d+) health per 5 sec%.", s = "HP5"},
	{ p = "(%d+) health every 5 sec%.", s = "HP5" },
	-- OK

	--  Enchants / Socket Bonuses / Mixed / Misc  --
	{ p = "^Agility %+(%d+)$", s = "AGI" },
	{ p = "^Stamina %+(%d+)$", s = "STA" },
	{ p = "^Strength %+(%d+)$", s = "STR" },
	{ p = "^Intellect %+(%d+)$", s = "INT" },
	{ p = "^Spirit %+(%d+)$", s = "SPI" },
	
	{ p = "^Health %+(%d+)$", s = "HP" },
	{ p = "^HP %+(%d+)$", s = "HP" },
	
	{ p = "^Mana %+(%d+)$", s = "MP" },
	
	{ p = "^Reinforced Armor %+(%d+)$", s = "ARMOR" },
	
	{ p = "^Scope %(%+(%d+) Damage%)$", s = "RANGEDDMG" },
	{ p = "%+(%d+)  ?Weapon Damage", s = "WPNDMG" },
	
	{ p = "^Healing Spells %+(%d+)$", s = "HEAL" },
	{ p = "^Spell Damage %+(%d+)$", s = "SPELLDMG" },

	{ p = "All Stats %+(%d+)", s = { "STR", "AGI", "STA", "INT", "SPI" } },

	{ p = "%+(%d+) Arcane S?p?e?l?l? ?Damage", s = "ARCANEDMG" },
	{ p = "%+(%d+) Fire S?p?e?l?l? ?Damage", s = "FIREDMG" },
	{ p = "%+(%d+) Nature S?p?e?l?l? ?Damage", s = "NATUREDMG" },
	{ p = "%+(%d+) Frost S?p?e?l?l? ?Damage", s = "FROSTDMG" },
	{ p = "%+(%d+) Shadow S?p?e?l?l? ?Damage", s = "SHADOWDMG" },
	{ p = "%+(%d+) Holy S?p?e?l?l? ?Damage", s = "HOLYDMG" },
	-- OK
};