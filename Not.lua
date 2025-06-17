RegisterCommand("notif", function()
    SendNUIMessage({ type = "showNotif" })
end)

RegisterKeyMapping("notif", "Show Notification", "keyboard", "J")
