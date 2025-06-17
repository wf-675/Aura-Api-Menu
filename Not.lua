print("Loaded Successfully ✅")

RegisterCommand("notif", function()
    SendNUIMessage({ type = "showNotif" })
end)

RegisterKeyMapping("notif", "Show Notif", "keyboard", "J")
