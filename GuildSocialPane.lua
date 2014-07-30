GuildSocialPane = LibStub("AceAddon-3.0"):NewAddon("GuildSocialPane","AceHook-3.0","AceEvent-3.0");
local core = GuildSocialPane;

function core:OnInitialize()
	LoadAddOn("Blizzard_GuildUI");
	tinsert(FRIENDSFRAME_SUBFRAMES,"GuildRosterFrame");
end

function core:OnEnable()
	--create new button
	local tab = CreateFrame("Button","FriendsFrameTab5",FriendsFrame,"FriendsFrameTabTemplate");
	tab:SetText("Guild");
	tab:SetID(5);
	
	--add tab to Friends Frame in original location
	PanelTemplates_SetNumTabs(FriendsFrame,5);
	PanelTemplates_UpdateTabs(FriendsFrame);
	tab:SetPoint("LEFT",FriendsFrameTab2,"RIGHT",-15,0);
	FriendsFrameTab3:SetPoint("LEFT",FriendsFrameTab5,"RIGHT",-15,0);
	FriendsFrameTab4:SetPoint("LEFT",FriendsFrameTab3,"RIGHT",-15,0);
	
	self:Hook("FriendsFrame_Update",true);
	self:HookScript(GuildFrame,"OnShow","GuildFrame_OnShow");
end

function core:OnDisable()
	
end

function core:FriendsFrame_Update()
	GuildRosterFrame:ClearAllPoints();
	GuildRosterFrame:SetParent("FriendsFrame");
	GuildRosterFrame:SetPoint("TOPLEFT",FriendsFrame,"TOPLEFT");
	GuildRosterFrame:SetPoint("BOTTOMRIGHT",FriendsFrame,"BOTTOMRIGHT");
	
	--allows updates to show while display roster in FriendsFrame
	GuildRoster(); --unsure when calling this is necessary
	
	--fit stuff to friends frame
	GuildRosterViewDropdown:SetPoint("TOPRIGHT",-48,-48);
	GuildRosterContainer:SetPoint("TOPRIGHT",-60,-107);
	GuildRosterColumnButton1:SetPoint("TOPLEFT",19,-80);
	GuildRosterShowOfflineButton:SetPoint("BOTTOMLEFT",16,80);
	GuildRosterShowOfflineButton:SetFrameLevel(20);
	GuildRosterShowOfflineButton:SetChecked(GetGuildRosterShowOffline());
	
	if(FriendsFrame.selectedTab == 5) then
		--set texture
		FriendsFrameTopLeft:SetTexture("Interface\\AddOns\\GuildSocialPane\\Textures\\UI-GuildSocialPane-TopLeft");
		FriendsFrameTopRight:SetTexture("Interface\\AddOns\\GuildSocialPane\\Textures\\UI-GuildSocialPane-TopRight");
		FriendsFrameBottomLeft:SetTexture("Interface\\AddOns\\GuildSocialPane\\Textures\\UI-GuildSocialPane-BotLeft");
		FriendsFrameBottomRight:SetTexture("Interface\\AddOns\\GuildSocialPane\\Textures\\UI-GuildSocialPane-BotRight");
	
		--set up 3.0 interface style title
		local guildName,guildRankName,guildRankIndex = GetGuildInfo("player");
		FriendsFrameTitleText:SetText(guildRankName .. " of " .. guildName);	--localize

		--display the guild roster frame
		FriendsFrame_ShowSubFrame("GuildRosterFrame");
	end
end

function core:GuildFrame_OnShow()
	--put stuff back
	GuildRosterFrame:SetParent("GuildFrame");
	GuildRosterFrame:ClearAllPoints();
	GuildRosterFrame:SetPoint("TOPLEFT",GuildFrame,"TOPLEFT");
	GuildRosterFrame:SetPoint("BOTTOMRIGHT",GuildFrame,"BOTTOMRIGHT");
	GuildRosterFrame:Hide();
	
	GuildRosterViewDropdown:SetPoint("TOPRIGHT",-12,-34);
	GuildRosterContainer:SetPoint("TOPRIGHT",-27,-95);
	GuildRosterColumnButton1:SetPoint("TOPLEFT",7,-68);
	GuildRosterShowOfflineButton:SetPoint("BOTTOMLEFT",6,3);
	
	
	GuildRoster(); --unsure when calling this is necessary
end
