--Upload zhTW localization by Pastor(夜空之歌), 2009/05/13
if (GetLocale() ~= "zhCN") then
	return;
end

LibGearExam.Patterns = {
	--基本状态--
	{ p = "%+(%d+) 力量", s = "STR" },
	{ p = "%+(%d+) 敏捷", s = "AGI" },
	{ p = "%+(%d+) 耐力", s = "STA" },
	{ p = "%+(%d+) 智力", s = "INT" },
	{ p = "%+(%d+) 精神", s = "SPI" },
	{ p = "(%d+)点护甲", s = "ARMOR" }, 
	{ p = "+(%d+)点护甲值。", s = "ARMOR" }, --附魔
	{ p = "+(%d+) 护甲。", s = "ARMOR" },
	{ p = "%+(%d+) 所有属性", s = { "STR", "AGI", "STA", "INT", "SPI" } }, --附魔
	
	--抗性--
	{ p = "%+(%d+) 奥术抗性", s = "ARCANERESIST" },
	{ p = "%+(%d+) 火焰抗性", s = "FIRERESIST" },
	{ p = "%+(%d+) 自然抗性", s = "NATURERESIST" },
	{ p = "%+(%d+) 冰霜抗性", s = "FROSTRESIST" },
	{ p = "%+(%d+) 暗影抗性", s = "SHADOWRESIST" },
	{ p = "%+(%d+) 点所有魔法抗性。", s = { "ARCANERESIST", "FIRERESIST", "NATURERESIST", "FROSTRESIST", "SHADOWRESIST" } },
	{ p = "%+(%d+) 所有抗性", s = { "ARCANERESIST", "FIRERESIST", "NATURERESIST", "FROSTRESIST", "SHADOWRESIST" } }, --附魔


	--其他法术伤害--
	{ p = "%+(%d+) 奥术法术伤害", s = "ARCANEDMG" },
	{ p = "%+(%d+) 火焰法术伤害", s = "FIREDMG" },
	{ p = "%+(%d+) 自然法术伤害", s = "NATUREDMG" },
	{ p = "%+(%d+) 冰霜法术伤害", s = "FROSTDMG" },
	{ p = "%+(%d+) 暗影法术伤害", s = "SHADOWDMG" },
	{ p = "%+(%d+) 神圣法术伤害", s = "HOLYDMG" },
	{ p = "使你的奥术法术伤害提高(%d+)点。", s = "ARCANEDMG" },
	{ p = "使你的火焰法术伤害提高(%d+)点。", s = "FIREDMG" },
	{ p = "使你的自然法术伤害提高(%d+)点。", s = "NATUREDMG" },
	{ p = "使你的冰霜法术伤害提高(%d+)点。", s = "FROSTDMG" },
	{ p = "使你的暗影法术伤害提高(%d+)点。", s = "SHADOWDMG" },
	{ p = "使你的神圣法术伤害提高(%d+)点。", s = "HOLYDMG" },
	{ p = "提高(%d+)点奥术法术伤害。", s = "ARCANEDMG" },
	{ p = "提高(%d+)点火焰法术伤害。", s = "FIREDMG" },
	{ p = "提高(%d+)点自然法术伤害。", s = "NATUREDMG" },
	{ p = "提高(%d+)点冰霜法术伤害。", s = "FROSTDMG" },
	{ p = "提高(%d+)点暗影法术伤害。", s = "SHADOWDMG" },
	{ p = "提高(%d+)点神圣法术伤害。", s = "HOLYDMG" },	
	{ p = "提高奥术法术伤害(%d+)点。", s = "ARCANEDMG" },
	{ p = "提高火焰法术伤害(%d+)点。", s = "FIREDMG" },
	{ p = "提高自然法术伤害(%d+)点。", s = "NATUREDMG" },
	{ p = "提高冰霜法术伤害(%d+)点。", s = "FROSTDMG" },
	{ p = "提高暗影法术伤害(%d+)点。", s = "SHADOWDMG" },
	{ p = "提高神圣法术伤害(%d+)点。", s = "HOLYDMG" },	
	
	--装备--
	--韧性等级--
	{ p = "防御技能提高(%d+)点。", s = "DEFENSE" },

	{ p = "使你躲闪攻击的几率提高(%d+)%%。", s = "DODGE" },

	{ p = "使你的盾牌的格挡值提高(%d+)点。", s = "BLOCK" },
	
	{ p = "使你招架攻击的几率提高(%d+)%%。", s = "PARRY" },
	
	--{ p = "Increases the block value of your shield by (%d+)%.", s = "BLOCKVALUE" },

    { p = "^(%d+)格挡",			s = "BLOCKVALUE"},	
	{ p = "^(%d+)点格挡", s = "BLOCKVALUE" },


	--  Equip: Melee & Ranged & Magic  --
	{ p = "使你造成致命一击的几率提高(%d+)%%。", s = { "CRIT" }},
	{ p = "使你击中目标的几率提高(%d+)%%。", s = { "HIT" }},
	
	{ p = "使你的法术造成致命一击的几率提高(%d+)%%。", s = { "SPELLCRIT" }},
	{ p = "使你的法术击中敌人的几率提高(%d+)%%。", s = { "SPELLHIT" }},
	
	
	-- Skill Bonuses
	{ p = "匕首技能提高%(%d+)%点。", s = { "DAGGERSKILL" }},
	
	{ p = "斧类武器技能提高%(%d+)%点。", s = { "ONEAXESKILL" }},
	{ p = "双手斧技能提高%(%d+)%点。", s = { "TWOAXESKILL" }},
	
	{ p = "剑类武器技能提高%(%d+)%点。", s = { "ONESWORDSKILL" }},
	{ p = "双手剑技能提高%(%d+)%点。", s = { "TWOSWORDSKILL" }},	
	
	{ p = "锤类武器技能提高%(%d+)%点。", s = { "ONEMACESKILL" }},
	{ p = "双手锤技能提高%(%d+)%点。", s = { "TWOMACESKILL" }},
	
	{ p = "弓箭技能提高%(%d+)%点。", s = { "BOWSKILL" }},
	{ p = "枪械技能提高%(%d+)%点。", s = { "GUNSSKILL" }},
	{ p = "弩技能提高%(%d+)%点。", s = { "CROSSBOWSKILL" }},
		

    --  Equip: Melee & Ranged
	{ p = "%+(%d+) 攻击强度。", s = "AP" },
	{ p = "在猎豹、熊和巨熊形态下的攻击强度提高%+(%d+)点。", s = "APFERAL" },


	--  Equip: Magic --
	{ p = "[提]*高所有法术和魔法效果所造成的伤害和治疗效果，最多(%d+)点。", s = { "SPELLDMG", "HEAL" } },
	{ p = "提高法术和魔法效果所造成的治疗效果，最多(%d+)点。", s = { "HEAL" } },
	{ p = "使法术的治疗效果提高最多(%d+)点。", s = { "HEAL" } },
	{ p = "使治疗法术和效果所回复的生命值提高(%d+)点。", s = { "HEAL" } },
	{ p = "提高法术所造成的治疗效果，最多(%d+)点。", s = { "HEAL" } },

	{ p = "提高奥术法术和效果所造成的伤害，最多(%d+)点。", s = "ARCANEDMG" },
	{ p = "提高火焰法术和效果所造成的伤害，最多(%d+)点。", s = "FIREDMG" },
	{ p = "提高自然法术和效果所造成的伤害，最多(%d+)点。", s = "NATUREDMG" },
	{ p = "提高冰霜法术和效果所造成的伤害，最多(%d+)点。", s = "FROSTDMG" },
	{ p = "提高暗影法术和效果所造成的伤害，最多(%d+)点。", s = "SHADOWDMG" },
	{ p = "使暗影法术所造成的伤害提高最多(%d+)点。", s = "SHADOWDMG" },
	{ p = "使暗影法术和效果所造成的伤害提高(%d+)点。", s = "SHADOWDMG" },
	{ p = "提高神圣法术和效果所造成的伤害，最多(%d+)点。", s = "HOLYDMG" },


	--  Health & Mana Per 5 Sec  --
	{ p = "每5秒恢复(%d+)点法力值[。]", s = "MP5" },
	{ p = "每5秒回复(%d+)点法力值[。]", s = "MP5" },

	{ p = "每5秒恢复(%d+)点生命值[。]", s = "HP5"},
	{ p = "每5秒回复(%d+)点生命值[。]", s = "HP5" },


	--  Enchants / Socket Bonuses / Mixed / Misc  --
	{ p = "^敏捷 %+(%d+)$", s = "AGI" },
	{ p = "^耐力 %+(%d+)$", s = "STA" },
	{ p = "^力量 %+(%d+)$", s = "STR" },
	{ p = "^智力 %+(%d+)$", s = "INT" },
	{ p = "^精神 %+(%d+)$", s = "SPI" },
	
	{ p = "^生命值 %+(%d+)$", s = "HP" },
	{ p = "^HP %+(%d+)$", s = "HP" },
	
	{ p = "^法力值 %+(%d+)$", s = "MP" },
	
	{ p = "^(%d+)$点护甲", s = "ARMOR" },
	
	{ p = "^Scope %(%+(%d+) Damage%)$", s = "RANGEDDMG" },
	{ p = "^武器伤害 %+(%d+)$", s = "WPNDMG" },
	
	{ p = "^治疗法术 %+(%d+)$", s = "HEAL" },
	{ p = "^法术治疗 %+(%d+)$", s = "HEAL" },
	{ p = "^法术伤害 %+(%d+)$", s = "SPELLDMG" },

	{ p = "所有属性 %+(%d+)", s = { "STR", "AGI", "STA", "INT", "SPI" } },

	{ p = "%+(%d+) 奥术法术伤害", s = "ARCANEDMG" },
	{ p = "%+(%d+) 火焰法术伤害", s = "FIREDMG" },
	{ p = "%+(%d+) 自然法术伤害", s = "NATUREDMG" },
	{ p = "%+(%d+) 冰霜法术伤害", s = "FROSTDMG" },
	{ p = "%+(%d+) 暗影法术伤害", s = "SHADOWDMG" },
	{ p = "%+(%d+) 神圣法术伤害", s = "HOLYDMG" },
	
		-- AQ Enchants --
	{ p = "暗影伤害 %+(%d+)", s = "SHADOWDMG" },
	{ p = "火焰伤害 %+(%d+)", s = "FIREDMG" },
	{ p = "冰霜伤害 %+(%d+)", s = "FROSTDMG" },
};