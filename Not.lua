-- رابط واجهة HTML
local url = "https://raw.githubusercontent.com/wf-675/Aura-Api-Menu/refs/heads/main/index.html"

-- إنشاء DUI وعرضها داخل اللعبة
local dui = CreateDui(url, 600, 400)
local handle = GetDuiHandle(dui)

-- نربط الـ DUI كـ Texture
local txd = CreateRuntimeTxd("aura_ui_txd")
local duiTexture = CreateRuntimeTextureFromDuiHandle(txd, "aura_ui_tex", handle)

-- نعرض الـ UI على الشاشة
Citizen.CreateThread(function()
    while true do
        DrawSprite("aura_ui_txd", "aura_ui_tex", 0.17, 0.18, 0.34, 0.40, 0.0, 255, 255, 255, 255)
        Wait(0)
    end
end)
