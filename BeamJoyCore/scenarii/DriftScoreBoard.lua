---@class BJDriftScoreBoard
local DriftScoreBoard = {}
DriftScoreBoard.__index = DriftScoreBoard

---Create a new drift score board instance
---@return BJDriftScoreBoard
function DriftScoreBoard.new()
    return setmetatable({ scores = {} }, DriftScoreBoard)
end

---Synchronize tracked players with a new participants list
---@param participants integer[]
function DriftScoreBoard:syncParticipants(participants)
    local participantLookup = {}
    for _, pid in ipairs(participants or {}) do
        participantLookup[pid] = true
        if not self.scores[pid] then
            self.scores[pid] = 0
        end
    end

    for pid in pairs(self.scores) do
        if not participantLookup[pid] then
            self.scores[pid] = nil
        end
    end
end

---Reset every tracked participant score to zero
function DriftScoreBoard:resetScores()
    for pid in pairs(self.scores) do
        self.scores[pid] = 0
    end
end

---Add drift score for a player if they are tracked
---@param playerID integer
---@param driftScore number
function DriftScoreBoard:addScore(playerID, driftScore)
    if not self.scores[playerID] then
        return
    end

    driftScore = tonumber(driftScore) or 0
    if driftScore <= 0 then
        return
    end

    self.scores[playerID] = self.scores[playerID] + driftScore
end

---Get a drift score for a tracked player
---@param playerID integer
---@return number
function DriftScoreBoard:getScore(playerID)
    return self.scores[playerID] or 0
end

return DriftScoreBoard
