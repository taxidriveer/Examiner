-- This updated talents and glyphs module was made by eusi.

local ex = Examiner;

-- Module
local mod = ex:CreateModule("Talents",TALENTS);
mod.help = "Talents and Glyphs";
mod:CreatePage(false,"Talents and Glyphs");
mod:HasButton(true);

local numTalents = GetNumTalents();
local talents = {};
local glyphs = {};
local spec, role;
local RoleIcon = {
	[1] = {32/64, 48/64, 16/64, 32/64}, -- HEALER
	[2] = {48/64, 64/64,  0/64, 16/64}, -- TANK
	[3] = {32/64, 48/64,  0/64, 16/64}, -- DAMAGER
	[4] = {48/64, 64/64, 16/64, 32/64}, -- UNKNOWN / FAIL-SCAN
};

--------------------------------------------------------------------------------------------------------
--                                           Module Scripts                                           --
--------------------------------------------------------------------------------------------------------

-- OnInspectReady
function mod:OnInspectReady(unit)
	self:HasData(true);
	self:UpdateSpecRoleTalentsGlyphs();
end

-- OnClearInspect
function mod:OnClearInspect()
	self:HasData(nil);
end

--------------------------------------------------------------------------------------------------------
--                                                Code                                                --
--------------------------------------------------------------------------------------------------------

function mod:UpdateSpecRoleTalentsGlyphs()
	local unit = ex.unit;
	local activeSpec = GetActiveSpecGroup(unit);

	-- Specc
	local currentSpec = GetInspectSpecialization(unit);
	local currentSpecName = currentSpec and select(2, GetSpecializationInfoByID(currentSpec)) or "None"; --1=id; 2=name; 3=desc; 4=icon; 5=bg; 6=role; 7=class
	spec:SetText("|cffffffff"..(currentSpecName));

	-- Role
	local roleToken = GetSpecializationRoleByID(currentSpec);
	if(roleToken == "HEALER") then
		role.icon:SetTexCoord(unpack(RoleIcon[1]));
	elseif(roleToken == "TANK") then
		role.icon:SetTexCoord(unpack(RoleIcon[2]));
	elseif(roleToken == "DAMAGER") then
		role.icon:SetTexCoord(unpack(RoleIcon[3]));
	else
		role.icon:SetTexCoord(unpack(RoleIcon[4]));
	end

	--Talents
	for talentIndex = 1, numTalents do --MAX_NUM_TALENTS
		local _, _, classID = UnitClass(INSPECTED_UNIT);
		local name, iconTexture, tier, column, selected, available = GetTalentInfo(talentIndex, true, activeSpec, unit, classID);

		local tal = talents[talentIndex];
		local talentLink = GetTalentLink(talentIndex, true, classID);
		tal.link = talentLink;
		tal.missing = nil;
		tal.icon:SetTexture(iconTexture);
		tal.level:SetText(tier*15);

		 if ( selected ) then
			tal.icon.border:SetVertexColor(1,1,1);
			tal.icon:SetAlpha(1);
			SetDesaturation(tal.icon, false);
			tal.icon.border:Show();
		else
			tal.icon:SetAlpha(0.6);
			SetDesaturation(tal.icon, true);
			tal.icon.border:Hide();
		end

		tal:Show();
	end

	-- Glyphs
	for glyphIndex = 1, NUM_GLYPH_SLOTS do
		local enabled, glyphType, _, _, icon, glyphID = GetGlyphSocketInfo(glyphIndex, activeSpec, true, unit);

		if (enabled == 1) then
			local gly = glyphs[glyphIndex];
			if (glyphID ~= nil) then
				local glyphLink = GetGlyphLinkByID(glyphID);
				if (glyphLink ~= "") then

					gly.link = glyphLink;
					gly.missing = nil;
					gly.icon:SetTexture(icon);
					gly.type = glyphType;

					if(gly.type == 2) then
						gly:SetWidth(22);
						gly:SetHeight(22);
						gly.icon.border:SetWidth(25);
						gly.icon.border:SetHeight(25);
					end

					gly.icon:SetAlpha(1);
					SetDesaturation(gly.icon, false);
					gly.icon.border:SetVertexColor(0.392157, 0.584314, 0.929412); -- headline-blue
					gly.icon.border:Show();
					gly:Show();
				else
					gly:Hide();
				end
			else
				gly:Hide();
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                          Widget Creation                                           --
--------------------------------------------------------------------------------------------------------

