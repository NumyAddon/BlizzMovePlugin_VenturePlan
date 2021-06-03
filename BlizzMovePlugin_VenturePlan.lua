-- upvalue the globals
local _G = getfenv(0);
local BlizzMoveAPI = _G.BlizzMoveAPI;

local name = ... or 'BlizzMovePlugin_VenturePlan';

_G.BlizzMovePlugin_VenturePlan = {};
local Plugin = _G.BlizzMovePlugin_VenturePlan;

local compatible = false;
if(BlizzMoveAPI and BlizzMoveAPI.GetVersion and BlizzMoveAPI.RegisterAddOnFrames) then
    local _, _, _, versionInt = BlizzMoveAPI:GetVersion()
    if (versionInt >= 30019 or versionInt == nil) then
        compatible = true;
    end
end

if(not compatible) then
    print(name .. ' is not compatible with the current version of BlizzMove, please update.')
end

Plugin.addonTable = {
    ['Blizzard_GarrisonUI'] = {
        ["CovenantMissionFrame"] = {
            MinVersion = 90000,
            SubFrames = {
                ["BlizzMovePlugin_VenturePlan.MainFrame"] = {
                    MinVersion = 90000,
                },
                ["CovenantMissionFrame.MissionTab.MissionList"] = {
                    MinVersion = 90000,
                },
                ["CovenantMissionFrame.MissionTab.MissionPage"] = {
                    MinVersion = 90000,
                },
                ["CovenantMissionFrame.MissionTab.ZoneSupportMissionPageBackground"] = {
                    MinVersion = 90000,
                },
                ["CovenantMissionFrame.MissionTab"] = {
                    MinVersion = 90000,
                },
                ["CovenantMissionFrame.MissionTab.MissionPage"] = {
                    MinVersion = 90000,
                },
                ["CovenantMissionFrame.MissionTab.MissionPage.CostFrame"] = {
                    MinVersion = 90000,
                },
                ["CovenantMissionFrame.MissionTab.MissionPage.StartMissionFrame"] = {
                    MinVersion = 90000,
                },
                ["CovenantMissionFrameMissions.MaterialFrame"] = {
                    MinVersion = 90000,
                },
                ["CovenantMissionFrameFollowersListScrollFrameScrollChild"] = {
                    MinVersion = 90000,
                },
                ["CovenantMissionFrameFollowers.MaterialFrame"] = {
                    MinVersion = 90000,
                },
            },
        },
    },
};

local VPEX_OnUIObjectCreated_old = VPEX_OnUIObjectCreated or nil;
VPEX_OnUIObjectCreated = function(objectType, createdUIObject, shadowTablePeekFunc)
    if (objectType == 'MissionPage') then
        Plugin.MainFrame = createdUIObject;
        BlizzMoveAPI:RegisterAddOnFrames(Plugin.addonTable);
    end
    if(VPEX_OnUIObjectCreated_old) then VPEX_OnUIObjectCreated_old(objectType, createdUIObject, shadowTablePeekFunc); end
end

