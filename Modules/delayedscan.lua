-- This module fixes the issue with uncached items after inspection.
-- After an inspect request is sent, the recieved INSPECT_READY event doesn't mean that items are cached yet.
-- This creates an issue where in most cases, not all items were available to Examiner for scanning.
-- By creating a delay (currently 0.5 sec), we give extra time for WoW to precache these items, so they are ready for scanning by Examiner.

local ex = Examiner;

-- Module
local mod = ex:CreateModule("DelayedScan",nil);

-- Options
mod:AddOption({ var = "delayedScanFix", default = true, label = "Delayed Gear Scan Fix", tip = "Causes a delayed gear scan of 0.5 seconds, potentially fixing items not showing up on the first inspect" });

-- Objects
local frmTimer = CreateFrame("Frame");

-- Variables
local DELAYED_AMOUNT = 0.25;		-- Increase this if delay is not long enough to cache all items. Az: Perhaps dynamically get this value from a multiplical of latency in GetNetStats()?
local applyDelay = false;
local delayTimer;

--------------------------------------------------------------------------------------------------------
--                                           Module Scripts                                           --
--------------------------------------------------------------------------------------------------------

function mod:OnInspect(unit,guid)
	applyDelay = ex.cfg.delayedScanFix and not ex.isSelf;		-- Do not apply delay if player is inspecting self
end

function mod:OnInspectReady(unit,guid)
	if (applyDelay) then
		applyDelay = false;
		delayTimer = 0;
		frmTimer:Show();
	end
end

--------------------------------------------------------------------------------------------------------
--                                            Timer Frame                                             --
--------------------------------------------------------------------------------------------------------

local function OnUpdate(self,elapsed)
	delayTimer = (delayTimer + elapsed);
	if (delayTimer >= DELAYED_AMOUNT) then
		self:Hide();
		ex:InspectReady(ex.guid);
	end
end

frmTimer:SetScript("OnUpdate",OnUpdate);
frmTimer:Hide();