-- Talents
for talentIndex = 1, numTalents do
	local tal = CreateFrame("Button",nil,mod.page);

	tal:SetWidth(32);
	tal:SetHeight(32);
	tal:SetScript("OnClick",ex.ItemButton_OnClick);
	tal:SetScript("OnEnter",ex.ItemButton_OnEnter);
	tal:SetScript("OnLeave",ex.ItemButton_OnLeave);

	tal.icon = tal:CreateTexture(nil,"ARTWORK");
	tal.icon:SetAllPoints();
	tal.icon:SetTexture("Interface\Icons\INV_Misc_QuestionMark");

	tal.icon.border = tal:CreateTexture(nil,"OVERLAY");
	tal.icon.border:SetTexture("Interface\Addons\Examiner\Textures\Border");
	tal.icon.border:SetWidth(34);
	tal.icon.border:SetHeight(34);

	tal.level = tal:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
	tal.level:SetPoint("BOTTOM",0,2);
	tal.level:SetTextColor(1,1,1);
	tal.level:SetFont(GameFontNormal:GetFont(),10,"OUTLINE");

	if (talentIndex == 1) then
		tal:SetPoint("TOPLEFT",28,-47);
		tal.icon.border:SetPoint("TOPLEFT",0,0);
	elseif (talentIndex == 4 or talentIndex == 7 or talentIndex == 10 or talentIndex == 13 or talentIndex == 16) then
		tal:SetPoint("BOTTOM",talents[talentIndex - 3],"BOTTOM",0,-40);
		tal.icon.border:SetPoint("BOTTOM",talents[talentIndex - 3],"BOTTOM",0,-42);
	else
		tal:SetPoint("RIGHT",talents[talentIndex - 1],"RIGHT",40,0);
		tal.icon.border:SetPoint("RIGHT",talents[talentIndex - 1],"RIGHT",40,0);
	end

	talents[talentIndex] = tal;
end

-- Glyphs
for glyphIndex = 1, NUM_GLYPH_SLOTS do
	local gly = CreateFrame("Button",nil,mod.page);

	gly:SetWidth(28);
	gly:SetHeight(28);
	gly:SetScript("OnClick",ex.ItemButton_OnClick);
	gly:SetScript("OnEnter",ex.ItemButton_OnEnter);
	gly:SetScript("OnLeave",ex.HideGTT);

	gly.icon = gly:CreateTexture(nil,"ARTWORK");
	gly.icon:SetAllPoints();
	gly.icon:SetTexture("Interface\Icons\INV_Misc_QuestionMark");

	gly.icon.border = gly:CreateTexture(nil,"OVERLAY");
	gly.icon.border:SetTexture("Interface\Addons\Examiner\Textures\Border");
	gly.icon.border:SetWidth(30);
	gly.icon.border:SetHeight(30);

	if (glyphIndex == 1) then
		gly:SetPoint("RIGHT",-29,80);
		gly.icon.border:SetPoint("RIGHT",0,0);
	else
		gly:SetPoint("RIGHT",glyphs[glyphIndex - 1],"RIGHT", 0, -39);
		gly.icon.border:SetPoint("RIGHT",glyphs[glyphIndex - 1],"RIGHT", 0, -40);
	end

	glyphs[glyphIndex] = gly;
end

-- Spec
spec = mod.page:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
spec:SetPoint("TOPLEFT",27,-32);

-- Role
role = CreateFrame("Button",nil,mod.page);
role:SetToplevel(true);
role:SetWidth(20);
role:SetHeight(20);
role:SetPoint("TOPLEFT",8,-11);
role.icon = role:CreateTexture(nil,"ARTWORK");
role.icon:SetAllPoints();
role.icon:SetTexture("Interface\Addons\Examiner\Textures\Role-Icons.tga");