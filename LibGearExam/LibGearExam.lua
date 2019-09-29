local REVISION = 8;
if (type(LibGearExam) == "table") and (LibGearExam.revision and LibGearExam.revision >= REVISION) then
	return;
end

local _G = getfenv(0);

-- LibGearExam Table
LibGearExam = LibGearExam or {};
local LGE = LibGearExam;
LGE.revision = REVISION;

--[[
	Item Link Patterns -- Item strings have 11 parameters (5.1) and 14 in (WoD - 6.0.2)
		FORMAT  ->  item:itemId:enchantId:gemId1:gemId2:gemId3:gemId4:suffixId:uniqueId:linkLevel:reforgeId:upgradeId

	[Item links data change in 6.0, WoD]
		itemID:enchant:gem1:gem2:gem3:gem4:suffixID:uniqueID:level:reforgeId:upgradeId
		itemID:enchant:gem1:gem2:gem3:gem4:suffixID:uniqueID:level:upgradeId:instanceDifficultyID:numBonusIDs:bonusID1:bonusID2
	[ItemLinks in 6.2 -- Added: 10th param, specializationID]
		itemID:enchant:gem1:gem2:gem3:gem4:suffixID:uniqueID:level:specializationID:upgradeId:instanceDifficultyID:numBonusIDs:bonusID1:bonusID2
	[ItemLinks in 6.2.x -- Added: numBonusIDs? -- The number of bonus IDs are now dynamic, the 13th parameter tells how many there are -- Total Count (???): 14 + numBonusIDs (???)]
		itemID:enchant:gemID1:gemID2:gemID3:gemID4:suffixID:uniqueID:linkLevel:specializationID:upgradeTypeID:instanceDifficultyID:numBonusIDs:bonusID1:bonusID2:...:upgradeID
--]]

LGE.ITEMLINK_PATTERN			= "(item:[^|]+)";					-- Matches the raw itemLink from the full itemString
-- Pattern generation for itemLinks. Always match from the start of the itemLink, to ensure that any new properties added to itemLinks, wont break our patterns.
LGE.ITEMLINK_PATTERN_ID			= "item:"..("[^:]*:"):rep(0).."(%d*)";
-- LGE.ITEMLINK_PATTERN_ENCHANT	= "item:"..("[^:]*:"):rep(1).."(%d*)";
LGE.ITEMLINK_PATTERN_ENCHANT    = "item:%d+:(%d+)";
LGE.ITEMLINK_PATTERN_LEVEL		= "(item:"..("[^:]*:"):rep(8)..")(%d*)(.+)";		-- used in gsub, so the pattern must match the entire link, even future added properties

-- Other Patterns
LGE.ItemUseToken = "^"..ITEM_SPELL_TRIGGER_ONUSE.." ";
LGE.SetNamePattern = "^(.+) %((%d)/(%d)%)$";
LGE.SetBonusTokenActive = "^"..ITEM_SET_BONUS:gsub("%%s","");
LGE.SetBonusTokenInactive = "%((%d+)%) "..ITEM_SET_BONUS:gsub("%%s","");

-- Schools
LGE.MagicSchools = { "FIRE", "NATURE", "ARCANE", "FROST", "SHADOW", "HOLY" };

-- Gear Slots
LGE.Slots = {
	"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot",
	"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot",
	"MainHandSlot", "SecondaryHandSlot", "RangedSlot",
};
LGE.SlotIDs = {};
for _, slotName in ipairs(LGE.Slots) do
	LGE.SlotIDs[slotName] = GetInventorySlotInfo(slotName);
end

