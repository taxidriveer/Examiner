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
	-- this should detect rings of eluding (1% dodge and random agi)  but doesnt:
	{ p = "^(%d+)%% Dodge", s = "DODGE" },
	{ p = "Increases your chance to block attacks with a shield by (%d+)%%%.", s = "BLOCK" },
	{ p = "Increases your chance to parry an attack by (%d+)%%%.", s = "PARRY" },
	{ p = "Increases the block value of your shield by (%d+)%.", s = "BLOCKVALUE" },
	{ p = "^(%d+) Block$", s = "BLOCKVALUE" },

	--  Equip: Melee & Ranged & Magic  --
	{ p = "Improves your chance to get a critical strike by (%d+)%%%.", s = { "CRIT" }},
	{ p = "Improves your chance to hit by (%d+)%%%.", s = { "HIT" }},
	-- 3% hit scope only applies to ranged hit:
	{ p = "%+(%d+)%% Hit", s = { "HIT" }},
	-- just going to add it to overall hit because i cant get RANGEDHIT to work
	{ p = "Improves your chance to get a critical strike with spells by (%d+)%%%.", s = { "SPELLCRIT" }},
	{ p = "Improves your chance to hit with spells by (%d+)%%%.", s = { "SPELLHIT" }},

	-- Skill Bonuses
	{ p = "Increased Daggers %+(%d+)%.", s = { "DAGGERSKILL" }},
	{ p = "Increased Axes %+(%d+)%.", s = { "ONEAXESKILL" }},
	{ p = "Increased Two%-handed Axes %+(%d+)%.", s = { "TWOAXESKILL" }},
	{ p = "Increased Swords %+(%d+)%.", s = { "ONESWORDSKILL" }},
	{ p = "Increased Two%-handed Swords %+(%d+)%.", s = { "TWOSWORDSKILL" }},	
	{ p = "Increased Maces %+(%d+)%.", s = { "ONEMACESKILL" }},
	{ p = "Increased Two%-handed Maces %+(%d+)%.", s = { "TWOMACESKILL" }},
	{ p = "Increased Bows %+(%d+)%.", s = { "BOWSKILL" }},
	{ p = "Increased Guns %+(%d+)%.", s = { "GUNSSKILL" }},
	{ p = "Increased Crossbows %+(%d+)%.", s = { "CROSSBOWSKILL" }},

    --  Equip: Melee & Ranged
	{ p = "%+(%d+) Attack Power%.", s = "AP" },
	{ p = "%+(%d+) Attack Power in Cat, Bear, and Dire Bear forms only%.", s = "APFERAL" },
	{ p = "Attack Speed %+(%d+)%%", s = "HASTE" },
	{ p = "%+(%d+) ranged Attack Power%.", s = "RAP" },

	--  Equip: Magic --
	{ p = "Increases damage and healing done by magical spells and effects by up to (%d+)%.", s = { "SPELLDMG" } },
	{ p = "Increases healing done by spells and effects by up to (%d+)%.", s = { "HEAL" } },
	{ p = "%+(%d+) Healing Spells", s = { "HEAL" } },
	{ p = "Increases damage done by Arcane spells and effects by up to (%d+)%.", s = "ARCANEDMG" },
	{ p = "Increases damage done by Fire spells and effects by up to (%d+)%.", s = "FIREDMG" },
	{ p = "Increases damage done by Nature spells and effects by up to (%d+)%.", s = "NATUREDMG" },
	{ p = "Increases damage done by Frost spells and effects by up to (%d+)%.", s = "FROSTDMG" },
	{ p = "Increases damage done by Shadow spells and effects by up to (%d+)%.", s = "SHADOWDMG" },
	{ p = "Increases damage done by Holy spells and effects by up to (%d+)%.", s = "HOLYDMG" },

	--  Health & Mana Per 5 Sec  --
	{ p = "Restores (%d+) mana per 5 sec%.", s = "MP5" },
	{ p = "(%d+) mana every 5 sec%.", s = "MP5" },
	{ p = "Restores (%d+) health per 5 sec%.", s = "HP5"},
	{ p = "(%d+) health every 5 sec%.", s = "HP5" },

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
	{ p = "^Armor %+(%d+)", s = "ARMOR" },
	{ p = "^Scope %(%+(%d+) Damage%)$", s = "RANGEDDMG" },
	{ p = "Weapon Damage %+(%d+)", s = "WPNDMG" },
	{ p = "^Healing Spells %+(%d+)$", s = "HEAL" },
	{ p = "^Spell Damage %+(%d+)$", s = "SPELLDMG" },
	{ p = "All Stats %+(%d+)", s = { "STR", "AGI", "STA", "INT", "SPI" } },
	{ p = "%+(%d+) Arcane S?p?e?l?l? ?Damage", s = "ARCANEDMG" },
	{ p = "%+(%d+) Fire S?p?e?l?l? ?Damage", s = "FIREDMG" },
	{ p = "%+(%d+) Nature S?p?e?l?l? ?Damage", s = "NATUREDMG" },
	{ p = "%+(%d+) Frost S?p?e?l?l? ?Damage", s = "FROSTDMG" },
	{ p = "%+(%d+) Shadow S?p?e?l?l? ?Damage", s = "SHADOWDMG" },
	{ p = "%+(%d+) Holy S?p?e?l?l? ?Damage", s = "HOLYDMG" },

	-- ZG Enchants --
	{ p = "%+(%d+) Spell Damage and Healing", s = { "SPELLDMG" } }, -- ZG Caster Shoulder Enchant
	{ p = "Healing and Spell Damage %+(%d+)%/Spell Hit %+(%d+)", s = { "SPELLDMG", "SPELLHIT" } }, -- Mage Helm/Legs
	{ p = "Healing and Spell Damage %+(%d+)%/Stamina %+(%d+)", s = { "SPELLDMG", "STA" } }, -- Warlock Helm/Legs
	{ p = "Attack Power %+(%d+)%/Dodge %+(%d+)%%", s = { "AP", "DODGE" } }, -- Rogue Helm/Legs
	{ p = "Mana Regen %+(%d+)%/Stamina %+(%d+)%/Healing Spells %+(%d+)", s = { "MP5", "STA", "HEAL" } }, -- Priest Helm/Legs
	{ p = "Ranged Attack Power %+(%d+)%/Stamina %+(%d+)%/Hit %+(%d+)", s = { "RAP", "STA", "HIT" } }, -- Hunter Helm/Legs
	{ p = "Defense %+(%d+)%/Stamina %+(%d+)%/Block Value %+(%d+)", s = { "DEFENSE", "STA", "BLOCKVALUE" } }, -- Warrior Helm/Legs
	{ p = "Defense %+(%d+)%/Stamina %+(%d+)%/Healing Spells %+(%d+)", s = { "DEFENSE", "STA", "HEAL" } }, -- Paladin Helm/Legs
	{ p = "Intellect %+(%d+)%/Stamina %+(%d+)%/Healing Spells %+(%d+)", s = { "INT", "STA", "HEAL" } }, -- Druid Helm/Legs
	{ p = "Healing and Spell Damage %+(%d+)%/Intellect %+(%d+)", s = { "SPELLDMG", "INT" } }, -- Shaman Helm/Legs

	-- AQ Enchants --
	{ p = "Shadow Damage %+(%d+)", s = "SHADOWDMG" },
	{ p = "Fire Damage %+(%d+)", s = "FIREDMG" },
	{ p = "Frost Damage %+(%d+)", s = "FROSTDMG" },
};
