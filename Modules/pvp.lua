local ex = Examiner;
local cfg;

-- Module
local mod = ex:CreateModule(PVP,PLAYER_V_PLAYER);
mod.help = "Honor Details";
mod:CreatePage(false);
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
	for i = 1, 34 do
		labels[i]:SetText("");
	end
end

--------------------------------------------------------------------------------------------------------
--                                             PvP Stuff                                              --
--------------------------------------------------------------------------------------------------------

-- Load Honor Normal
function mod:LoadHonorNormal()
	self:HasData(true);
		-- Get Honor values
		hd.todayHK, hd.todayDK, hd.yesterdayHK, hd.yesterdayHonor, hd.thisweekHK, hd.thisweekHonor, hd.lastweekHK, hd.lastweekHonor, hd.lastweekStanding, hd.lifetimeHK, hd.lifetimeDK, hd.lifetimeRank = GetInspectHonorData();
		-- Get Highest Rank Name
		hd.lifetimeHighestRankName = GetPVPRankInfo(hd.lifetimeRank)
		if not hd.lifetimeHighestRankName then
			hd.lifetimeHighestRankName = "None"
		end
		-- Get Current Rank Name
		hd.rankName, hd.rankNumber = GetPVPRankInfo(UnitPVPRank("target"));
		if not hd.rankName then
			hd.rankName = "None"
		end	
		-- Format rankNumber
		if (hd.rankNumber ~= 0) then
			hd.rankNumber = hd.rankNumber - 4
		end
	-- Update
	self:UpdateHonor();
end

-- Honor Update
function mod:UpdateHonor()
	-- Show Rank Bar Progress
	local rankProgress = GetInspectPVPRankProgress()
	-- local rankProgress = 55
	mod.rankBar:SetValue(rankProgress)
	mod.rankText:SetText(hd.rankName .. " (Rank " .. hd.rankNumber .. ")")
	mod.rankBar.tip = "Progression " .. rankProgress .. "%"
	
	-- Show Icon with Current Rank
	if (hd.rankNumber ~= 0) then
		self.rankIcon.texture:SetTexture("Interface\\PvPRankBadges\\PvPRank"..format("%.2d",hd.rankNumber));
		self.rankIcon.texture:SetTexCoord(0,1,0,1);
		self.rankIcon.tip = format("%s (Rank %d)",hd.rankName,(hd.rankNumber));
		self.rankIcon:Show();
	end
	
	-- Show Kills/Honor
	labels[1]:SetText("Today:");
	labels[3]:SetText("Honorable Kills");
	labels[4]:SetText("|cff80ff80" .. hd.todayHK);
	labels[5]:SetText("Dishonorable Kills");
	labels[6]:SetText("|cffff6060" .. hd.todayDK);
	labels[7]:SetText("Yesterday:");
	labels[9]:SetText("Honorable Kills");
	labels[10]:SetText("|cff80ff80" .. hd.yesterdayHK);
	labels[11]:SetText("Honor");
	labels[12]:SetText("|cffffff5D" .. hd.yesterdayHonor);
	labels[13]:SetText("This Week:");
	labels[15]:SetText("Honorable Kills");
	labels[16]:SetText("|cff80ff80" .. hd.thisweekHK);
	labels[17]:SetText("Honor");
	labels[18]:SetText("|cffffff5D" .. hd.thisweekHonor);
	labels[19]:SetText("Last Week:");
	labels[21]:SetText("Honorable Kills");
	labels[22]:SetText("|cff80ff80" .. hd.lastweekHK);
	labels[23]:SetText("Honor");
	labels[24]:SetText("|cffffff5D" .. hd.lastweekHonor);
	labels[25]:SetText("Standing");
	labels[26]:SetText("|cffffff5D" .. hd.lastweekStanding);
	labels[27]:SetText("Lifetime:");
	labels[29]:SetText("Honorable Kills");
	labels[30]:SetText("|cff80ff80" .. hd.lifetimeHK);
	labels[31]:SetText("Dishonorable Kills");
	labels[32]:SetText("|cffff6060" .. hd.lifetimeDK);	
	labels[33]:SetText("Highest Rank");	
	labels[34]:SetText("|cffffff5D" .. hd.lifetimeHighestRankName);	
