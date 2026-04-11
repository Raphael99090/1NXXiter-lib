--[[
    ============================================================
    CRIMSON UI LIBRARY - V3.0 (FULL COMPONENTS)
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

function Library:CriarJanela(title)
    local Screen = Instance.new("ScreenGui", CoreGui)
    Screen.Name = "CrimsonUI"
    
    local Main = Instance.new("Frame", Screen)
    Main.Size = UDim2.new(0, 500, 0, 380)
    Main.Position = UDim2.new(0.5, -250, 0.5, -190)
    Main.BackgroundColor3 = Library.Theme.Background
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

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
    Instance.new("UIListLayout", Sidebar).HorizontalAlignment = Enum.HorizontalAlignment.Center

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
        Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 5)

        local Btn = Instance.new("TextButton", Sidebar)
        Btn.Size = UDim2.new(0, 45, 0, 45)
        Btn.Text = icon
        Btn.BackgroundTransparency = 1
        Btn.TextColor3 = Library.Theme.TextDim
        Btn.TextSize = 22

        Btn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do v.Visible = false end
            for _, v in pairs(Sidebar:GetChildren()) do if v:IsA("TextButton") then v.TextColor3 = Library.Theme.TextDim end end
            Scroll.Visible = true; Btn.TextColor3 = Library.Theme.Accent
        end)

        if #Sidebar:GetChildren() == 2 then Scroll.Visible = true; Btn.TextColor3 = Library.Theme.Accent end

        local Tab = {}

        function Tab:CriarLabel(text)
            local l = Instance.new("TextLabel", Scroll)
            l.Size = UDim2.new(1, 0, 0, 25)
            l.Text = text
            l.TextColor3 = Library.Theme.TextDim
            l.BackgroundTransparency = 1
            l.Font = Enum.Font.GothamBold; l.TextSize = 12
        end

        function Tab:CriarBotao(text, callback)
            local b = Instance.new("TextButton", Scroll)
            b.Size = UDim2.new(1, -10, 0, 35)
            b.BackgroundColor3 = Library.Theme.ItemBg
            b.Text = text; b.TextColor3 = Library.Theme.Text
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
            b.MouseButton1Click:Connect(function() pcall(callback) end)
        end

        function Tab:CriarToggle(text, default, callback)
            local t = Instance.new("TextButton", Scroll)
            t.Size = UDim2.new(1, -10, 0, 35)
            t.BackgroundColor3 = Library.Theme.ItemBg
            t.Text = "  " .. text; t.TextColor3 = Library.Theme.Text; t.TextXAlignment = 0
            Instance.new("UICorner", t).CornerRadius = UDim.new(0, 6)
            local Ind = Instance.new("Frame", t)
            Ind.Size = UDim2.new(0, 15, 0, 15); Ind.Position = UDim2.new(1, -25, 0.5, -7)
            Ind.BackgroundColor3 = default and Library.Theme.Accent or Library.Theme.TextDim
            local active = default
            t.MouseButton1Click:Connect(function()
                active = not active; Ind.BackgroundColor3 = active and Library.Theme.Accent or Library.Theme.TextDim
                pcall(callback, active)
            end)
        end

        function Tab:CriarSlider(text, min, max, default, callback)
            local sFrame = Instance.new("Frame", Scroll)
            sFrame.Size = UDim2.new(1, -10, 0, 45); sFrame.BackgroundColor3 = Library.Theme.ItemBg
            Instance.new("UICorner", sFrame)
            local label = Instance.new("TextLabel", sFrame)
            label.Text = "  "..text; label.Size = UDim2.new(1,0,0,20); label.BackgroundTransparency = 1; label.TextColor3 = Library.Theme.Text; label.TextXAlignment = 0
            local bar = Instance.new("Frame", sFrame)
            bar.Size = UDim2.new(1, -20, 0, 4); bar.Position = UDim2.new(0, 10, 0, 30); bar.BackgroundColor3 = Library.Theme.Background
            local fill = Instance.new("Frame", bar)
            fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = Library.Theme.Accent
            -- Lógica básica de clique no slider
            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local move = UserInputService.InputChanged:Connect(function(input2)
                        if input2.UserInputType == Enum.UserInputType.MouseMovement then
                            local pos = math.clamp((input2.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                            fill.Size = UDim2.new(pos, 0, 1, 0)
                            pcall(callback, math.floor(min + (max - min) * pos))
                        end
                    end)
                    input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then move:Disconnect() end end)
                end
            end)
        end

        function Tab:CriarDropdown(text, list, callback)
            local d = Instance.new("TextButton", Scroll)
            d.Size = UDim2.new(1, -10, 0, 35); d.BackgroundColor3 = Library.Theme.ItemBg
            d.Text = "  " .. text .. " : " .. (list[1] or ""); d.TextColor3 = Library.Theme.Text; d.TextXAlignment = 0
            Instance.new("UICorner", d)
            d.MouseButton1Click:Connect(function()
                -- Simplificado: alterna entre os itens da lista a cada clique
                local current = table.find(list, d.Text:split(": ")[2]) or 0
                local nextIdx = (current % #list) + 1
                d.Text = "  " .. text .. " : " .. list[nextIdx]
                pcall(callback, list[nextIdx])
            end)
        end

        return Tab
    end
    
    function WindowObj:Notificar(t, d) print(t..": "..d) end
    return WindowObj
end

return Library
