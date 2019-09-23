-- Korean localization by omosiro(자매 of KR-Norgannon), 09.02.20
-- Modified by chkid(주시자의눈 of KR-Ellune) for WotLK, 09.05.11
-- Modified by cyclone(KR-Eonar) for MoP, 12.12.02

if (GetLocale() ~= "koKR") then
	return;
end

LibGearExam.Patterns = {
	--  기본 능력치  --
	{ p = "방어도 (%d+)", s = "ARMOR" }, -- 모든 방어구에서 확인해야 함: 기본 방어도, 방어 마법부여, 방어구 키트

	{ p = "힘 %+(%d+)", s = "STR" },
	{ p = "민첩성 %+(%d+)", s = "AGI" },
	{ p = "체력 %+(%d+)", s = "STA" },
	{ p = "지능 %+(%d+)", s = "INT" },
	{ p = "정신력 %+(%d+)", s = "SPI" },
	{ p = "모든 능력치 %+(%d+)", s = { "STR", "AGI", "STA", "INT", "SPI" } }, -- 가슴보호구 + 손목보호구 마법부여

	--  저항력 (Exclude the Resist-"ance" then it picks up armor patches as well)  --
	{ p = "비전 저항력 %+(%d+)", s = "ARCANERESIST" },
	{ p = "화염 저항력 %+(%d+)", s = "FIRERESIST" },
	{ p = "자연 저항력 %+(%d+)", s = "NATURERESIST" },
	{ p = "냉기 저항력 %+(%d+)", s = "FROSTRESIST" },
	{ p = "암흑 저항력 %+(%d+)", s = "SHADOWRESIST" },
	{ p = "모든 저항력 %+(%d+)", s = { "ARCANERESIST", "FIRERESIST", "NATURERESIST", "FROSTRESIST", "SHADOWRESIST" } }, -- 공허의 구슬

	--  장비: 공통 스탯  --
	{ p = "적중 %+(%d+)", s = { "HIT", "RHIT", "SPELLHIT" } }, -- koKR only
	{ p = "특화 %+(%d+)", s = "MASTERY" }, 	
	{ p = "가속 %+(%d+)", s = { "HASTE", "RHASTE", "SPELLHASTE" } },	
	{ p = "숙련 %+(%d+)", s = { "EXPERTISE" } }, 	
	{ p = "치명타 및 극대화 %+(%d+)", s = { "CRIT", "RCRIT", "SPELLCRIT" } },
	
	--  장비: PvP & 방어(defense)  --
	{ p = "PvP 탄력 %+(%d+)", s = "RESILIENCE" },	
	{ p = "PvP 위력 %+(%d+)", s = "PVPPOWER" },
	{ p = "PvP 위력이 (%d+)만큼 증가합니다", s = "PVPPOWER" },

	{ p = "회피 %+(%d+)", s = "DODGE" },
	{ p = "무기 막기 %+(%d+)", s = "PARRY" }, -- Az: 확인을 위해 더 이상 플러스 표시가 필요치 않음

	--  장비: 근접 & 원거리  --
	{ p = "전투력 %+(%d+)", s = { "AP", "RAP" } }, --원거리 통합검색
	
	--  장비: 주문력  --
	{ p = "^주문력 %+(%d+)", s = { "SPELLDMG", "SPELLDMG" } }, -- 몇몇 아이템/보석은 리치왕의 분노 이전에도 사용됨, 하지만 지금은 영구적인 주문 패턴임.
	
	{ p = "암흑 및 냉기 주문력 %+(%d+)", s = { "SHADOWDMG", "FROSTDMG" } },	-- 구 "냉기의 영혼" 마법부여
	{ p = "비전 및 화염 주문력 %+(%d+)", s = { "ARCANEDMG", "FIREDMG" } },	-- 구 "태양의 불꽃" 마법부여

	{ p = ": 비전 계열의 주문력이 (%d+)만큼 증가합니다.", s = "ARCANEDMG" },
	{ p = ": 화염 계열의 주문력이 (%d+)만큼 증가합니다.", s = "FIREDMG" },
	{ p = ": 자연 계열의 주문력이 (%d+)만큼 증가합니다.", s = "NATUREDMG" },
	{ p = ": 냉기 계열의 주문력이 (%d+)만큼 증가합니다.", s = "FROSTDMG" },
	{ p = ": 암흑 계열의 주문력이 (%d+)만큼 증가합니다.", s = "SHADOWDMG" },
	{ p = ": 신성 계열의 주문력이 (%d+)만큼 증가합니다.", s = "HOLYDMG" },
	
	{ p = "비전 주문 공격력 %+(%d+)", s = "ARCANEDMG" },
	{ p = "화염 주문 공격력 %+(%d+)", s = "FIREDMG" },
	{ p = "자연 주문 공격력 %+(%d+)", s = "NATUREDMG" },
	{ p = "냉기 주문 공격력 %+(%d+)", s = "FROSTDMG" },
	{ p = "암흑 주문 공격력 %+(%d+)", s = "SHADOWDMG" },
	{ p = "신성 주문 공격력 %+(%d+)", s = "HOLYDMG" },

	--  마법부여 / 보석 / 소켓 보너스 / 혼합 / 기타  --
	{ p = "^생명력 %+(%d+)$", s = "HP" },
	{ p = "^마나 %+(%d+)$", s = "MP" },
	
	{ p = "티타늄 도금$", s = "PARRY", v = 7 },
	{ p = "아다만타이트 무기사슬$", s = "PARRY", v = 15 },
	{ p = "티타늄 무기사슬$", s = { "HASTE", "RHASTE", "SPELLHASTE" }, v = 15 },
	{ p = "황철 무기 사슬$", s = { "HASTE", "RHASTE", "SPELLHASTE" }, v = 8 }, 
	{ p = "살아있는 강철 무기 사슬$", s = { "CRIT", "RCRIT", "SPELLCRIT" }, v = 12 },
};