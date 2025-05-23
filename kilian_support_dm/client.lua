-- client.lua

RegisterNetEvent("kilian:dm:showNotification", function(color, message)
    TriggerEvent("notifications", color, "Support - Message", message, 8000)
end)
