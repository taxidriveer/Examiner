-- Modified by Maxfunkey (aka Carambha of EU-Loardaeron) for patch 3.0.2 November 2nd 2008

if GetLocale() ~= "frFR" then
	return;
end

LibGearExam.Patterns = {
	--  Base Stats  --
	{ p = "%+(%d+) Force", s = "STR" },
	{ p = "%+(%d+) Agilit\195\169", s = "AGI" },
	{ p = "%+(%d+) Endurance", s = "STA" },
	-- { p = "Endurance %+(%d+)", s = "STA" }, -- WORKAROUND: Infused Amethyst (31116)
	{ p = "%+(%d+) Intelligence", s = "INT" },
	{ p = "%+(%d+) Esprit", s = "SPI" },
	{ p = "Armure \58 (%d+)", s = "ARMOR" },

	--  Resistances (Exclude the Resist-"ance" then it picks up armor patches as well)  --
	{ p = "%+(%d+) \195\160 la r\195\169sistance Arcane", s = "ARCANERESIST" },
	{ p = "%+(%d+) \195\160 la r\195\169sistance Feu", s = "FIRERESIST" },
	{ p = "%+(%d+) \195\160 la r\195\169sistance Nature", s = "NATURERESIST" },
	{ p = "%+(%d+) \195\160 la r\195\169sistance Givre", s = "FROSTRESIST" },
	{ p = "%+(%d+) \195\160 la r\195\169sistance Ombre", s = "SHADOWRESIST" },
	{ p = "%+(%d+) \195\160 toutes les r\195\169sistances", s = { "ARCANERESIST", "FIRERESIST", "NATURERESIST", "FROSTRESIST", "SHADOWRESIST" } },

	--  Equip: Other  --
	{ p = "Augmente de (%d+) le score de r\195\169silience%.", s = "RESILIENCE" },

	{ p = "D\195\169fense augment\195\169e de (%d+)%.", s = "DEFENSE" },
	
	
	{ p = "Augmente le score de d\195\169fense de (%d+)%.", s = "DEFENSE" },
	{ p = "%+(%d+) score de d\195\169fense", s = "DEFENSE" },
	{ p = "Score de d\195\169fense augment\195\169 de (%d+)%.", s = "DEFENSE" },

	{ p = "Augmente de (%d+) le score d'esquive%.", s = "DODGE" },
	{ p = "%+(%d+) score d'esquive", s = "DODGE" },
	{ p = "Augmente votre score d'esquive de (%d+)%.", s = "DODGE" },

	{ p = "Augmente de (%d+) le score de parade%.", s = "PARRY" },
	{ p = "Augmente votre score de parade de (%d+)%.", s = "PARRY" },

	{ p = "Augmente de (%d+) le score de blocage%.", s = "BLOCK" },
	{ p = "%+(%d+) score de blocage", s = "BLOCK" },
	{ p = "Augmente votre score de blocage de (%d+)%.", s = "BLOCK" },

	{ p = "Augmente la valeur de blocage de votre bouclier de (%d+)%.", s = "BLOCKVALUE" },
	{ p = "Bloquer : (%d+)", s = "BLOCKVALUE" },

	--  Equip: Melee & Ranged & Magic  --
	-- { p = "Augmente de (%d+) le score de coup critique%.", s = "CRIT", "SPELLCRIT" },
	{ p = "Augmente vos chances d'infliger un coup critique de (%d+)\37%.", s = "CRIT" },
	{ p = "Augmente vos chances d'infliger un coup critique avec vos sorts de (%d+)\37%.", s = "SPELLCRIT" },
	
	{ p = "Augmente vos chances de toucher avec des sorts de (%d+)\37%.", s = "SPELLHIT" },
	{ p = "Augmente vos chances de toucher de (%d+)\37%.", s = "HIT" },
	
	-- { p = "+(%d+) score de coup critique%.", s = "CRIT", "SPELLCRIT" },
	{ p = "Augmente de (%d+) le score de toucher%.", s = "HIT", "SPELLHIT" },
	{ p = "Augmente votre score de toucher de (%d+)%.", s = "HIT", "SPELLHIT" },
	{ p = "+(%d+) score de toucher de toucher%.", s = "HIT", "SPELLHIT" },
	{ p = "Augmente de (%d+) le score de h\195\162te%.", s = "HASTE", "SPELLHASTE" },
	{ p = "Augmente votre score de h\195\162te de (%d+)%.", s = "HASTE", "SPELLHASTE" },
	{ p = "+(%d+) score de h\195\162te%.", s = "HASTE", "SPELLHASTE" },

                   -- Equip: melee & Raged
	{ p = "Augmente de (%d+) la puissance d'attaque%.", s = "AP" },
	{ p = "+(%d+) \195\160 la puissance d'attaque%.", s = "AP" },
	{ p = "Augmente la puissance des attaques \195\169 distance de (%d+)%.", s = "RAP" },
	{ p = "+(%d+) puissance d'attaque \195\160 distance%.", s = "RAP" },
	{ p = "Augmente de (%d+) la puissance d'attaque pour les formes de f\195\169lin, d'ours, d'ours redoutable et de s\195\169l\195\169nien uniquement%.", s = "APFERAL" },


	{ p = "Augmente votre score d'expertise de (%d+)%.", s = "EXPERTISE" },
	{ p = "%+(%d+) score d'expertise", s = "EXPERTISE" },
	{ p = "Vos attaques ignorent (%d+) points de l'armure de votre adversaire%.", s = "ARMORPENETRATION" },

	--  Equip: Magic --



	{ p = "Augmente la p\195\169n\195\169tration de vos sorts de (%d+)%.", s = "SPELLPENETRATION" },

	{ p = "Augmente la puissance des sorts de (%d+)%.", s = { "HEAL", "SPELLDMG" } }, -- New 3.0 spellpower
	{ p = "Augmente les d\195\169g\195\162ts et les soins produits par les sorts et effets magiques de (%d+) au maximum%.", s = { "SPELLDMG", "HEAL" } }, -- No longer used in 3.0+ but due to some inconsistencies the formulation may have remained in some cases
	{ p = "Augmente l\195\169g\195\168rement la puissance des sorts.%.", s = { "SPELLDMG", "HEAL" }, v = 6 },

	{ p = "d\195\169g\195\162ts inflig\195\169s par les sorts et effets des Arcanes de (%d+) au maximum%.", s = "ARCANEDMG" },
	{ p = "d\195\169g\195\162ts inflig\195\169s par les sorts et effets de Feu de (%d+) au maximum%.", s = "FIREDMG" },
	{ p = "d\195\169g\195\162ts inflig\195\169s par les sorts et effets de Nature de (%d+) au maximum%.", s = "NATUREDMG" },
	{ p = "d\195\169g\195\162ts inflig\195\169s par les sorts et effets de Givre de (%d+) au maximum%.", s = "FROSTDMG" },
	{ p = "d\195\169g\195\162ts inflig\195\169s par les sorts et effets d'Ombre de (%d+) au maximum%.", s = "SHADOWDMG" },
	{ p = "d\195\169g\195\162ts inflig\195\169s par les sorts et effets du Sacr\195\169 (%d+) au maximum%.", s = "HOLYDMG" },

	--  Health & Mana Per 5 Sec  --
	{ p = "(%d+) points de mana toutes les 5 sec", s = "MP5" },
	{ p = "%+(%d+) \195\160 la r\195\169g\195\169n. de mana", s = "MP5" },
	{ p = "%+(%d+) R\195\169g\195\169n. de mana", s = "MP5" },

	{ p = "Rend (%d+) points de vie toutes les 5 sec%.", s = "HP5" },

	--  Enchants / Gems / Socket Bonuses / Mixed / Misc  --
	{ p = "^%+(%d+) PV$", s = "HP" },
	{ p = "^%+(%d+) points de vie$", s = "HP" },
	{ p = "^%+(%d+) points de mana$", s = "MP" },

	{ p = "^Vitalit\195\169$", s = { "MP5", "HP5" }, v = 4 },
	{ p = "^Sauvagerie$", s = "AP", v = 70 },
	{ p = "^Pied sûr$", s = "HIT", v = 10 },
	{ p = "^\195\162me de givre$", s = { "FROSTDMG", "SHADOWDMG" }, v = 54 },
	{ p = "^Feu solaire$", s = { "ARCANEDMG", "FIREDMG" }, v = 50 },

	{ p = "%+(%d+) \195\160 toutes les caract\195\169ristiques", s = { "STR", "AGI", "STA", "INT", "SPI" } },
	
	
	
	
	{ p = "^Points de vie %+(%d+)$", s = "HP", v = 100 },
	{ p = "^Intelligence %+(%d+)$", s = { "INT" } },
	
	
	

	{ p = "%+(%d+) au score de r\195\169silience", s = "RESILIENCE" },
	{ p = "%+(%d+) au score d'esquive", s = "DODGE" },
	{ p = "%+(%d+) au score de parade", s = "PARRY" },
	{ p = "%+(%d+) au score de d\195\169fense", s = "DEFENSE" },

	{ p = "%+(%d+) \195\160 la puissance d'attaque", s = "AP" },

	{ p = "%+(%d+) au score de coup critique|r$", s = "CRIT", "SPELLCRIT" },
	{ p = "%+(%d+) au score de coup critique et", s = "CRIT", "SPELLCRIT" },
	{ p = "%+(%d+) au score de coup critique$", s = "CRIT", "SPELLCRIT" },
	{ p = "%+(%d+) au score de critique$", s = "CRIT", "SPELLCRIT" },
	{ p = "%+(%d+) au score de toucher|r$", s = "HIT", "SPELLHIT" },
	{ p = "%+(%d+) au score de toucher$", s = "HIT", "SPELLHIT" },

	{ p = "%+(%d+) aux sorts de soins", s = "HEAL"},
	{ p = "%+(%d+) aux soins", s = "HEAL"},
	{ p = "%+(%d+) \195\160 la puissance des sorts", s = "SPELLDMG", "HEAL" },


	{ p = "%+(%d+) \195\160 la p\195\169n\195\169tration des sorts", s = "SPELLPENETRATION" },


	{ p = "%+(%d+) aux  d\195\169g\195\162ts des sorts des Arcanes", s = "ARCANEDMG" },
	{ p = "%+(%d+) aux d\195\169g\195\162ts des sorts de Feu", s = "FIREDMG" },
	{ p = "%+(%d+) aux d\195\169g\195\162ts des sorts de Nature", s = "NATUREDMG" },
	{ p = "%+(%d+) aux d\195\169g\195\162ts des sorts de Givre", s = "FROSTDMG" },
	{ p = "%+(%d+) aux d\195\169g\195\162ts des sorts d'Ombre", s = "SHADOWDMG" },
	{ p = "%+(%d+) aux d\195\169g\195\162ts des sorts du Sacr\195\169", s = "HOLYDMG" },

--[[	{ p = "%+(%d+) S?h?i?e?l?d? ?Block Rating", s = "BLOCK" }, -- Combined Pattern: Covers [Shield Enchant] [Socket Bonus]

	{ p = "%+(%d+) Block Value", s = "BLOCKVALUE" },

	{ p = "%+(%d+) Ranged Attack Power", s = "RAP" },
	{ p = "%+(%d+) Haste Rating", s = "HASTE" },
	{ p = "%+(%d+) Expertise Rating", s = "EXPERTISE" },

	{ p = "%+(%d+) Weapon Damage", s = "WPNDMG" },-]]
	{ p = "^Lunette %(%+(%d+) .* de d\195\169g\195\162ts%)$", s = "RANGEDDMG" },

	-- Demon's Blood
	{ p = "Augmente le score de d\195\169fense de 5, la r\195\169sistance \195\160 l'Ombre de 10 et votre r\195\169g\195\169n\195\169ration des points de vie normale de 3%.", s = { "DEFENSE", "SHADOWRESIST", "HP5" }, v = { 5, 10, 3 } },

	-- Void Star Talisman (Warlock T5 Class Trinket)
	{ p = "Augmente les r\195\169sistances de votre familier de 130 et votre puissance des sorts de 48 au maximum%.", s = "SPELLDMG", v = 48 },
};