-- ===== Aura HTML DUI Menu System =====

-- متغيرات النظام
local AuraDUI = {
    dui = nil,
    duiHandle = nil,
    txd = nil,
    texture = nil,
    isVisible = false,
    authenticated = false,
    currentCategory = nil
}

-- إعدادات المنيو
local MENU_CONFIG = {
    url = "https://raw.githubusercontent.com/wf-675/Aura-Api-Menu/refs/heads/main/index.html",
    width = 600,
    height = 500,
    posX = 0.17,
    posY = 0.18,
    scaleX = 0.34,
    scaleY = 0.40
}

-- ===== وظائف النظام =====

-- إنشاء DUI
function CreateAuraDUI()
    print("Creating Aura DUI...")
    
    -- إنشاء DUI من رابط HTML
    AuraDUI.dui = CreateDui(MENU_CONFIG.url, MENU_CONFIG.width, MENU_CONFIG.height)
    
    if not AuraDUI.dui then
        print("Failed to create DUI")
        return false
    end
    
    -- الحصول على handle
    AuraDUI.duiHandle = GetDuiHandle(AuraDUI.dui)
    
    if not AuraDUI.duiHandle then
        print("Failed to get DUI handle")
        return false
    end
    
    -- إنشاء texture dictionary
    AuraDUI.txd = CreateRuntimeTxd("aura_menu_txd")
    
    -- إنشاء texture من DUI
    AuraDUI.texture = CreateRuntimeTextureFromDuiHandle(AuraDUI.txd, "aura_menu_tex", AuraDUI.duiHandle)
    
    print("Aura DUI created successfully")
    AuraDUI.isVisible = true
    
    return true
end

-- تدمير DUI
function DestroyAuraDUI()
    if AuraDUI.dui then
        DestroyDui(AuraDUI.dui)
        AuraDUI.dui = nil
        AuraDUI.duiHandle = nil
        AuraDUI.isVisible = false
        print("Aura DUI destroyed")
    end
end

-- إرسال رسالة للـ HTML
function SendMessageToDUI(message)
    if AuraDUI.dui then
        SendDuiMessage(AuraDUI.dui, json.encode(message))
    end
end

-- معالج رسائل من HTML
function HandleDUIMessage(data)
    if data.type == "aura_authenticated" then
        AuraDUI.authenticated = true
        print("Authentication successful for key: " .. (data.key or "unknown"))
        
        -- يمكن هنا تحميل سكريپت إضافي أو تفعيل ميزات
        
    elseif data.type == "aura_category_selected" then
        AuraDUI.currentCategory = data.category
        print("Category selected: " .. data.category)
        
        -- معالجة الفئات المختلفة
        HandleCategorySelection(data.category)
    end
end

-- معالج اختيار الفئات
function HandleCategorySelection(category)
    if not AuraDUI.authenticated then
        print("User not authenticated")
        return
    end
    
    -- تنفيذ الوظائف حسب الفئة المختارة
    if category == "self" then
        print("Opening player options...")
        -- هنا يمكن إضافة وظائف اللاعب
        
    elseif category == "online" then
        print("Opening online players menu...")
        -- عرض قائمة اللاعبين المتصلين
        
    elseif category == "weapons" then
        print("Opening weapons menu...")
        -- قائمة الأسلحة والقتال
        
    elseif category == "visual" then
        print("Opening visual effects...")
        -- تأثيرات بصرية
        
    elseif category == "vehicle" then
        print("Opening vehicle options...")
        -- خيارات المركبات
        
    elseif category == "world" then
        print("Opening world options...")
        -- خيارات العالم
        
    elseif category == "misc" then
        print("Opening miscellaneous...")
        -- متنوعات
        
    elseif category == "settings" then
        print("Opening settings...")
        -- الإعدادات
    end
end

-- ===== Thread الرسم =====

Citizen.CreateThread(function()
    -- إنشاء DUI عند البدء
    CreateAuraDUI()
    
    while true do
        Citizen.Wait(0)
        
        -- رسم DUI على الشاشة
        if AuraDUI.isVisible and AuraDUI.txd and AuraDUI.texture then
            DrawSprite("aura_menu_txd", "aura_menu_tex", 
                      MENU_CONFIG.posX, MENU_CONFIG.posY, 
                      MENU_CONFIG.scaleX, MENU_CONFIG.scaleY, 
                      0.0, 255, 255, 255, 255)
        end
    end
end)

-- ===== معالج الأحداث =====

-- استقبال رسائل من HTML
RegisterNUICallback('messageHandler', function(data, cb)
    HandleDUIMessage(data)
    cb('ok')
end)

-- تنظيف عند إنهاء الـ resource
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    
    DestroyAuraDUI()
end)

-- رسائل البدء
print("==============================")
print("AURA HTML DUI MENU LOADED")
print("URL: " .. MENU_CONFIG.url)
print("==============================")

-- تأكد من تحميل DUI
Citizen.CreateThread(function()
    Citizen.Wait(2000)
    if AuraDUI.isVisible then
        print("Aura DUI is visible and running")
    else
        print("WARNING: Aura DUI failed to load")
    end
end)