-- Stat Names
LGE.StatNames = {
	STR = ITEM_MOD_STRENGTH_SHORT,
	AGI = ITEM_MOD_AGILITY_SHORT,
	STA = ITEM_MOD_STAMINA_SHORT,
	INT = ITEM_MOD_INTELLECT_SHORT,
	SPI = ITEM_MOD_SPIRIT_SHORT,

	ARMOR = ARMOR,

	ARCANERESIST = RESISTANCE6_NAME,
	FIRERESIST = RESISTANCE2_NAME,
	NATURERESIST = RESISTANCE3_NAME,
	FROSTRESIST = RESISTANCE4_NAME,
	SHADOWRESIST = RESISTANCE5_NAME,

	MASTERY = STAT_MASTERY,

	DODGE = DODGE_CHANCE,
	PARRY = PARRY_CHANCE,
	DEFENSE = DEFENSE,
	BLOCK = BLOCK_CHANCE,
	BLOCKVALUE = ITEM_MOD_BLOCK_VALUE_SHORT,
	RESILIENCE = STAT_RESILIENCE,
	PVPPOWER = STAT_PVP_POWER,

	AP = STAT_ATTACK_POWER,
	RAP = ITEM_MOD_RANGED_ATTACK_POWER_SHORT,
	CRIT = CRIT_CHANCE ,
	HIT = STAT_HIT_CHANCE ,
	HASTE = MELEE.." "..STAT_HASTE,

	WPNDMG = DAMAGE_TOOLTIP,
	RANGEDDMG = RANGED_DAMAGE_TOOLTIP,
	ARMORPENETRATION = ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT,	-- Az: Obsolete
	EXPERTISE = STAT_EXPERTISE,

	SPELLCRIT = STAT_CATEGORY_SPELL.." "..CRIT_ABBR,
	SPELLHIT = STAT_CATEGORY_SPELL.." "..HIT,
	SPELLHASTE = STAT_CATEGORY_SPELL.." "..STAT_HASTE,
	SPELLPENETRATION = ITEM_MOD_SPELL_PENETRATION_SHORT,

	SPELLDMG = ITEM_MOD_SPELL_POWER_SHORT,
	ARCANEDMG = ITEM_MOD_SPELL_POWER_SHORT.." ("..STRING_SCHOOL_ARCANE..")",
	FIREDMG = ITEM_MOD_SPELL_POWER_SHORT.." ("..STRING_SCHOOL_FIRE..")",
	NATUREDMG = ITEM_MOD_SPELL_POWER_SHORT.." ("..STRING_SCHOOL_NATURE..")",
	FROSTDMG = ITEM_MOD_SPELL_POWER_SHORT.." ("..STRING_SCHOOL_FROST..")",
	SHADOWDMG = ITEM_MOD_SPELL_POWER_SHORT.." ("..STRING_SCHOOL_SHADOW..")",
	HOLYDMG = ITEM_MOD_SPELL_POWER_SHORT.." ("..STRING_SCHOOL_HOLY..")",

	-- Az: How to make these two more global?
	HP = HEALTH.." Points",
	MP = MANA.." Points",

	HP5 = ITEM_MOD_HEALTH_REGEN_SHORT,
	MP5 = ITEM_MOD_POWER_REGEN0_SHORT,
};

