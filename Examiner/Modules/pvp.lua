local ex = Examiner;

-- Module
local mod = ex:CreateModule(PVP,PLAYER_V_PLAYER);
mod.help = "Honor Details";
mod:CreatePage(true,PLAYER_V_PLAYER);
mod:HasButton(true);
mod.canCache = true;

-- Variables
local labels = {};
local arena = {};

-- Data Variables
local hd = {};
local ad = { {}, {}, {} };

--------------------------------------------------------------------------------------------------------
--                                           Module Scripts                                           --
--------------------------------------------------------------------------------------------------------

-- OnInspect
function mod:OnInspect(unit)
	if (ex.isSelf) then
		self:LoadHonorNormal();
	end
	if (ex.canInspect) then
		ex:RequestHonorData();
	end
end

-- OnHonorReady
function mod:OnHonorReady()
	self:LoadHonorNormal();
end

-- OnCacheLoaded
function mod:OnCacheLoaded(entry,unit)
	if (entry.Honor) then
		self:HasData(true);
		-- Honor
		for name, value in next, entry.Honor do
			hd[name] = value;
		end
		self:UpdateHonor();
	end
end

-- OnCache
function mod:OnCache(entry)
	if (self:CanCache()) and (next(hd)) then
		entry.Honor = CopyTable(hd);
	end
end

-- OnClearInspect
function mod:OnClearInspect()
	self:HasData(nil);
	-- Header
	self.rankIcon:Hide();
	-- Clear Honor
	wipe(hd);
	for i = 4, 9 do
		labels[i]:SetText("---");
	end
	labels[9]:SetTextColor(1,1,0);
end

--------------------------------------------------------------------------------------------------------
--                                             PvP Stuff                                              --
--------------------------------------------------------------------------------------------------------

-- Format Numbers
local function FormatNumbers(self,value,max)
	local color = (value == 0 and "|cffff8080" or "|cffffff80");
	if (max == 0) then
		self:SetFormattedText("%s0|r (%1$s0%%|r)",color);
	else
		self:SetFormattedText("%s%d|r (%s%.1f%%|r)",color,value,color,value / max * 100);
	end
end

-- Load Honor Normal
function mod:LoadHonorNormal()
	self:HasData(true);
	-- Query -- Az: Even if inspecting ourself, use inspect data as GetPVPYesterdayStats() is bugged as of 4.0.1
	if (not ex.isSelf) or (HasInspectHonorData()) then
		hd.todayHK, hd.todayHonor, hd.yesterdayHK, hd.yesterdayHonor, hd.lifetimeHK, hd.lifetimeRank = GetInspectHonorData();
	else
		hd.todayHK, hd.todayHonor = GetPVPSessionStats();
		hd.yesterdayHK, hd.yesterdayHonor = GetPVPYesterdayStats();
		hd.lifetimeHK, hd.lifetimeRank = GetPVPLifetimeStats();
	end
	-- Update
	self:UpdateHonor();
	-- Show Honor Points for Player only	-- Az: disabled for cata, GetHonorCurrency() func removed
--	if (ex.isSelf) then
--		labels[9]:SetText(GetHonorCurrency());
--		labels[9]:SetTextColor(0,1,0);
--	end
end

-- Honor Update
function mod:UpdateHonor()
	-- Show Rank
	if (hd.lifetimeRank ~= 0) then
		self.rankIcon.texture:SetTexture("Interface\\PvPRankBadges\\PvPRank"..format("%.2d",hd.lifetimeRank - 4));
		self.rankIcon.texture:SetTexCoord(0,1,0,1);
		self.rankIcon.tip = format("%s (Rank %d)",GetPVPRankInfo(hd.lifetimeRank,ex.unit),(hd.lifetimeRank - 4));
		self.rankIcon:Show();
	end
	-- Show Kills/Honor
	labels[4]:SetText(hd.todayHK);
	labels[5]:SetText(hd.yesterdayHK);
	labels[6]:SetText(hd.lifetimeHK);
	labels[7]:SetText(hd.todayHonor);
	labels[8]:SetText(hd.yesterdayHonor);
	labels[9]:SetText("---");
	labels[9]:SetTextColor(1,1,0);
end


--------------------------------------------------------------------------------------------------------
--                                           Widget Creation                                          --
--------------------------------------------------------------------------------------------------------

-- Rank Icon
mod.rankIcon = CreateFrame("Frame",nil,mod.page);
mod.rankIcon:SetPoint("TOPLEFT",12,-12);
mod.rankIcon:SetWidth(18);
mod.rankIcon:SetHeight(18);
mod.rankIcon:EnableMouse(1);
mod.rankIcon:SetScript("OnEnter",function(self) GameTooltip:SetOwner(self,"ANCHOR_BOTTOMRIGHT"); GameTooltip:SetText(self.tip) end)
mod.rankIcon:SetScript("OnLeave",ex.HideGTT);
mod.rankIcon.texture = mod.rankIcon:CreateTexture(nil,"ARTWORK");
mod.rankIcon.texture:SetAllPoints();

-- Honor Labels
for i = 1, 9 do
	local l = mod.page:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
	l:SetWidth(70);

	if (i <= 3) then
		l:SetText(i == 1 and "Today" or i == 2 and "Yesterday" or "Lifetime");
		l:SetTextColor(0.5,0.75,1);
	else
		l:SetTextColor(1,1,0);
	end

	if ((i - 1) % 3 == 0) then
		l:SetPoint("TOP",-28,-36 - (i - 1) / 3 * 12);
	else
		l:SetPoint("LEFT",labels[i - 1],"RIGHT");
	end

	labels[i] = l;
end

-- Honor Label Side Headers
local t = mod.page:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
t:SetPoint("RIGHT",labels[4],"LEFT");
t:SetWidth(70);
t:SetJustifyH("LEFT");
t:SetText("Honor Kills");
t:SetTextColor(0.5,0.75,1);

t = mod.page:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
t:SetPoint("RIGHT",labels[7],"LEFT");
t:SetWidth(70);
t:SetJustifyH("LEFT");
t:SetText("Honor Points");
t:SetTextColor(0.5,0.75,1);