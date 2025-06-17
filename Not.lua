-- تأكد من إن الإكزكيوتر يدعم NUI/WebView

-- رابط ملف HTML اللي رفعته
local htmlURL = "https://raw.githubusercontent.com/wf-675/Aura-Api-Menu/refs/heads/main/index.html"

-- إنشاء DUI (واجهة عرض HTML داخل اللعبة)
local duiObj = CreateDui(htmlURL, 600, 400)
local dui = GetDuiHandle(duiObj)

-- إنشاء Textures للعرض
local txd = CreateRuntimeTxd("notif_texture")
local duiTex = CreateRuntimeTextureFromDuiHandle(txd, "notif_page", dui)

-- عرض الواجهة على HUD دائمًا
Citizen.CreateThread(function()
    while true do
        DrawSprite("notif_texture", "notif_page", 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
        Wait(0)
    end
end)

-- الأمر اللي يرسل إشعار (زر U)
RegisterCommand("show_u_notif", function()
    SendNUIMessage({ type = "showNotif" })
end)

RegisterKeyMapping("show_u_notif", "Show Notification", "keyboard", "U")
