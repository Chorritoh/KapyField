-- Get the name of the current game
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

-- Define a table to store game ids and their corresponding loadstring functions
local GameLoadStrings = {
    ["3104101863"] = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Chorritoh/KapyHub/main/source/SupportedGames/MichaelZombies/versions/1.0.2/MichaelZombies.lua"))()
    end,
    -- Add more games as needed in the same format
}

-- Function to get the current game id
local function GetGameId()
    return game.GameId
end

-- Function to detect and execute the loadstring based on the current game id
local function DetectAndExecuteLoadString()
    local gameId = GetGameId()
    local loadstringFunc = GameLoadStrings[tostring(gameId)]
    
    if loadstringFunc then
        loadstringFunc()
    else
        warn("No code found for game: " .. GameName .. " with game id: " .. gameId)
    end
end

-- Execute the main function
DetectAndExecuteLoadString()
