-- For enchant and gem IDs, check out the following link: https://ko.classic.wowhead.com/enchanting
-- Pattern entries marked with an "alert" value will cause Examiner to show a warning message,
-- { p = "Pattern", s = "Category", alert = 1 },
-- telling that the pattern is thought of as no longer in use. These patterns should eventually be deleted.
-- Modified by chkid(주시자의눈) of KR-Ice Blood for patch 1.13.2 October 15th 2019

if (GetLocale() ~= "koKR") then
	return;
end

LibGearExam.Patterns = {

	--  기본 능력치  --
--[[
	{ p = "힘 %+(%d+)", s = "STR" },
	{ p = "민첩성 %+(%d+)", s = "AGI" },
	{ p = "체력 %+(%d+)", s = "STA" },
	{ p = "지능 %+(%d+)", s = "INT" },
	{ p = "정신력 %+(%d+)", s = "SPI" },
--]]

	{ p = "방어도 +?(%d+)", s = "ARMOR" },


	--  저항력 (Exclude the Resist-"ance" then it picks up armor patches as well)  --
	{ p = "비전 저항력 %+(%d+)", s = "ARCANERESIST" },
	{ p = "화염 저항력 %+(%d+)", s = "FIRERESIST" },
	{ p = "자연 저항력 %+(%d+)", s = "NATURERESIST" },
	{ p = "냉기 저항력 %+(%d+)", s = "FROSTRESIST" },
	{ p = "암흑 저항력 %+(%d+)", s = "SHADOWRESIST" },
	{ p = "모든 저항력 %+(%d+)", s = { "ARCANERESIST", "FIRERESIST", "NATURERESIST", "FROSTRESIST", "SHADOWRESIST" } },


	--  장비: 방어  --
	{ p = "방어 숙련도 %+(%d+)", s = "DEFENSE" },

	{ p = "공격을 회피할 확률이 (%d+)%%만큼 증가합니다.", s = "DODGE" },

	{ p = "방패로 적의 공격을 방어할 확률이 (%d+)%%만큼 증가합니다.", s = "BLOCK" },
	
	{ p = "무기 막기 확률이 (%d+)%%만큼 증가합니다.", s = "PARRY" },
	
	{ p = "방패의 피해 방어량이 (%d+)만큼 증가합니다.", s = "BLOCKVALUE" },
	
	{ p = "^(%d+)의 피해 방어", s = "BLOCKVALUE" },


	--  장비: 근접, 원거리 및 마법  --
	{ p = "치명타를 적중시킬 확률이 (%d+)%%만큼 증가합니다.", s = { "CRIT" }},
	{ p = "무기의 적중률이 (%d+)%%만큼 증가합니다.", s = { "HIT" }},
	
	{ p = "주문이 극대화 효과를 낼 확률이 (%d+)%%만큼 증가합니다.", s = { "SPELLCRIT" }},
	{ p = "주문의 적중률이 (%d+)%%만큼 증가합니다.", s = { "SPELLHIT" }},


	-- 기술 보너스
	{ p = "단검류 숙련도 %+(%d+)", s = { "DAGGERSKILL" }},
	
	{ p = "도끼류 숙련도 %+(%d+)", s = { "ONEAXESKILL" }},
	{ p = "양손 도끼류 숙련도 %+(%d+)", s = { "TWOAXESKILL" }},
	
	{ p = "도검류 숙련도 %+(%d+)", s = { "ONESWORDSKILL" }},
	{ p = "양손 도검류 숙련도 %+(%d+)", s = { "TWOSWORDSKILL" }},	
	
	{ p = "둔기류 숙련도 %+(%d+)", s = { "ONEMACESKILL" }},
	{ p = "양손 둔기류 숙련도 %+(%d+)", s = { "TWOMACESKILL" }},
	
	{ p = "활류 숙련도 %+(%d+)", s = { "BOWSKILL" }},
	{ p = "총기류 숙련도 %+(%d+)", s = { "GUNSSKILL" }},
	{ p = "석궁류 숙련도 %+(%d+)", s = { "CROSSBOWSKILL" }},


    --  장비: 근접 및 원거리
	{ p = "전투력 %+(%d+)", s = "AP" },
	{ p = "표범, 광포한 곰, 곰 변신 상태일 때 전투력이 (%d+)만큼 증가합니다.", s = "APFERAL" },
	
	--  장비: 마법 --
	{ p = "모든 주문 및 효과에 의한 피해와 치유량이 최대 (%d+)만큼 증가합니다.", s = { "SPELLDMG", "HEAL" } },
	{ p = "모든 주문 및 효과에 의한 치유량이 최대 (%d+)만큼 증가합니다.", s = "HEAL" },

	{ p = "비전 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다.", s = "ARCANEDMG" },
	{ p = "화염 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다.", s = "FIREDMG" },
	{ p = "자연 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다.", s = "NATUREDMG" },
	{ p = "냉기 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다.", s = "FROSTDMG" },
	{ p = "암흑 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다.", s = "SHADOWDMG" },
	{ p = "신성 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다.", s = "HOLYDMG" },


	--  매 5초마다 생명력 및 마나  --
	{ p = "매 5초마다 (%d+)의 마나를 회복합니다.", s = "MP5" },
	{ p = "매 5초마다 (%d+)의 마나가 회복됩니다.", s = "MP5" },
	{ p = "5초당 마나 회복 %+(%d+)", s = "MP5" },

	{ p = "매 5초마다 (%d+)의 생명력을 회복합니다.", s = "HP5"},
	{ p = "매 5초마다 (%d+)의 생명력이 회복됩니다.", s = "HP5"},
	{ p = "매 5초마다 (%d+)의 생명력을 재생시킵니다.", s = "HP5" },
	{ p = "5초당 생명력 회복 %+(%d+)", s = "HP5" },


	--  마법부여 / 소켓 보너스 / 혼합 / 기타  --
	{ p = "^민첩성 %+(%d+)$", s = "AGI" },
	{ p = "^체력 %+(%d+)$", s = "STA" },
	{ p = "^힘 %+(%d+)$", s = "STR" },
	{ p = "^지능 %+(%d+)$", s = "INT" },
	{ p = "^정신력 %+(%d+)$", s = "SPI" },
	
	{ p = "^생명력 %+(%d+)$", s = "HP" },
	{ p = "^마나 %+(%d+)$", s = "MP" },
	
	{ p = "^방어도 보강 %+(%d+)", s = "ARMOR" },
	
	{ p = "^조준경 %(피해 %+(%d+)%)", s = "RANGEDDMG" },
	{ p = "^조준경 %(공격력 %+(%d+)%)", s = "RANGEDDMG" },
	{ p = "무기 공격력 %+(%d+)", s = "WPNDMG" },
	
	{ p = "^치유 효과 증가 %+(%d+)$", s = "HEAL" },
	{ p = "^주문 피해 %+(%d+)$", s = "SPELLDMG" },

	{ p = "모든 능력치 %+(%d+)", s = { "STR", "AGI", "STA", "INT", "SPI" } },

	{ p = "비전 주문 공격력 %+(%d+)", s = "ARCANEDMG" },
	{ p = "화염 주문 공격력 %+(%d+)", s = "FIREDMG" },
	{ p = "자연 주문 공격력 %+(%d+)", s = "NATUREDMG" },
	{ p = "냉기 주문 공격력 %+(%d+)", s = "FROSTDMG" },
	{ p = "암흑 주문 공격력 %+(%d+)", s = "SHADOWDMG" },
	{ p = "신성 주문 공격력 %+(%d+)", s = "HOLYDMG" },

};
