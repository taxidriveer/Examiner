-- For enchant and gem IDs, check out the following link: https://fr.classic.wowhead.com/enchanting
-- Pattern entries marked with an "alert" value will cause Examiner to show a warning message,
-- { p = "Pattern", s = "Category", alert = 1 },
-- telling that the pattern is thought of as no longer in use. These patterns should eventually be deleted.
-- Modified by Grome of EU-Sulfuron for patch 1.13.2 October 12th 2019

if (GetLocale() ~= "koKR") then
	return;
end

LibGearExam.Patterns = {
	--  Base Stats  --
	{ p = "힘 %+(%d+)", s = "STR" },
	{ p = "민첩성 %+(%d+)", s = "AGI" },
	{ p = "체력 %+(%d+)", s = "STA" },
	{ p = "지능 %+(%d+)", s = "INT" },
	{ p = "정신력 %+(%d+)", s = "SPI" },
	
	{ p = "방어도 +?(%d+)", s = "ARMOR" },

		
	--  Resistances (Exclude the Resist-"ance" then it picks up armor patches as well)  --
	{ p = "비전 저항력 %+(%d+)", s = "ARCANERESIST" },
	{ p = "화염 저항력 %+(%d+)", s = "FIRERESIST" },
	{ p = "자연 저항력 %+(%d+)", s = "NATURERESIST" },
	{ p = "냉기 저항력 %+(%d+)", s = "FROSTRESIST" },
	{ p = "암흑 저항력 %+(%d+)", s = "SHADOWRESIST" },
	{ p = "모든 저항력 %+(%d+)", s = { "ARCANERESIST", "FIRERESIST", "NATURERESIST", "FROSTRESIST", "SHADOWRESIST" } },


	--  Equip: Defense  --
	{ p = "방어 숙련도 %+(%d+)%.", s = "DEFENSE" },
	{ p = "공격을 회피할 확률이 (%d+)%%만큼 증가합니다%.", s = "DODGE" },
	{ p = "방패로 적의 공격을 방어할 확률이 (%d+)%%만큼 증가합니다%.", s = "BLOCK" },
	{ p = "무기 막기 확률이 (%d+)%%만큼 증가합니다%.", s = "PARRY" },
	{ p = "방패의 피해 방어량이 (%d+)만큼 증가합니다%.", s = "BLOCKVALUE" },
	{ p = "^(%d+)의 피해 방어$", s = "BLOCKVALUE" },


	--  Equip: Melee & Ranged & Magic  --
	{ p = "치명타를 적중시킬 확률이 (%d+)%%만큼 증가합니다%.", s = { "CRIT" }},
	{ p = "무기의 적중률이 (%d+)%%만큼 증가합니다%.", s = { "HIT" }},
	
	{ p = "주문이 극대화 효과를 낼 확률이 (%d+)%%만큼 증가합니다%.", s = { "SPELLCRIT" }},
	{ p = "주문의 적중률이 (%d+)%%만큼 증가합니다%.", s = { "SPELLHIT" }},
	
	
	-- Skill Bonuses
	{ p = "단검류 숙련도 %+(%d+)", s = { "DAGGERSKILL" }},
	
	{ p = "한손 도끼류 숙련도 %+(%d+)", s = { "ONEAXESKILL" }},
	{ p = "양손 도끼류 숙련도 %+(%d+)", s = { "TWOAXESKILL" }},
	
	{ p = "한손 도검류 숙련도 %+(%d+)", s = { "ONESWORDSKILL" }},
	{ p = "양손 도검류 숙련도 %+(%d+)", s = { "TWOSWORDSKILL" }},	
	
	{ p = "한손 둔기류 숙련도 %+(%d+)", s = { "ONEMACESKILL" }},
	{ p = "양손 둔기류 숙련도 %+(%d+)", s = { "TWOMACESKILL" }},
	
	{ p = "활류 숙련도 %+(%d+)", s = { "BOWSKILL" }},
	{ p = "총기류 숙련도 %+(%d+)", s = { "GUNSSKILL" }},
	{ p = "석궁류 숙련도 %+(%d+)", s = { "CROSSBOWSKILL" }},


    --  Equip: Melee & Ranged
	{ p = "전투력 %+(%d+)", s = "AP" },
	{ p = "표범, 광포한 곰, 곰 변신 상태일 때 전투력이 (%d+)만큼 증가합니다%.", s = "APFERAL" },
	
	
	--  Equip: Magic --
	{ p = "모든 주문 및 효과에 의한 피해와 치유량이 최대 (%d+)만큼 증가합니다%.", s = { "SPELLDMG", "HEAL" } },
	{ p = "모든 주문 및 효과에 의한 치유량이 최대 (%d+)만큼 증가합니다%.", s = { "HEAL" } },
	
	{ p = "비전 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", s = "ARCANEDMG" },
	{ p = "화염 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", s = "FIREDMG" },
	{ p = "자연 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", s = "NATUREDMG" },
	{ p = "냉기 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", s = "FROSTDMG" },
	{ p = "암흑 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", s = "SHADOWDMG" },
	{ p = "신성 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", s = "HOLYDMG" },
	
	
	--  Health & Mana Per 5 Sec  --
	{ p = "매 5초마다 (%d+)의 마나가 회복됩니다%.", s = "MP5" },
	{ p = "5초당 마나 회복 %+(%d+)", s = "MP5" },

	{ p = "매 5초마다 (%d+)의 생명력이 회복됩니다%.", s = "HP5" },
	

	--  Enchants / Socket Bonuses / Mixed / Misc  --
	{ p = "^민첩성 %+(%d+)$", s = "AGI" },
	{ p = "^체력 %+(%d+)$", s = "STA" },
	{ p = "^힘 %+(%d+)$", s = "STR" },
	{ p = "^지능 %+(%d+)$", s = "INT" },
	{ p = "^정신력 %+(%d+)$", s = "SPI" },
	
	{ p = "^생명력 %+(%d+)$", s = "HP" },
	-- { p = "^HP %+(%d+)$", s = "HP" },
	
	{ p = "^마나 %+(%d+)$", s = "MP" },
	
	{ p = "^방어도 보강 %+(%d+)$", s = "ARMOR" },
	
	{ p = "^조준경 %(피해 %+(%d+)%)$", s = "RANGEDDMG" },
	{ p = "무기 공격력 %+(%d+)", s = "WPNDMG" },
	
	{ p = "^치유 효과 증가 %+(%d+)$", s = "HEAL" },
	{ p = "^주문 피해 %+(%d+)$", s = "SPELLDMG" },

	{ p = "모든 능력치 %+(%d+)", s = { "STR", "AGI", "STA", "INT", "SPI" } },

	{ p = "비전 공격력 %+(%d+)", s = "ARCANEDMG" },
	{ p = "화염 공격력 %+(%d+)", s = "FIREDMG" },
	{ p = "자연 공격력 %+(%d+)", s = "NATUREDMG" },
	{ p = "냉기 공격력 %+(%d+)", s = "FROSTDMG" },
	{ p = "암흑 공격력 %+(%d+)", s = "SHADOWDMG" },
	{ p = "신성 공격력 %+(%d+)", s = "HOLYDMG" },
};