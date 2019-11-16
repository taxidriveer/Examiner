local ex = Examiner;
local cfg;

-- Module
local mod = ex:CreateModule(PVP,PLAYER_V_PLAYER);
mod.help = "Honor Details";
mod:CreatePage(false,PLAYER_V_PLAYER);
mod:HasButton(true);
mod.canCache = true;

-- Variables
local labels = {};

-- Data Variables
local hd = {};
local ad = { {}, {}, {} };

-- Config
mod:AddOption({ var = "pvpbutton", default = false, label = "Display PvP Tab", tip = "If enabled Examiner will display the PvP tab." });


--------------------------------------------------------------------------------------------------------
--                                           Module Scripts                                           --
--------------------------------------------------------------------------------------------------------

-- OnInitialize
function mod:OnInitialize()
	cfg = ex.cfg;
end

-- OnConfigChanged
function mod:OnConfigChanged()
	if cfg.pvpbutton then
		mod:HasButton(true);
	else
		mod:HasButton(false);
	end
end

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

-- ShowTab
function mod:ShowTab()
	mod:HasButton(false);
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
	for i = 1, 32 do
		if (i == 1 or i == 7 or i == 13 or i == 19 or i == 27) then
			labels[i]:SetTextColor(1,1,0);
			labels[i]:SetFont(GameFontNormal:GetFont(),12);
		end
		-- labels[i]:SetText("---");
	end
end

--------------------------------------------------------------------------------------------------------
--                                             PvP Stuff                                              --
--------------------------------------------------------------------------------------------------------

-- Format Numbers
local function FormatNumbers(self,value,max)
	local color = (value == 0 and "|cffff8080" or "|cffffff5D");
	if (max == 0) then
		self:SetFormattedText("%s0|r (%1$s0%%|r)",color);
	else
		self:SetFormattedText("%s%d|r (%s%.1f%%|r)",color,value,color,value / max * 100);
	end
end

-- Load Honor Normal
function mod:LoadHonorNormal()
	self:HasData(true);
		hd.todayHK, hd.todayDK, hd.yesterdayHK, hd.yesterdayHonor, hd.thisweekHK, hd.thisweekHonor, hd.lastweekHK, hd.lastweekHonor, hd.lastweekStanding, hd.lifetimeHK, hd.lifetimeDK, hd.lifetimeRank = GetInspectHonorData();
		rankName, rankNumber = GetPVPRankInfo(UnitPVPRank("target"));
		if ( not rankName ) then
		rankName = NONE;
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
		self.rankIcon.tip = format("%s (Rank %d)",GetPVPRankInfo(hd.lifetimeRank,ex.unit),(hd.lifetimeRank - 4));
		self.rankIcon:Show();
	end
	-- Show Kills/Honor
	labels[1]:SetText("Today");
	labels[3]:SetText("Honorable Kills");
	labels[4]:SetText("|cff80ff80" .. hd.todayHK);
	labels[5]:SetText("Dishonorable Kills");
	labels[6]:SetText("|cffff6060" .. hd.todayDK);
	labels[7]:SetText("Yesterday");
	labels[9]:SetText("Honorable Kills");
	labels[10]:SetText("|cff80ff80" .. hd.yesterdayHK);
	labels[11]:SetText("Honor");
	labels[12]:SetText("|cffffff5D" .. hd.yesterdayHonor);
	labels[13]:SetText("This Week");
	labels[15]:SetText("Honorable Kills");
	labels[16]:SetText("|cff80ff80" .. hd.thisweekHK);
	labels[17]:SetText("Honor");
	labels[18]:SetText("|cffffff5D" .. hd.thisweekHonor);
	labels[19]:SetText("Last Week");
	labels[21]:SetText("Honorable Kills");
	labels[22]:SetText("|cff80ff80" .. hd.lastweekHK);
	labels[23]:SetText("Honor");
	labels[24]:SetText("|cffffff5D" .. hd.lastweekHonor);
	labels[25]:SetText("Standing");
	labels[26]:SetText("|cffffff5D" .. hd.lastweekStanding);
	labels[27]:SetText("Life Time");
	labels[29]:SetText("Honorable Kills");
	labels[30]:SetText("|cff80ff80" .. hd.lifetimeHK);
	labels[31]:SetText("Dishonorable Kills");
	labels[32]:SetText("|cffff6060" .. hd.lifetimeDK);	
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

-- Rank Bar
-- mod.rankBar = CreateFrame("Frame",nil,mod.page);
-- mod.rankBar:SetPoint("TOPLEFT",12,-12);
-- mod.rankBar:SetWidth(500);
-- mod.rankBar:SetHeight(50);
-- mod.rankBar:EnableMouse(1);
-- mod.rankBar:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Factions.blp");
-- mod.rankBar:Show();
-- mod.rankBar:SetText("yo");


-- Honor Labels
for i = 1, 32 do
	local l = mod.page:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
	l:SetWidth(150);
	-- l:SetText("---");
	-- l:SetPoint("TOP",-28,-36 - (i - 1) / 2 * 12);
	-- l:SetPoint("LEFT",labels[i - 1],"RIGHT");
	-- labels[i] = l;

	-- if (i <= 3) then
		-- l:SetText(i == 1 and "Honor Kills" or i == 2 and "Honor Points" or "Dis. Kills");
		-- l:SetTextColor(0.5,0.75,1);
	-- else
		-- l:SetTextColor(1,1,0);
	-- end

	if ((i - 1) % 2 == 0) then
		l:SetPoint("TOP",-27,-67 - (i - 1) / 3 * 20,"LEFT");
		l:SetJustifyH("LEFT");
	else
		l:SetPoint("LEFT",labels[i - 1],"RIGHT");
		l:SetWidth(50);
		l:SetJustifyH("RIGHT");
	end

	labels[i] = l;
end