end


--------------------------------------------------------------------------------------------------------
--                                           Widget Creation                                          --
--------------------------------------------------------------------------------------------------------

-- Rank Icon
mod.rankIcon = CreateFrame("Frame",nil,mod.page);
mod.rankIcon:SetPoint("TOPLEFT",12,-16);
mod.rankIcon:SetWidth(18);
mod.rankIcon:SetHeight(18);
mod.rankIcon:EnableMouse(1);
mod.rankIcon:SetScript("OnEnter",function(self) GameTooltip:SetOwner(self,"ANCHOR_BOTTOMRIGHT"); GameTooltip:SetText(self.tip) end)
mod.rankIcon:SetScript("OnLeave",ex.HideGTT);
mod.rankIcon.texture = mod.rankIcon:CreateTexture(nil,"ARTWORK");
mod.rankIcon.texture:SetAllPoints();

-- Rank Bar
local rankStart = 0
local rankEnd = 100
mod.rankBar = CreateFrame("StatusBar",nil,mod.page);
mod.rankBar:SetPoint("TOPLEFT",17,-15);
mod.rankBar:SetWidth(200);
mod.rankBar:SetHeight(20);
mod.rankBar:EnableMouse(1);
mod.rankBar:SetBackdrop({bgFile = [[Interface\PaperDollInfoFrame\UI-Character-Skills-Bar]]})
mod.rankBar:SetBackdropColor(0.2, 0.2, 0.5, 0.45)
mod.rankBar:SetStatusBarTexture([[Interface\PaperDollInfoFrame\UI-Character-Skills-Bar]])
mod.rankBar:SetStatusBarColor(0.05, 0.15, 0.6)
mod.rankBar:SetMinMaxValues(rankStart, rankEnd)
mod.rankBar:SetScript("OnEnter",function(self) GameTooltip:SetOwner(self,"ANCHOR_BOTTOMRIGHT"); GameTooltip:SetText(self.tip) end)
mod.rankBar:SetScript("OnLeave",ex.HideGTT);
mod.rankText = mod.rankBar:CreateFontString(nil,"ARTWORK") 
mod.rankText:SetFont(GameFontNormal:GetFont(), 13, "OUTLINE")
mod.rankText:SetPoint("CENTER",0,0)
mod.rankText:SetTextColor(1,1,0);
mod.rankBar:Show();
mod.rankBar.border = CreateFrame("Frame", nil, mod.rankBar)
mod.rankBar.border:SetPoint("TOPLEFT", mod.rankBar, "TOPLEFT", -2, 2)
mod.rankBar.border:SetPoint("BOTTOMRIGHT", mod.rankBar, "BOTTOMRIGHT", 2, -2)
mod.rankBar.border:SetBackdrop({ 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = false, edgeSize = 10, 
	insets = { left = -1, right = -1, top = -1, bottom = -1}
})
mod.rankBar.border:SetFrameLevel(mod.rankBar:GetFrameLevel() -1)
mod.rankBar.border:SetBackdropBorderColor(0.6, 0.6, 0.8, 0.4)
	
-- Honor Labels
for i = 1, 34 do
	local l = mod.page:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
	l:SetWidth(110);

	if ((i - 1) % 2 == 0) then
		l:SetPoint("TOP",-50,-50 - (i - 1) / 3 * 20,"LEFT");
		l:SetJustifyH("LEFT");
	else
		l:SetPoint("LEFT",labels[i - 1],"RIGHT");
		l:SetWidth(100);
		l:SetJustifyH("RIGHT");
	end

	labels[i] = l;
	if (i == 1 or i == 7 or i == 13 or i == 19 or i == 27) then
		labels[i]:SetTextColor(0.5,0.75,1);
		labels[i]:SetFont(GameFontNormal:GetFont(),11);	
	end
end