local ex = Examiner;

-- Module
local mod = ex:CreateModule(GUILD,GUILD_INFORMATION);
mod.help = "Basic Guild Details";
mod:CreatePage(false);
mod:HasButton(true);
mod.canCache = true;

local page = mod.page;
local banner = {};
local bannerCache;

local GUILD_LOGO_SCALE = 1.2;

--------------------------------------------------------------------------------------------------------
--                                           Module Scripts                                           --
--------------------------------------------------------------------------------------------------------

-- OnInspectReady
function mod:OnInspectReady(unit,guid)
	-- local bkgR, bkgG, bkgB, borderR, borderG, borderB, emblemR, emblemG, emblemB, emblemFilename = GetGuildLogoInfo(ex.unit);
	banner[1], banner[2], banner[3], banner[4], banner[5], banner[6], banner[7], banner[8], banner[9], banner[10] = GetGuildLogoInfo(ex.unit);
	self:HasData(ex.info.guildMembers);	-- WoD: Changed this from guildLevel to guildMembers, history repeats itself -- MoP: Changed this from guildID to guildLevel, as that is no longer available as 1st return in GetInspectGuildInfo()
	self:UpdateGuildInfo();
end

-- OnCache
function mod:OnCache(entry)
	if (self:CanCache()) then
		entry.GuildBanner = CopyTable(banner);
	end
end

-- OnCacheLoaded
function mod:OnCacheLoaded(entry,unit)
	bannerCache = entry.GuildBanner;
	self:HasData(ex.info.guildMembers);
	self:UpdateGuildInfo();
end

-- OnClearInspect
function mod:OnClearInspect()
	wipe(banner);
	bannerCache = nil;
	self:HasData(nil);
	self:UpdateGuildInfo();
end

--------------------------------------------------------------------------------------------------------
--                                                Code                                                --
--------------------------------------------------------------------------------------------------------

-- Update Widgets
function mod:UpdateGuildInfo()
	local page = self.page;
	local info = ex.info;
	if (not info.guildMembers) then
		page.guild:SetText();
		page.info:SetText();
		SetDoubleGuildTabardTextures(nil,mod.page.leftIcon,mod.page.rightIcon,mod.page.banner,mod.page.bannerBorder,banner);	-- banner table should be empty here, so we draw a grey banner
	else
		page.guild:SetText(info.guild);
		page.info:SetFormattedText("%s Points - %s %s",tostring(info.guildPoints),info.guildMembers,MEMBERS);

		local bannerData = (ex.isCacheEntry and bannerCache or banner);
		SetDoubleGuildTabardTextures(nil,mod.page.leftIcon,mod.page.rightIcon,mod.page.banner,mod.page.bannerBorder,bannerData);
	end
end

--------------------------------------------------------------------------------------------------------
--                                               Widgets                                              --
--------------------------------------------------------------------------------------------------------

-- FontStrings
page.guild = page:CreateFontString(nil,"ARTWORK");
page.guild:SetPoint("CENTER",0,-54);
page.guild:SetFont(GameFontNormal:GetFont(),18,"OUTLINE");
page.guild:SetTextColor(1,1,1);

page.info = page:CreateFontString(nil,"ARTWORK");
page.info:SetPoint("TOP",page.guild,"BOTTOM");
page.info:SetFont(GameFontNormal:GetFont(),12,"OUTLINE");
page.info:SetTextColor(1,1,0);

-- Banner
page.banner = page:CreateTexture(nil,"BACKGROUND",nil,1);
page.banner:SetSize(118 * GUILD_LOGO_SCALE,144 * GUILD_LOGO_SCALE);
page.banner:SetPoint("TOP",0,-6);
page.banner:SetTexture("Interface\\GuildFrame\\GuildInspect-Parts");
page.banner:SetTexCoord(0.23632813,0.46679688,0.70117188,0.98242188);

page.bannerBorder = page:CreateTexture(nil,"BACKGROUND",nil,2);
page.bannerBorder:SetSize(118 * GUILD_LOGO_SCALE,144 * GUILD_LOGO_SCALE);
page.bannerBorder:SetPoint("TOPLEFT",page.banner);
page.bannerBorder:SetTexture("Interface\\GuildFrame\\GuildInspect-Parts");
page.bannerBorder:SetTexCoord(0.00195313,0.23242188,0.70117188,0.98242188);

-- Banner Icons
page.leftIcon = page:CreateTexture(nil,"ARTWORK");
page.leftIcon:SetSize(50 * GUILD_LOGO_SCALE,125 * GUILD_LOGO_SCALE);
page.leftIcon:SetPoint("CENTER",page.banner,-25 * GUILD_LOGO_SCALE,0);
page.leftIcon:SetTexCoord(1,0,0,1);

page.rightIcon = page:CreateTexture(nil,"ARTWORK");
page.rightIcon:SetSize(50 * GUILD_LOGO_SCALE,125 * GUILD_LOGO_SCALE);
page.rightIcon:SetPoint("LEFT",page.leftIcon,"RIGHT",-1,0);