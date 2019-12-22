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
	mod.rankBar:Hide();
	ex:RequestHonorData();
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

-- Round numbers
function round(number, decimals)
    return (("%%.%df"):format(decimals)):format(number)
end

--------------------------------------------------------------------------------------------------------
--                                             PvP Stuff                                              --
--------------------------------------------------------------------------------------------------------

-- Load Honor Normal
function mod:LoadHonorNormal()
	self:HasData(true);
		-- Get Honor values
		hd.todayHK, hd.todayDK, hd.yesterdayHK, hd.yesterdayHonor, hd.thisweekHK, hd.thisweekHonor, hd.lastweekHK, hd.lastweekHonor, hd.lastweekStanding, hd.lifetimeHK, hd.lifetimeDK, hd.lifetimeRank = GetInspectHonorData();
		-- Get Rank Progress
		hd.rankProgress = round((GetInspectPVPRankProgress() * 100),2)
		-- Get Highest Rank Name
		hd.lifetimeHighestRankName = GetPVPRankInfo(hd.lifetimeRank)
		if not hd.lifetimeHighestRankName then
			hd.lifetimeHighestRankName = COMBAT_TEXT_NONE
		end
		-- Get Current Rank Name
		if ex.unit == "target" then
			hd.rankName, hd.rankNumber = GetPVPRankInfo(UnitPVPRank("target"));
		elseif ex.unit == "mouseover" then
			hd.rankName, hd.rankNumber = GetPVPRankInfo(UnitPVPRank("mouseover"));
		end
		if not hd.rankName then
			hd.rankName = COMBAT_TEXT_NONE
			hd.rankNumber = 0
			hd.rankProgress = 0
		end	
	-- Update
	self:UpdateHonor();
end

