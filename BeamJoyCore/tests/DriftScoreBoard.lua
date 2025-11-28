package.path = package.path .. ";../?.lua;../?/init.lua;../?/?.lua"

local t = require("tests/CommonTests")
local DriftScoreBoard = require("scenarii/DriftScoreBoard")

t.test("DriftScoreBoard syncs participants and starts at zero", function()
    local board = DriftScoreBoard.new()
    board:syncParticipants({ 1, 2, 3 })

    t.expect(board:getScore(1), 0)
    t.expect(board:getScore(2), 0)
    t.expect(board:getScore(3), 0)
end)

t.test("DriftScoreBoard increments only tracked players", function()
    local board = DriftScoreBoard.new()
    board:syncParticipants({ 5, 6 })

    board:addScore(5, 120)
    board:addScore(6, 30.5)
    board:addScore(7, 9000) -- ignored
    board:addScore(6, -5)   -- ignored

    t.expect(board:getScore(5), 120)
    t.expect(board:getScore(6), 30.5)
    t.expect(board:getScore(7), 0)
end)

t.test("DriftScoreBoard removes and resets scores when syncing", function()
    local board = DriftScoreBoard.new()
    board:syncParticipants({ 10, 11 })

    board:addScore(10, 50)
    board:addScore(11, 25)

    board:syncParticipants({ 11, 12 })

    t.expect(board:getScore(10), 0)
    t.expect(board:getScore(11), 25)
    t.expect(board:getScore(12), 0)

    board:resetScores()
    t.expect(board:getScore(11), 0)
    t.expect(board:getScore(12), 0)
end)
