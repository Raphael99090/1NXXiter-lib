--[[
    ============================================================
    CRIMSON UI LIBRARY - V3.0 (FIXED)
    Corrigido para aceitar CriarJanela e retornar Abas corretamente
    ============================================================
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Library = {}
Library.Theme = {
    Header     = Color3.fromRGB(140, 0, 0),
    Background = Color3.fromRGB(12, 12, 14),
    Sidebar    = Color3.fromRGB(18, 5, 5),
    Accent     = Color3.fromRGB(220, 20, 60),
    Text       = Color3.fromRGB(245, 245, 245),
    TextDim    = Color3.fromRGB(160, 160, 160),
    ItemBg     = Color3.fromRGB(28, 28, 32)
}

-- [ FUNÇÃO PRINCIPAL QUE O SEU UI.LUA CHAMA ]
function Library:CriarJanela(title)
    local Screen = Instance.new("ScreenGui", CoreGui)
    Screen.Name = "CrimsonUI"
    
    local Main = Instance.new("Frame", Screen)
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.BackgroundColor3 = Library.Theme.Background
    
    local Corner = Instance.new("UICorner", Main)
    Corner.CornerRadius = UDim.new(0, 10)

    local Header = Instance.new("Frame", Main)
    Header.Size = UDim2.new(1, 0, 0, 35)
    Header.BackgroundColor3 = Library.Theme.Header
    Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)
    
    local Title = Instance.new("TextLabel", Header)
    Title.Text = "  " .. tostring(title):upper()
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.TextColor3 = Library.Theme.Text
    Title.Font = Enum.Font.GothamBlack
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 60, 1, -35)
    Sidebar.Position = UDim2.new(0, 0, 0, 35)
    Sidebar.BackgroundColor3 = Library.Theme.Sidebar
    
    local SLayout = Instance.new("UIListLayout", Sidebar)
    SLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SLayout.Padding = UDim.new(0, 5)

    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(1, -70, 1, -45)
    Container.Position = UDim2.new(0, 65, 0, 40)
    Container.BackgroundTransparency = 1

    local WindowObj = {}

    function WindowObj:CriarAba(icon)
        local Scroll = Instance.new("ScrollingFrame", Container)
        Scroll.Size = UDim2.new(1, 0, 1, 0)
        Scroll.BackgroundTransparency = 1
        Scroll.Visible = false
        Scroll.ScrollBarThickness = 2
        Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        
        local L = Instance.new("UIListLayout", Scroll)
        L.Padding = UDim.new(0, 8)
        L.HorizontalAlignment = Enum.HorizontalAlignment.Center

        local Btn = Instance.new("TextButton", Sidebar)
        Btn.Size = UDim2.new(0, 45, 0, 45)
        Btn.Text = icon
        Btn.BackgroundTransparency = 1
        Btn.TextColor3 = Library.Theme.TextDim
        Btn.TextSize = 22

        Btn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do v.Visible = false end
            for _, v in pairs(Sidebar:GetChildren()) do 
                if v:IsA("TextButton") then v.TextColor3 = Library.Theme.TextDim end 
            end
            Scroll.Visible = true
            Btn.TextColor3 = Library.Theme.Accent
        end)

        if #Sidebar:GetChildren() == 2 then 
            Scroll.Visible = true 
            Btn.TextColor3 = Library.Theme.Accent
        end

        local Tab = {}

        function Tab:CriarLabel(text)
            local l = Instance.new("TextLabel", Scroll)
            l.Size = UDim2.new(1, -10, 0, 25)
            l.Text = text
            l.TextColor3 = Library.Theme.TextDim
            l.BackgroundTransparency = 1
            l.Font = Enum.Font.GothamBold
            l.TextSize = 13
        end

        function Tab:CriarToggle(text, default, callback)
            local tBtn = Instance.new("TextButton", Scroll)
            tBtn.Size = UDim2.new(1, -20, 0, 35)
            tBtn.BackgroundColor3 = Library.Theme.ItemBg
            tBtn.Text = "  " .. text
            tBtn.TextColor3 = Library.Theme.Text
            tBtn.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 6)
            
            local Ind = Instance.new("Frame", tBtn)
            Ind.Size = UDim2.new(0, 15, 0, 15)
            Ind.Position = UDim2.new(1, -25, 0.5, -7)
            Ind.BackgroundColor3 = default and Library.Theme.Accent or Library.Theme.TextDim

            local active = default
            tBtn.MouseButton1Click:Connect(function()
                active = not active
                Ind.BackgroundColor3 = active and Library.Theme.Accent or Library.Theme.TextDim
                pcall(callback, active)
            end)
        end

        function Tab:CriarBotao(text, callback)
            local b = Instance.new("TextButton", Scroll)
            b.Size = UDim2.new(1, -20, 0, 35)
            b.BackgroundColor3 = Library.Theme.ItemBg
            b.Text = text
            b.TextColor3 = Library.Theme.Text
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
            b.MouseButton1Click:Connect(function() pcall(callback) end)
        end

        -- Stubs para não dar erro se o script chamar
        function Tab:CriarSlider(t, min, max, def, cb) self:CriarLabel(t .. ": " .. def) end
        function Tab:CriarDropdown(t, o, cb) self:CriarLabel(t .. ": Selecionar") end

        return Tab -- ESSENCIAL: Retorna a aba para o script continuar
    end

    function WindowObj:Notificar(t, d)
        print("📢 " .. t .. ": " .. d)
    end

    return WindowObj -- ESSENCIAL: Retorna a janela
end

return Library
