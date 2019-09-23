-- code updated by ywfn, to work with the pvp and battleground changes

local ex = Examiner;

-- Module
local mod = ex:CreateModule(PVP,PLAYER_V_PLAYER);
mod.help = "Honor & Arena Details";
mod:CreatePage(true,PLAYER_V_PLAYER);
mod:HasButton(true);
mod.canCache = true;

-- Variables
local labels = {};

-- Data Variables -- Honor & Arena Data
local hd, ad = {}, {};

--------------------------------------------------------------------------------------------------------
--                                           Module Scripts                                           --
--------------------------------------------------------------------------------------------------------

-- OnInitialize
function mod:OnInitialize()
	for i = 1, MAX_ARENA_TEAMS+1 do
		ad[i] = {};
	end
end

-- OnInspect
function mod:OnInspect(unit)
	if (ex.isSelf) then
		self:LoadHonorNormal();
		self:LoadArenaTeamsNormal();
	end
	if (ex.canInspect) then
		ex:RequestHonorData();
	end
end

-- OnHonorReady
function mod:OnHonorReady()
	self:LoadHonorNormal();
	self:LoadArenaTeamsNormal();
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
		-- Arena
		for i = 1, MAX_ARENA_TEAMS+1 do
			if (entry["Arena"..i]) then
				local at = ad[i];
				for name, value in next, entry["Arena"..i] do
					at[name] = value;
				end
			end
		end
		self:ArenaTeamUpdate();
	end
end

-- OnCache
function mod:OnCache(entry)
	if (self:CanCache()) and (next(hd)) then
		entry.Honor = CopyTable(hd);
	 	for i = 1, MAX_ARENA_TEAMS+1 do
	 		if (ad[i]) then
		 		entry["Arena"..i] = CopyTable(ad[i]);
	 		end
		end
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
	-- Hide Arena Teams
	for i = 1, MAX_ARENA_TEAMS+1 do
		wipe(ad[i]);
	end
	for i = 13, 24 do
		labels[i]:SetText("---");
	end
end

--------------------------------------------------------------------------------------------------------
--                                             PvP Stuff                                              --
--------------------------------------------------------------------------------------------------------

-- Load Honor Normal
function mod:LoadHonorNormal()
	self:HasData(true);
	-- Query -- Az: Even if inspecting ourself, use inspect data as GetPVPYesterdayStats() is bugged as of (4.0.1 - 4.0.3a)
	if (not ex.isSelf) or (HasInspectHonorData()) then
		hd.todayHK, hd.todayHonor, hd.yesterdayHK, hd.yesterdayHonor, hd.lifetimeHK, hd.lifetimeRank = GetInspectHonorData();
	else
		hd.todayHK, hd.todayHonor = GetPVPSessionStats();
		hd.yesterdayHK, hd.yesterdayHonor = GetPVPYesterdayStats();
		hd.lifetimeHK, hd.lifetimeRank = GetPVPLifetimeStats();
	end
	-- Update
	self:UpdateHonor();
end

-- Honor Update
function mod:UpdateHonor()
	-- Show Rank
	if (hd.lifetimeRank ~= 0) then
		self.rankIcon.texture:SetTexture("Interface\\PvPRankBadges\\PvPRank"..format("%.2d",hd.lifetimeRank - 4));
		self.rankIcon.texture:SetTexCoord(0,1,0,1);
		--self.rankIcon.tip = format("%s (Rank %d)",GetPVPRankInfo(hd.lifetimeRank,ex.unit),(hd.lifetimeRank - 4));
		self.rankIcon.tip = format("Rank %d",hd.lifetimeRank - 4);	-- 5.4: GetPVPRankInfo() func removed, can no longer get the rank name, not sure if lifetimeRank still returns valid?
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

-- Load Arena Teams Normal
function mod:LoadArenaTeamsNormal()
	for i = 1, MAX_ARENA_TEAMS+1 do
		local arenaRating, seasonPlayed, seasonWon, weeklyPlayed, weeklyWon = GetInspectArenaData(i);
		ad[i] = { arenaRating, seasonWon, seasonPlayed };
	end
	self:ArenaTeamUpdate();
end

-- Arena Team Update
function mod:ArenaTeamUpdate()
	for i = 1, MAX_ARENA_TEAMS+1 do
		local at = ad[i];
		labels[13+((i-1)*3)]:SetText(at[1]);
		labels[14+((i-1)*3)]:SetText(at[2]);
		labels[15+((i-1)*3)]:SetText(at[3]);
	end
end

--------------------------------------------------------------------------------------------------------
--                                           Widget Creation                                          --
--------------------------------------------------------------------------------------------------------

-- Rank Icon
mod.rankIcon = CreateFrame("Frame",nil,mod.page);
mod.rankIcon:SetPoint("TOPLEFT",12,-12);
mod.rankIcon:SetSize(18,18);
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

-- Arena Labels
for i = 1, 15 do
	local l = mod.page:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
	l:SetWidth(70);

	if (i <= 3) then
		l:SetText(i == 1 and "Rating" or i == 2 and "Won" or "Played");
		l:SetTextColor(0.5,0.75,1);
	else
		l:SetTextColor(1,1,0);
	end

	if ((i - 1) % 3 == 0) then
		l:SetPoint("TOP",-28,-36 - (i - 1) / 3 * 12 - 42);
	else
		l:SetPoint("LEFT",labels[i + 9 - 1],"RIGHT");
	end

	labels[i+9] = l;
end

-- Arena Label Side Headers
local t = mod.page:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
t:SetPoint("RIGHT",labels[13],"LEFT");
t:SetWidth(70);
t:SetJustifyH("LEFT");
t:SetText("2v2");
t:SetTextColor(0.5,0.75,1);

t = mod.page:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
t:SetPoint("RIGHT",labels[16],"LEFT");
t:SetWidth(70);
t:SetJustifyH("LEFT");
t:SetText("3v3");
t:SetTextColor(0.5,0.75,1);

t = mod.page:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
t:SetPoint("RIGHT",labels[19],"LEFT");
t:SetWidth(70);
t:SetJustifyH("LEFT");
t:SetText("5v5");
t:SetTextColor(0.5,0.75,1);

t = mod.page:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
t:SetPoint("RIGHT",labels[22],"LEFT");
t:SetWidth(70);
t:SetJustifyH("LEFT");
t:SetText("RBGs");
t:SetTextColor(0.5,0.75,1);