-- Create a sorted List of Stats
local stats = LGE.StatNames;
local statsSorted = {};
LGE.StatNamesSorted = statsSorted;
for stat, name in next, stats do
	statsSorted[#statsSorted + 1] = stat;
end
sort(statsSorted,function(a,b) return stats[a] < stats[b]; end);

-- Absolute Stats, ie. they don't scale in percentages
LGE.ABSOLUTE_STATS = {
	MASTERY = true,
	EXPERTISE = true,
};

-- Scanner Tooltip
LGE.Tip = LGE.Tip or CreateFrame("GameTooltip","LibGearExamTip",nil,"GameTooltipTemplate");
LGE.Tip:SetOwner(UIParent,"ANCHOR_NONE");

-- Stores names of scanned sets -- Used in ScanUnitItems
local scannedSetNames = {};

-- Empty Socket names -- Used in GetGemInfo
local EMPTY_SOCKET_NAMES = {
	[EMPTY_SOCKET_RED] = true,
	[EMPTY_SOCKET_BLUE] = true,
	[EMPTY_SOCKET_YELLOW] = true,
	[EMPTY_SOCKET_PRISMATIC] = true,
	[EMPTY_SOCKET_META] = true,
	[EMPTY_SOCKET_COGWHEEL] = true,
	[EMPTY_SOCKET_HYDRAULIC] = false,	-- Az: what is this socket about, does it exist?
};

--------------------------------------------------------------------------------------------------------
--                                  Level 60 Stat Rating Base Numbers                                 --
--------------------------------------------------------------------------------------------------------

-- More Info - Thanks to Whitetooth.
-- http://elitistjerks.com/f15/t29453-combat_ratings_level_85_cataclysm/

-- Combat Rating Changes in WoW Version History:
-- 08.11.04		3.0.3		Resilience			patch		"The damage reduction component of resilience has been increased from 2 times the critical strike chance reduction to 2.2 times the critical strike chance reduction. In addition, the maximum damage reduction to a critical strike from resilience has been increased from 30% to 33%."
-- 09.04.14		3.1			Armor Penetration	patch		"All classes now receive 25% more benefit from Armor Penetration Rating."
-- 09.08.04		3.2			Dodge				patch		"The amount of dodge rating required per percentage of dodge has been increased by 15%"
-- 09.08.04		3.2			Parry				patch		"The amount of parry rating required per percentage of parry has been reduced by 8%."
-- 09.08.04		3.2			Resilience			patch		"... In addition, the amount of resilience needed to reduce critical strike chance, critical strike damage and overall damage has been increased by 15%"
-- 09.09.19		3.2.2		Armor Penetration	patch		"The amount of armor penetration gained per point of this rating has been reduced by 12%."
-- 10.01.20		3.3.0a		Resilience			hotfix		"Resilience damage reduction doubled. So depending on their current amount of resilience, characters might experience a 10 to 20% decrease in damage taken from other players."
-- 10.10.19		4.0.1		Resilience			blue/hf		"We had buffed resilience by 50% and then lowered it by 25%. This is a 12.5% buff from before the patch."
-- 11.04.26		4.1			Resilience			patch		"Resilience scaling has been modified for linear returns, as opposed to increasing returns. Under the new formula, going from 30 resilience to 40 resilience gives players the same increase to survivability as going from 0 to 10. Resilience now scales in the same way armor and magic resistances do. A player with 32.5% damage reduction from resilience in 4.0.6 should see their damage reduction unchanged in 4.1. Those with less than 32.5% will gain slightly. Those with more will lose some damage reduction, increasingly so as their resilience climbs."

LGE.StatRatingBaseTable = {
	SPELLHASTE = 10,
	SPELLHIT = 1, 
	SPELLCRIT = 1,
	HASTE = 10,
	HIT = 1,				-- Buffed a little in 4.0.1 (was 10 before)
	CRIT = 1,
	EXPERTISE = 2.34483,		-- Buffed a little in 4.0.1 (was 2.5 before)
	DODGE = 1,
	PARRY = 1,
	BLOCK = 1,				-- Nerfed a little in 4.0.1 (was 5 before)
	MASTERY = 14,

	-- Az: resilience is a mess, how do they get to the current value as of patch 4.0.3a? It seems to be 9.58333333333333333 which is 28.75 / 3. How are they getting to this though?
--	RESILIENCE = 28.75 * 0.75 / 2.25,	-- Reduced 25% compared to wrath, then buffed by 100% as a "hotfix". 10.12.05: found out this didnt match the char sheet, and it must have been changed again
--	RESILIENCE = 28.75 * 0.75 / 2.9,	-- This seems to be correct at 85, somehow I think resilience scales differently now depending on level
--	RESILIENCE = 28.75 * 0.75 / 2 / 1.125,
	RESILIENCE = 7.96418,				-- Apparently, this is the value for 4.1?

	-- DEFENSE = 1.5,
	ARMORPENETRATION = 4.69512176513672 / 1.25 / .88,
};

--------------------------------------------------------------------------------------------------------
--           Scan all items & set bonuses on given [unit] - Make sure the tables are reset            --
--------------------------------------------------------------------------------------------------------
function LGE:ScanUnitItems(unit,statTable,setTable)
	if (not unit) or (not UnitExists(unit)) then
		return;
	end
	-- Check all item slots
	for _, slotName in ipairs(self.Slots) do
		-- Set New Item Tip
		self.Tip:ClearLines();
		self.Tip:SetInventoryItem(unit,self.SlotIDs[slotName]);
		local lastSetName;
		local lastBonusCount = 1;
		-- Check Lines -- Az: re-write this loop as two loops instead?
		for i = 2, self.Tip:NumLines() do
			local needScan, lineText = self:DoLineNeedScan(_G["LibGearExamTipTextLeft"..i],true);
			if (needScan) then
				-- We use "setMax" to check if the Line was a SetNamePattern (WTB continue statement in Lua)
				local setName, setCount, setMax;
				-- Set Header (Only run this if we haven't found a set on this item yet)
				if (not lastSetName) then
					setName, setCount, setMax = lineText:match(self.SetNamePattern);
					if (setMax) and (not setTable[setName]) then
						setTable[setName] = { count = tonumber(setCount), max = tonumber(setMax) };
						lastSetName = setName;
						--continue :(
					end
				end
				-- Check Line for Patterns if this Line was not a SetNamePattern
				if (not setMax) then
					if (lineText:find(self.SetBonusTokenActive)) then
						-- If this item is part of a set, that we haven't scanned the setbonuses of, do it now.
						if (lastSetName) and (not scannedSetNames[lastSetName]) then
							self:ScanLineForPatterns(lineText,statTable);
							setTable[lastSetName]["setBonus"..lastBonusCount] = lineText;	-- Az: remove this as cached entries now use the new ScanArmorSetBonuses() function to get set bonus stats
							lastBonusCount = (lastBonusCount + 1);
						end
					else
						self:ScanLineForPatterns(lineText,statTable);
					end
				end
			end
		end
		-- Mark this set as scanned
		if (lastSetName) then
			scannedSetNames[lastSetName] = true;
		end
	end
	-- Cleanup
	wipe(scannedSetNames);
end
--------------------------------------------------------------------------------------------------------
--                   Scans a single item - Stats are added to the [statTable] param                   --
--------------------------------------------------------------------------------------------------------
function LGE:ScanItemLink(itemLink,statTable)
	if (itemLink) then
		-- Set Link
		self.Tip:ClearLines();
		self.Tip:SetHyperlink(itemLink);
		-- Check Lines
		for i = 2, self.Tip:NumLines() do
			local needScan, lineText = self:DoLineNeedScan(_G["LibGearExamTipTextLeft"..i],false);
			if (needScan) then
				self:ScanLineForPatterns(lineText,statTable);
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------
--                    Scans set bonuses - Stats are added to the [statTable] param                    --
--------------------------------------------------------------------------------------------------------
-- Az: finalize testing of this? -- remove bonus text store on char gear scan @ ScanUnitItems()
function LGE:ScanArmorSetBonuses(setName,setCount,statTable,itemTable)
	if not (setName and setCount and statTable and itemTable) then
		return;
	end
--AzMsg("|2[ScanArmorSetBonuses]");
	for slotName, itemLink in next, itemTable do
		-- Set Link
		self.Tip:ClearLines();
		self.Tip:SetHyperlink(itemLink);
		-- Check Lines
		for i = 2, self.Tip:NumLines() do
			local text = _G["LibGearExamTipTextLeft"..i]:GetText();
			local setFound = text:match(self.SetNamePattern);
			if (setName == setFound) then
--AzMsg("set pattern match = "..setFound);
				for n = i + 1, self.Tip:NumLines() do
					local text = _G["LibGearExamTipTextLeft"..n]:GetText();
					local setBonusIndex = tonumber(text:match(self.SetBonusTokenInactive));		-- lines are always formatted as inactive when not inspecting a player directly (az: unless you're wearing exactly this set?)
					if (setBonusIndex) then
						if (setBonusIndex > setCount) then
--AzMsg("  quit here as we have gone too far | |2line = "..text);
							return;
						end
--AzMsg("  match on bonus "..setBonusIndex.." @ set = "..setName.." | |2line = "..text);
						self:ScanLineForPatterns(text,statTable);
					end
				end
				return;
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------
--                         Checks if a Line Needs to be Scanned for Patterns                          --
--------------------------------------------------------------------------------------------------------
function LGE:DoLineNeedScan(tipLine,scanSetBonuses)
	-- Init Line
	local text = tipLine:GetText();
	local color = text:match("^(|c%x%x%x%x%x%x%x%x)");		-- look for color code at the start of line
	text = text:gsub("|c%x%x%x%x%x%x%x%x",""):gsub(",","");	-- remove all color coding, to simplify pattern matching
	local r, g, b = tipLine:GetTextColor();
	r, g, b = ceil(r * 255), ceil(g * 255), ceil(b * 255);	-- some lines don't use color codes, but store color in the text widget itself
	-- Always *Skip* Gray Lines
	if (r == 128 and g == 128 and b == 128) or (color == "|cff808080") then
		return false, text;
	-- Active Set Bonuses (Must be checked before green color check)
	elseif (not scanSetBonuses and text:find(self.SetBonusTokenActive)) then
		return false, text;
	-- Skip "Use:" lines, they are not a permanent stat, so don't include them
	elseif (text:find(self.ItemUseToken)) then
		return false, text;
	-- Always *Scan* Green Lines
	elseif (r == 0 and g == 255 and b == 0) or (color == "|cff00ff00") then
		return true, text;
	-- Should Match: Normal +Stat, Base Item Armor, Block Value on Shields
	elseif (text:find("^[+-]?%d+ [^%d]")) then
		return true, text;
	-- Lazy hack for French clients to detect armor value (e.g Armure : 50)
	elseif (text:find("^(%a+) (%p)")) then
		return true, text;
	-- Set Names (Needed to Check Sets)
	elseif (scanSetBonuses and text:find(self.SetNamePattern)) then
		return true, text;
	end
	return;
end
--------------------------------------------------------------------------------------------------------
--                                 Checks a Single Line for Patterns                                  --
--------------------------------------------------------------------------------------------------------
function LGE:ScanLineForPatterns(text,statTable)
	for index, pattern in ipairs(self.Patterns) do
		local pos, _, value1, value2 = text:find(pattern.p);
		if (pos) and (value1 or pattern.v) then
--pattern.uses = (pattern.uses or 0) + 1;
			-- Pattern Debugging -> Find obsolete patterns put on alert
			if (pattern.alert) and (Examiner) then
				local _, link = self.Tip:GetItem();
				link = link:match(self.ITEMLINK_PATTERN);
				AzMsg("|2Examiner Scan Alert:|r Please report the following to author.");
				AzMsg(format("index = |1%d|r, unit = |1%s|r.",index,tostring(Examiner.info.name)));
				AzMsg(format("text = |1%s|r",text));
				AzMsg(format("pattern = |1%s|r",pattern.p));
				AzMsg(format("link = |1%s|r",tostring(link)));
			end
			-- Add to stat
			if (type(pattern.s) == "string") then
				statTable[pattern.s] = (statTable[pattern.s] or 0) + (value1 or pattern.v);
			elseif (type(pattern.s) == "table") then
				for statIndex, statName in ipairs(pattern.s) do
					if (type(pattern.v) == "table") then
						statTable[statName] = (statTable[statName] or 0) + (pattern.v[statIndex]);
					-- Az: This is a bit messy, only supports 2 now, needs to make it dynamic and support as many extra values as needed
					elseif (statIndex == 2) and (value2) then
						statTable[statName] = (statTable[statName] or 0) + (value2);
					else
						statTable[statName] = (statTable[statName] or 0) + (value1 or pattern.v);
					end
				end
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------
--                                      Convert Rating to Percent                                     --
--------------------------------------------------------------------------------------------------------

-- More to read here: http://www.wowwiki.com/Combat_Rating_System
function LGE:GetRatingInPercent(stat,rating,level)
	local base = self.StatRatingBaseTable[stat];
	-- Check Valid Input
	if (not base or not rating or not level) then
		return;
	end
	-- Set level to max in case it's unknown; still incorrect, but better
	if (level == -1) then
		level = MAX_PLAYER_LEVEL;
	end
	-- Patch 3.1 Quote: "shamans, paladins, druids, and death knights now receive 30% more melee haste from Haste Rating."
	-- Az: This has been disabled for cataclysm. Haven't read anything official about it being removed, but it appears to be. Tested on paladins and shamans. DKs and druids still untested.
--	if (class and stat == "HASTE") and (class == "PALADIN" or class == "SHAMAN" or class == "DEATHKNIGHT" or class == "DRUID") then
--		base = (base / 1.3);
--	end
	-- Calculate "scale" Depending on Level
	local scale;
	if (level > 85) then
		scale = (82 / 52 * (131 / 63) * 3.9053695 ^ ((level - 80) / 5));	-- Az: No idea what the MoP formula is, so just using the Cata one for now :/
	elseif (level > 80) then
		scale = (82 / 52 * (131 / 63) * 3.9053695 ^ ((level - 80) / 5));	-- Az: not exactly the correct Cata formula for 80-85!
	elseif (level >= 70) then
		scale = (82 / 52 * (131 / 63) ^ ((level - 70) / 10));
	elseif (level >= 60) then
		scale = (82 / (262 - 3 * level));
	elseif (level <= 33) and (stat == "DODGE" or stat == "PARRY" or stat == "BLOCK" or stat == "RESILIENCE") then
		scale = 0.5;
	elseif (level > 10) then
		scale = ((level - 8) / 52);
	else
		scale = (2 / 52);
	end
	-- Return Calculated Percentage
	return (rating / base / scale);
end

--------------------------------------------------------------------------------------------------------
--                                           Get Stat Value                                           --
--------------------------------------------------------------------------------------------------------

-- Returns a modified and formatted stat from the given "statTable", which might be adjusted by certain options
-- If "compareTable" is given a table, it assumes compare mode and displays and colorizes the differences.
-- As a control flag, "compareTable" set to a boolean, will return the value unformatted for use in compare mode.
function LGE:GetStatValue(statToken,statTable,compareTable,level,combineAdditiveStats,percentRatings)
	local value = (statTable[statToken] or 0);
	local compareType = type(compareTable or nil);
	-- Compare
	if (compareType == "table") then
		value = (value - self:GetStatValue(statToken,compareTable,true));
	end
	-- OPTION: Add additive stats which stack to each other
	if (combineAdditiveStats) then
		if (statTable["SPELLDMG"]) then
			for _, schoolToken in ipairs(self.MagicSchools) do
				if (statToken == schoolToken.."DMG") then
					value = (value + statTable["SPELLDMG"]);
					break;
				end
			end
		end
		if (statToken == "SPELLDMG") and (statTable["INT"]) then
			value = (value + statTable["INT"]);
		end
		if (statToken == "RAP") and (statTable["AP"]) then
			value = (value + statTable["AP"]);
		end
	end
	-- OPTION: Give Rating Values in Percent
	local valuePct, rating;
	if (self.StatRatingBaseTable[statToken]) then
		rating = self:GetRatingInPercent(statToken,value,level) or 0; -- tip ?
		valuePct = tonumber(format("%.2f",rating)); -- tip ?
	end
	-- Do not modify the value further if we are just getting the compare value (compareTable == true)
	if (compareType == "boolean") then
		return value;
	else
		-- If Compare, Add Colors
		if (compareType == "table") then
			local color = (value > 0 and "|cff80ff80+") or (value < 0 and "|cffff8080");
			if (value ~= 0) then
				value = color..value;
			end
			if (valuePct) and (valuePct ~= 0) then
				valuePct = color..valuePct;
			end
		end
		-- Add "%" to converted ratings (Exclude absolute stats)
		if (valuePct) and (not self.ABSOLUTE_STATS[statToken]) then
			valuePct = valuePct.."%";
		end
	end
	-- Return
	if (percentRatings) and (self.StatRatingBaseTable[statToken]) then
		return valuePct, value;
	else
		 -- do we color it ? "%" looks out of place...
		if (self.StatRatingBaseTable[statToken]) then
			local color = "|cff80ff80";
			value = color..value.."%";
		end	
		return value, valuePct;
	end
end

--------------------------------------------------------------------------------------------------------
--                                          Helper Functions                                          --
--------------------------------------------------------------------------------------------------------

-- Get Enchant Info -- Returns the EnchantID and the EnchantName
function LGE:GetEnchantInfo(link)
	local id = tonumber(link:match(LGE.ITEMLINK_PATTERN_ENCHANT));
	-- Prepare basic item with enchant
	if (id == nil  or id == "") then
	id = ""
	end
	local link = "item:8383:"..id..":"
	-- No enchant
	if (not id) or (id == 0) then
		return;
	end
	-- Set Link
	self.Tip:ClearLines();
	-- self.Tip:SetHyperlink(format("item:%d+:%d+",id));	-- Az: somewhat hackish, but it works!
	self.Tip:SetHyperlink(link);
	local enchantName = LibGearExamTipTextLeft2:GetText();
	if (not enchantName) or (enchantName == "") then
		return;
	end
	-- return
	return id, enchantName;
end

-- Get Gem Info -- Number of returns will match number of sockets in item. Value will be gemLink if gemmed, and "EMPTY_SOCKET_<color>" global when gem is missing
function LGE:GetGemInfo(link,gemTable,unit,slotName)
	
end

-- Fix Item String Level -- The level number of an item string, is always the inspector's level, not the inspected, this function fixes that
function LGE:FixItemStringLevel(link,level)
	-- WARNING: This code will break if item strings gets another parameter added
	return (link and level) and link:gsub(self.ITEMLINK_PATTERN_LEVEL,"%1"..level.."%3") or link;
end

-- Format Stat Name
function LGE:FormatStatName(statToken,inPercent)
	if (not self.StatNames[statToken]) then
		return statToken.." (Invalid Stat)";
	elseif (inPercent or not self.StatRatingBaseTable[statToken]) then
		return self.StatNames[statToken];
	else
		return self.StatNames[statToken] -- is there a language friendly version of .." "..RATING; ? use STATUS_TEXT_PERCENT ? this add rating or chance to the stats description
	end
end