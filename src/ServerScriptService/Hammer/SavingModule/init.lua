--// Dependencies
local DataStoreService = game:GetService("DataStoreService");
local Players = game:GetService("Players")

--// Constants
local DATA_STORE_NAME = "BanDatastore"

--// Variables
local DataStore = DataStoreService:GetDataStore(DATA_STORE_NAME)
local DataKeys = { Regular = "%d-RegularBanData", Timed = "%d-TimedBanData" }
local DefaultDatas = {
    Regular = {
        IsBanned = false;
        Reason = "";
    };
    
    Timed = {
        Time = 0;
        Reason = "";
    }
}

--// Class
local SavingModule = {};
SavingModule.__index = SavingModule

--// Functions
function SavingModule.new(Type, RetryCount)
    local self = setmetatable({}, SavingModule)        
    self.MAX_RETRY_COUNT = RetryCount or 3;    
    self.TYPE = Type or "Regular";
    self.DATA_KEY = DataKeys[self.TYPE]
    self.Cache = {};

    self.Connection = Players.PlayerRemoving:Connect(function(Player)
        local CachedData = self.Cache[Player.UserId];

        if (CachedData) then
            self:PcallMethod("SetAsync", Player.UserId, CachedData);
            self.Cache[Player.UserId] = nil;
        end
    end)

    return self
end

function SavingModule:PcallMethod(DataStoreMethod, UserId, ...)
    local Key = string.format(self.DATA_KEY, UserId);
    local Success, Response = false, nil;
    local TryCount = 0;

    while (not Success and TryCount <= self.MAX_RETRY_COUNT) do
        if (TryCount >= 1) then
            wait(7);
        end

        TryCount = TryCount + 1;
        Success, Response = pcall(DataStore[DataStoreMethod], DataStore, Key, ...);
    end

    if (not Success) then
        warn("Unsuccessful", DataStoreMethod);
    end

    return Sucess, Response;
end

function SavingModule:Set(UserId, Value)
    local Player = Players:GetPlayerByUserId(UserId);

    if (Player) then
        self.Cache[UserId] = Value;
    else
        self:PcallMethod("SetAsync", UserId, Value);
    end
end

function SavingModule:Get(UserId)
    local Data = self.Cache[UserId];

    if (not Data) then
        Success, Data = self:PcallMethod("GetAsync", UserId);

        if (not Success) then
            Data = DefaultDatas[self.TYPE]
        end

        self.Cache[UserId] = Data;
    end

    return Data;
end

return SavingModule