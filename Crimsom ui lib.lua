--[[
    ============================================================
    CRIMSON UI LIBRARY - V3.0 (COMPATIBILITY MODE)
    ============================================================
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local Library = { Connections = {} }

-- [ THEME ]
Library.Theme = {
    Header     = Color3.fromRGB(140, 0, 0),
    Background = Color3.fromRGB(12, 12, 14),
    Sidebar    = Color3.fromRGB(18, 5, 5),
    Accent     = Color3.fromRGB(220, 20, 60),
    Text       = Color3.fromRGB(245, 245, 245),
    TextDim    = Color3.fromRGB(160, 160, 160),
    ItemBg     = Color3.fromRGB(28, 28, 32)
}

-- [ UTILS ]
Library.Utils = {}
function Library.Utils.AddCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = instance
end
function Library.Utils.AddStroke(instance, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness
    stroke.Parent = instance
    return stroke
end
function Library.Utils.Tween(instance, props, time)
    TweenService:Create(instance, TweenInfo.new(time or 0.2), props):Play()
end
function Library.Utils.MakeDraggable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = gui.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

-- [ COMPONENTS ]
Library.Components = {}

function Library.Components.Button(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, -10, 0, 35); Btn.BackgroundColor3 = Library.Theme.ItemBg
    Btn.Text = text; Btn.TextColor3 = Library.Theme.Text; Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 13
    Library.Utils.AddCorner(Btn, 6); Library.Utils.AddStroke(Btn, Library.Theme.Accent, 1)
    Btn.MouseButton1Click:Connect(function() pcall(callback) end)
end

function Library.Components.Toggle(parent, text, default, callback)
    local Frame = Instance.new("TextButton", parent)
    Frame.Size = UDim2.new(1, -10, 0, 35); Frame.BackgroundTransparency = 1; Frame.Text = ""
    local Label = Instance.new("TextLabel", Frame)
    Label.Text = "  "..text; Label.Size = UDim2.new(1, 0, 1, 0); Label.BackgroundTransparency = 1
    Label.TextColor3 = Library.Theme.Text; Label.Font = Enum.Font.Gotham; Label.TextSize = 13; Label.TextXAlignment = 0
    local Box = Instance.new("Frame", Frame)
    Box.Size = UDim2.new(0, 20, 0, 20); Box.Position = UDim2.new(1, -25, 0.5, -10); Box.BackgroundColor3 = Library.Theme.ItemBg
    Library.Utils.AddCorner(Box, 4); local S = Library.Utils.AddStroke(Box, Library.Theme.TextDim, 1)
    local active = default; S.Color = active and Library.Theme.Accent or Library.Theme.TextDim
    Frame.MouseButton1Click:Connect(function()
        active = not active; S.Color = active and Library.Theme.Accent or Library.Theme.TextDim
        pcall(callback, active)
    end)
end

-- [ WINDOW & COMPATIBILITY ]
function Library:CriarJanela(title)
    local Screen = Instance.new("ScreenGui", CoreGui)
    Screen.Name = "CrimsonUI"
    
    local Main = Instance.new("Frame", Screen)
    Main.Size = UDim2.new(0, 500, 0, 350); Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.BackgroundColor3 = Library.Theme.Background; Library.Utils.AddCorner(Main, 8)
    Library.Utils.MakeDraggable(Main)

    local Header = Instance.new("Frame", Main)
    Header.Size = UDim2.new(1, 0, 0, 35); Header.BackgroundColor3 = Library.Theme.Header
    Library.Utils.AddCorner(Header, 8)
    local T = Instance.new("TextLabel", Header)
    T.Text = "  "..title; T.Size = UDim2.new(1, 0, 1, 0); T.TextColor3 = Library.Theme.Text; T.Font = Enum.Font.GothamBlack; T.BackgroundTransparency = 1; T.TextXAlignment = 0

    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 60, 1, -35); Sidebar.Position = UDim2.new(0, 0, 0, 35); Sidebar.BackgroundColor3 = Library.Theme.Sidebar
    local SLayout = Instance.new("UIListLayout", Sidebar); SLayout.HorizontalAlignment = 1; SLayout.Padding = UDim.new(0, 5)

    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(1, -70, 1, -45); Container.Position = UDim2.new(0, 65, 0, 40); Container.BackgroundTransparency = 1

    function Library:Notificar(t, d)
        print("[NOTIF] " .. t .. ": " .. d)
    end

    local WindowObj = {}
    function WindowObj:CriarAba(icon)
        local Scroll = Instance.new("ScrollingFrame", Container)
        Scroll.Size = UDim2.new(1, 0, 1, 0); Scroll.BackgroundTransparency = 1; Scroll.Visible = false; Scroll.CanvasSize = UDim2.new(0,0,0,0); Scroll.AutomaticCanvasSize = 2
        Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 5)
        
        local Btn = Instance.new("TextButton", Sidebar)
        Btn.Size = UDim2.new(0, 45, 0, 45); Btn.Text = icon; Btn.BackgroundTransparency = 1; Btn.TextColor3 = Library.Theme.TextDim; Btn.TextSize = 20
        
        Btn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do v.Visible = false end
            for _, v in pairs(Sidebar:GetChildren()) do if v:IsA("TextButton") then v.TextColor3 = Library.Theme.TextDim end end
            Scroll.Visible = true; Btn.TextColor3 = Library.Theme.Accent
        end)

        if #Sidebar:GetChildren() == 2 then Scroll.Visible = true; Btn.TextColor3 = Library.Theme.Accent end

        local Tab = {}
        function Tab:CriarBotao(t, c) Library.Components.Button(Scroll, t, c) end
        function Tab:CriarToggle(t, d, c) Library.Components.Toggle(Scroll, t, d, c) end
        function Tab:CriarLabel(t) 
            local l = Instance.new("TextLabel", Scroll); l.Text = t; l.Size = UDim2.new(1,0,0,20); l.BackgroundTransparency = 1; l.TextColor3 = Library.Theme.TextDim; l.Font = Enum.Font.Gotham; l.TextSize = 12
        end
        -- Adicione Slider/Dropdown conforme precisar seguindo o mesmo padrão
        function Tab:CriarSlider(t, min, max, d, c) end 
        function Tab:CriarDropdown(t, o, c) end
        
        return Tab
    end
    return WindowObj
end

return Library
