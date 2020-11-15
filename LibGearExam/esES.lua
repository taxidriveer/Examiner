-- For enchant and gem IDs, check out the following link: https://fr.classic.wowhead.com/enchanting
-- Pattern entries marked with an "alert" value will cause Examiner to show a warning message,
-- { p = "Pattern", s = "Category", alert = 1 },
-- telling that the pattern is thought of as no longer in use. These patterns should eventually be deleted.
-- Modified by Grome of EU-Sulfuron for patch 1.13.2 October 13th 2019

if GetLocale() ~= "esES" then
	return;
end

LibGearExam.Patterns = {
	--  Base Stats  --
	{ p = "%+(%d+) fuerza", s = "STR" },
	{ p = "%+(%d+) agilidad", s = "AGI" },
	{ p = "%+(%d+) aguante", s = "STA" },
	{ p = "%+(%d+) intelecto", s = "INT" },
	{ p = "%+(%d+) espíritu", s = "SPI" },
	
	{ p = "+?(%d+) armadura", s = "ARMOR" },

		
	--  Resistances (Exclude the Resist-"ance" then it picks up armor patches as well)  --
	{ p = "%+(%d+) Arcano Resistencia", s = "ARCANERESIST" },
	{ p = "%+(%d+) Fuego Resistencia", s = "FIRERESIST" },
	{ p = "%+(%d+) Naturaleza Resistencia", s = "NATURERESIST" },
	{ p = "%+(%d+) Escarcha Resistencia", s = "FROSTRESIST" },
	{ p = "%+(%d+) Sombras Resistencia", s = "SHADOWRESIST" },
	{ p = "%+(%d+) p%. de todas las resistencias.", s = { "ARCANERESIST", "FIRERESIST", "NATURERESIST", "FROSTRESIST", "SHADOWRESIST" } },


	--  Equip: Defense  --
	{ p = "Defensa aumentada %+(%d+)%.", s = "DEFENSE" },

	{ p = "Aumenta la probabilidad de esquivar un ataque en un (%d+)%%%.", s = "DODGE" },

	{ p = "Aumenta la probabilidad de bloquear ataques con un escudo en un (%d+)%%%.", s = "BLOCK" },
	
	{ p = "Aumenta la probabilidad de parar un ataque en un (%d+)%%%.", s = "PARRY" },
	
	{ p = "Aumenta el valor de bloqueo de tu escudo en (%d+) p%.", s = "BLOCKVALUE" },
	
	{ p = "^(%d+) bloquear$", s = "BLOCKVALUE" },


	--  Equip: Melee & Ranged & Magic  --
	{ p = "Mejora tu probabilidad de conseguir un golpe crítico en (%d+)%%%.", s = { "CRIT" }},
	{ p = "Mejora tu probabilidad de alcanzar el objetivo en un (%d+)%%%.", s = { "HIT" }},

	{ p = "Mejora tu probabilidad de conseguir un golpe crítico en (%d+)%% con los hechizos%.", s = { "SPELLCRIT" }},
	{ p = "Mejora tu probabilidad de alcanzar el objetivo con hechizos en un (%d+)%%%.", s = { "SPELLHIT" }},
	
	
	-- Skill Bonuses
	{ p = "Dagas aumentadas %+(%d+)%.", s = { "DAGGERSKILL" }},
	
	{ p = "Hachas aumentadas %+(%d+)%.", s = { "ONEAXESKILL" }},
	{ p = "Hachas de dos manos aumentadas %+(%d+)%.", s = { "TWOAXESKILL" }},
	
	{ p = "Espadas aumentadas %+(%d+)%.", s = { "ONESWORDSKILL" }},
	{ p = "Espadas de dos manos aumentadas %+(%d+)%.", s = { "TWOSWORDSKILL" }},	
	
	{ p = "Increased Maces %+(%d+)%.", s = { "ONEMACESKILL" }},
	{ p = "Mazas de dos manos aumentadas %+(%d+)%.", s = { "TWOMACESKILL" }},
	
	{ p = "Arcos aumentados %+(%d+)%.", s = { "BOWSKILL" }},
	{ p = "Armas de fuego aumentadas %+(%d+)%.", s = { "GUNSSKILL" }},
	{ p = "Aumenta el índice de habilidad con ballestas en (%d+) p%.", s = { "CROSSBOWSKILL" }},
		

    --  Equip: Melee & Ranged
	{ p = "%+(%d+) p%. de poder de ataque%.", s = "AP" },
	{ p = "%+(%d+) p%. de poder de ataque solo bajo formas felinas, de oso y de oso nefasto%.", s = "APFERAL" },


	--  Equip: Magic --
	{ p = "Aumenta el daño y la curación de los hechizos mágicos y los efectos hasta en (%d+) p%.", s = { "SPELLDMG", "HEAL" } },
	{ p = "Aumenta la curación de los hechizos y los efectos hasta en (%d+) p%.", s = { "HEAL" } },

	{ p = "Aumenta el daño causado por los hechizos Arcanos y los efectos hasta en (%d+) p%.", s = "ARCANEDMG" },
	{ p = "Aumenta el daño causado por los hechizos de Fuego y los efectos hasta en (%d+) p%.", s = "FIREDMG" },
	{ p = "Aumenta el daño causado por los hechizos de Naturaleza y los efectos hasta en (%d+) p%.", s = "NATUREDMG" },
	{ p = "Aumenta el daño causado por los hechizos de Escarcha y los efectos hasta en (%d+) p%.", s = "FROSTDMG" },
	{ p = "Aumenta el daño causado por los hechizos de Sombras y los efectos hasta en (%d+) p%.", s = "SHADOWDMG" },
	{ p = "Aumenta el daño causado por los hechizos Sagrados y los efectos hasta en (%d+) p%.", s = "HOLYDMG" },


	--  Health & Mana Per 5 Sec  --
	{ p = "Restaura (%d+) p%. de maná cada 5 s%.", s = "MP5" },

	{ p = "Restaura (%d+) p%. de salud cada 5 s%.", s = "HP5"},
	-- { p = "(%d+) health every 5 sec%.", s = "HP5" },


	--  Enchants / Socket Bonuses / Mixed / Misc  --
	{ p = "^agilidad %+(%d+)$", s = "AGI" },
	{ p = "^aguante %+(%d+)$", s = "STA" },
	{ p = "^fuerza %+(%d+)$", s = "STR" },
	{ p = "^intelecto %+(%d+)$", s = "INT" },
	{ p = "^espíritu %+(%d+)$", s = "SPI" },
	
	{ p = "^Salud %+(%d+)$", s = "HP" },
	{ p = "^PS %+(%d+)$", s = "HP" },
	
	{ p = "^Maná %+(%d+)$", s = "MP" },
	
	{ p = "^Armadura reforzada %+(%d+)$", s = "ARMOR" },
	
	{ p = "^Alcance %(%+(%d+) de daño%)$", s = "RANGEDDMG" },
	{ p = "^Daño de arma %+(%d+)$", s = "WPNDMG" },
	
	{ p = "^Hechizos de curación %+(%d+)$", s = "HEAL" },
	{ p = "^Daño de hechizos %+(%d+)$", s = "SPELLDMG" },

	{ p = "Todas las estadísticas %+(%d+)", s = { "STR", "AGI", "STA", "INT", "SPI" } },

	-- { p = "%+(%d+) Arcane S?p?e?l?l? ?Damage", s = "ARCANEDMG" },
	{ p = "Daño de Fuego %+(%d+)", s = "FIREDMG" },
	-- { p = "%+(%d+) Nature S?p?e?l?l? ?Damage", s = "NATUREDMG" },
	{ p = "Daño de Escarcha %+(%d+)", s = "FROSTDMG" },
	{ p = "Daño de Sombras %+(%d+)", s = "SHADOWDMG" },
	-- { p = "%+(%d+) Holy S?p?e?l?l? ?Damage", s = "HOLYDMG" },
	
		-- AQ Enchants --
	{ p = "Daño de las Sombras %+(%d+)", s = "SHADOWDMG" },
	-- Redundant
	-- { p = "Daño de Fuego %+(%d+)", s = "FIREDMG" },
	-- { p = "Daño de Escarcha %+(%d+)", s = "FROSTDMG" },
};