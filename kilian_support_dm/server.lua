-- server.lua

ESX = exports["es_extended"]:getSharedObject()

local webhookURL = "https://discord.com/api/webhooks/"

-- Allowed groups + colors
local groupSettings = {
    leitung = "#FF0000",   -- Red
    suadmin = "#FF8000",   -- Orange
    admin = "#FFD700",     -- Gold
    dev = "#00BFFF",       -- Blue
    mod = "#C71585"        -- Pink
}

RegisterCommand("dm", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local group = xPlayer.getGroup()
    local color = groupSettings[group]

    if not color then
        TriggerClientEvent("notifications", source, "#FF0000", "Support - Message", "You are not authorized to use this command!", 5000)
        return
    end

    local targetId = tonumber(args[1])
    if not targetId or not GetPlayerName(targetId) then
        TriggerClientEvent("notifications", source, "#FF0000", "Support - Message", "Invalid player ID!", 5000)
        return
    end

    local msg = table.concat(args, " ", 2)
    if msg == "" then
        TriggerClientEvent("notifications", source, "#FF0000", "Support - Message", "Please enter a message!", 5000)
        return
    end

    local senderName = GetPlayerName(source)
    local fullMessage = "" .. msg

    -- Send to target player
    TriggerClientEvent("kilian:dm:showNotification", targetId, color, fullMessage)

    -- Confirmation to sender
    TriggerClientEvent("notifications", source, "#00FF00", "Support - Message", "Message successfully sent to player ID " .. targetId .. ". ✅", 5000)

    -- Discord logging with emoji and timestamp
    sendToDiscord("📩 New Message", 
        "**👤 From:** " .. senderName .. " (ID: " .. source .. ")\n" ..
        "**🎯 To:** " .. GetPlayerName(targetId) .. " (ID: " .. targetId .. ")\n\n" ..
        "**💬 Message:**\n" .. msg .. "\n\n" ..
        "**🕒 Time:** " .. os.date("%d.%m.%Y - %H:%M:%S") .. " ", 
        color
    )
end)

-- Function: Send to Discord webhook
function sendToDiscord(title, message, color)
    local embed = {
        {
            ["title"] = title,
            ["description"] = message,
            ["color"] = tonumber(color:gsub("#", ""), 16),
            ["footer"] = {
                ["text"] = "Kilians - DM System"
            }
        }
    }

    PerformHttpRequest(webhookURL, function(err, text, headers) end, "POST", json.encode({
        username = "Kilians - Team Message",
        embeds = embed,
        avatar_url = ""
    }), { ["Content-Type"] = "application/json" })
end
