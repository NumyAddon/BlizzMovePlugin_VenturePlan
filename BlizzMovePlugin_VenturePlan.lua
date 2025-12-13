local name = ...;
--- @type BlizzMoveAPI
local BlizzMoveAPI = _G.BlizzMoveAPI;

local compatible = false;
if BlizzMoveAPI and BlizzMoveAPI.GetVersion and BlizzMoveAPI.RegisterAddOnFrames then
    local versionInt = select(5, BlizzMoveAPI:GetVersion());
    if not versionInt or versionInt >= 30200 then
        compatible = true;
    end
end

if not compatible then
    print(name .. ' is not compatible with the current version of BlizzMove, please update.')

    return;
end

local missionPageTable = {};
local addonTable = {
    ['Blizzard_GarrisonUI'] = {
        ["CovenantMissionFrame"] = {
            SubFrames = {
                ["BlizzMovePlugin_VenturePlan.MainFrame"] = missionPageTable,
            },
        },
    },
};

local VPEX_OnUIObjectCreated_old = VPEX_OnUIObjectCreated or nil;
VPEX_OnUIObjectCreated = function(objectType, createdUIObject, shadowTablePeekFunc)
    if objectType == 'MissionPage' then
        missionPageTable.FrameReference = createdUIObject;
        BlizzMoveAPI:RegisterAddOnFrames(addonTable);
    end
    if VPEX_OnUIObjectCreated_old then VPEX_OnUIObjectCreated_old(objectType, createdUIObject, shadowTablePeekFunc); end
end;