-- Honor Update
function mod:UpdateHonor()
	-- Show Rank Bar Progress
	mod.rankBar:SetValue(hd.rankProgress)
	mod.rankBar.Text:SetText(hd.rankName .. " (" .. RANK .. " " .. hd.rankNumber .. ")")
	mod.rankBar.tip = ACHIEVEMENT_CATEGORY_PROGRESS .. ": " .. hd.rankProgress .. "%"
	mod.rankBar:Show();
	
	-- Show Icon with Current Rank
	if (hd.rankNumber ~= 0) then
		self.rankIcon.texture:SetTexture("Interface\\PvPRankBadges\\PvPRank"..format("%.2d",hd.rankNumber));
		self.rankIcon.texture:SetTexCoord(0,1,0,1);
		self.rankIcon.tip = format("%s (Rank %d)",hd.rankName,(hd.rankNumber));
		self.rankIcon:Show();
	end
	
	-- Show Kills/Honor
	labels[1]:SetText(HONOR_TODAY .. ":");
	labels[3]:SetText(HONORABLE_KILLS);
	labels[4]:SetText("|cff80ff80" .. hd.todayHK);
	labels[5]:SetText(DISHONORABLE_KILLS);
	labels[6]:SetText("|cffff6060" .. hd.todayDK);
	labels[7]:SetText(HONOR_YESTERDAY .. ":");
	labels[9]:SetText(HONORABLE_KILLS);
	labels[10]:SetText("|cff80ff80" .. hd.yesterdayHK);
	labels[11]:SetText(HONOR);
	labels[12]:SetText("|cffffff5D" .. hd.yesterdayHonor);
	labels[13]:SetText(ARENA_THIS_WEEK .. ":");
	labels[15]:SetText(HONORABLE_KILLS);
	labels[16]:SetText("|cff80ff80" .. hd.thisweekHK);
	labels[17]:SetText(HONOR);
	labels[18]:SetText("|cffffff5D" .. hd.thisweekHonor);
	labels[19]:SetText(HONOR_LASTWEEK .. ":");
	labels[21]:SetText(HONORABLE_KILLS);
	labels[22]:SetText("|cff80ff80" .. hd.lastweekHK);
	labels[23]:SetText(HONOR);
	labels[24]:SetText("|cffffff5D" .. hd.lastweekHonor);
	labels[25]:SetText(HONOR_STANDING);
	labels[26]:SetText("|cffffff5D" .. hd.lastweekStanding);
	labels[27]:SetText(HONOR_LIFETIME .. ":");
	labels[29]:SetText(HONORABLE_KILLS);
	labels[30]:SetText("|cff80ff80" .. hd.lifetimeHK);
	labels[31]:SetText(DISHONORABLE_KILLS);
	labels[32]:SetText("|cffff6060" .. hd.lifetimeDK);	
	labels[33]:SetText(HONOR_HIGHEST_RANK);	
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
mod.rankIcon:SetFrameStrata("HIGH");
-- mod.rankIcon:SetScript("OnEnter",function(self) GameTooltip:SetOwner(self,"ANCHOR_BOTTOMRIGHT"); GameTooltip:SetText(self.tip) end)
-- mod.rankIcon:SetScript("OnLeave",ex.HideGTT);
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
mod.rankBar:SetStatusBarColor(0.4, 0.4, 0.7)
mod.rankBar:SetMinMaxValues(rankStart, rankEnd)
mod.rankBar:SetScript("OnEnter",function(self) GameTooltip:SetOwner(self,"ANCHOR_BOTTOMRIGHT"); GameTooltip:SetText(self.tip) end)
mod.rankBar:SetScript("OnLeave",ex.HideGTT);
mod.rankBar.Text = mod.rankBar:CreateFontString(nil,"ARTWORK") 
mod.rankBar.Text:SetFont(GameFontNormal:GetFont(), 13, "OUTLINE")
mod.rankBar.Text:SetPoint("CENTER",0,0)
mod.rankBar.Text:SetTextColor(1,1,0);
mod.rankBar.Border = CreateFrame("Frame", nil, mod.rankBar)
mod.rankBar.Border:SetPoint("TOPLEFT", mod.rankBar, "TOPLEFT", -2, 2)
mod.rankBar.Border:SetPoint("BOTTOMRIGHT", mod.rankBar, "BOTTOMRIGHT", 2, -2)
mod.rankBar.Border:SetBackdrop({ 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = false, edgeSize = 10, 
	insets = { left = -1, right = -1, top = -1, bottom = -1}
})
mod.rankBar.Border:SetFrameLevel(mod.rankBar:GetFrameLevel() -1)
mod.rankBar.Border:SetBackdropBorderColor(0.6, 0.6, 0.8, 0.4)
	
-- Honor Labels
for i = 1, 34 do
	local l = mod.page:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
	l:SetWidth(125);
	labels[i] = l;
	-- Configure table left and right column
	if ((i - 1) % 2 == 0) then
		if (i == 1) then
			l:SetPoint("BOTTOMLEFT", mod.rankBar, "BOTTOMLEFT", -6, -25);
			labels[i]:SetTextColor(0.5,0.75,1);
			labels[i]:SetFont(GameFontNormal:GetFont(),11);	
		else 
			-- Titles and data
			if (i == 7 or i == 13 or i == 19 or i == 27) then
				l:SetPoint("BOTTOMLEFT", labels[i - 2], "BOTTOMLEFT", 0, -19);
				labels[i]:SetTextColor(0.5,0.75,1);
				labels[i]:SetFont(GameFontNormal:GetFont(),11);	
			else
				l:SetPoint("BOTTOMLEFT", labels[i - 2], "BOTTOMLEFT", 0, -11.5);
				labels[i]:SetFont(GameFontNormal:GetFont(),10);
			end
		end
		l:SetJustifyH("LEFT");
	else
		l:SetPoint("LEFT", labels[i - 1], "RIGHT");
		l:SetWidth(90);
		l:SetJustifyH("RIGHT");
	end
end