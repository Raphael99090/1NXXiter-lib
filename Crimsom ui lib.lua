--[[
    ============================================================
    CRIMSON UI LIBRARY - V3.0 (FULL MODULAR)
    Structure: Fixed Original Version
    Author: Raphael (Final Fix by Gemini)
    ============================================================
]]

local TweenService    = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players         = game:GetService("Players")
local CoreGui         = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local Library = {
    Connections = {} 
}

-- [ 1. THEME ]
Library.Theme = {
    Header     = Color3.fromRGB(140, 0, 0),
    Background = Color3.fromRGB(12, 12, 14),
    Sidebar    = Color3.fromRGB(18, 5, 5),
    Accent     = Color3.fromRGB(220, 20, 60),
    Text       = Color3.fromRGB(245, 245, 245),
    TextDim    = Color3.fromRGB(160, 160, 160),
    ItemBg     = Color3.fromRGB(28, 28, 32)
}

-- [ 2. UTILS ]
Library.Utils = {}
function Library.Utils.AddCorner(instance, radius)
    local corner = Instance.new("UICorner", instance)
    corner.CornerRadius = UDim.new(0, radius)
    return corner
end

function Library.Utils.AddStroke(instance, color, thickness)
    local stroke = Instance.new("UIStroke", instance)
    stroke.Color = color; stroke.Thickness = thickness
    return stroke
end

function Library.Utils.Tween(instance, properties, time)
    TweenService:Create(instance, TweenInfo.new(time or 0.2), properties):Play()
end

function Library.Utils.MakeDraggable(guiObject)
    local dragging, dragInput, dragStart, startPos
    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = guiObject.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

-- [ 3. COMPONENTS ]
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
    local isActive = default
    S.Color = isActive and Library.Theme.Accent or Library.Theme.TextDim
    Frame.MouseButton1Click:Connect(function()
        isActive = not isActive; S.Color = isActive and Library.Theme.Accent or Library.Theme.TextDim
        pcall(callback, isActive)
    end)
end

function Library.Components.Slider(parent, text, min, max, default, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, -10, 0, 45); Frame.BackgroundTransparency = 1
    local L = Instance.new("TextLabel", Frame)
    L.Text = text .. " : " .. default; L.Size = UDim2.new(1,0,0,20); L.TextColor3 = Library.Theme.Text; L.BackgroundTransparency = 1; L.TextXAlignment = 0
    local Bar = Instance.new("TextButton", Frame)
    Bar.Size = UDim2.new(1, 0, 0, 5); Bar.Position = UDim2.new(0,0,0,30); Bar.BackgroundColor3 = Library.Theme.ItemBg; Bar.Text = ""
    local Fill = Instance.new("Frame", Bar)
    Fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0); Fill.BackgroundColor3 = Library.Theme.Accent
    local dragging = false
    Bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local p = math.clamp((i.Position.X - Bar.AbsolutePosition.X)/Bar.AbsoluteSize.X, 0, 1)
            Fill.Size = UDim2.new(p, 0, 1, 0)
            local v = math.floor(min + (max-min)*p); L.Text = text .. " : " .. v; pcall(callback, v)
        end
    end)
end

function Library.Components.Dropdown(parent, text, options, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, -10, 0, 35); Btn.BackgroundColor3 = Library.Theme.ItemBg; Btn.Text = "  "..text; Btn.TextColor3 = Library.Theme.Text; Btn.TextXAlignment = 0
    Library.Utils.AddCorner(Btn, 6)
    Btn.MouseButton1Click:Connect(function()
        local nextOpt = options[math.random(#options)] -- Exemplo simples de troca
        Btn.Text = "  "..text.." : "..nextOpt; pcall(callback, nextOpt)
    end)
end

-- [ 4. WINDOW ]
function Library:CriarJanela(title)
    local Screen = Instance.new("ScreenGui", CoreGui)
    Screen.Name = "CrimsonUI"

    local Bubble = Instance.new("TextButton", Screen)
    Bubble.Size = UDim2.new(0, 50, 0, 50); Bubble.Position = UDim2.new(0, 20, 0, 20); Bubble.BackgroundColor3 = Library.Theme.Header; Bubble.Text = "CRM"; Bubble.Visible = false; Bubble.TextColor3 = Library.Theme.Text
    Library.Utils.AddCorner(Bubble, 100); Library.Utils.MakeDraggable(Bubble)

    local Main = Instance.new("Frame", Screen)
    Main.Size = UDim2.new(0, 500, 0, 350); Main.Position = UDim2.new(0.5, -250, 0.5, -175); Main.BackgroundColor3 = Library.Theme.Background
    Library.Utils.AddCorner(Main, 10); Library.Utils.AddStroke(Main, Library.Theme.Header, 2); Library.Utils.MakeDraggable(Main)

    local Header = Instance.new("Frame", Main)
    Header.Size = UDim2.new(1, 0, 0, 35); Header.BackgroundColor3 = Library.Theme.Header; Library.Utils.AddCorner(Header, 10)
    
    local T = Instance.new("TextLabel", Header)
    T.Text = "  "..title; T.Size = UDim2.new(1, -40, 1, 0); T.TextColor3 = Library.Theme.Text; T.Font = Enum.Font.GothamBlack; T.BackgroundTransparency = 1; T.TextXAlignment = 0

    local Min = Instance.new("TextButton", Header)
    Min.Text = "-"; Min.Size = UDim2.new(0, 35, 1, 0); Min.Position = UDim2.new(1, -35, 0, 0); Min.BackgroundTransparency = 1; Min.TextColor3 = Library.Theme.Text
    Min.MouseButton1Click:Connect(function() Main.Visible = false; Bubble.Visible = true end)
    Bubble.MouseButton1Click:Connect(function() Main.Visible = true; Bubble.Visible = false end)

    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 60, 1, -35); Sidebar.Position = UDim2.new(0, 0, 0, 35); Sidebar.BackgroundColor3 = Library.Theme.Sidebar
    Instance.new("UIListLayout", Sidebar).HorizontalAlignment = Enum.HorizontalAlignment.Center

    local Content = Instance.new("Frame", Main)
    Content.Size = UDim2.new(1, -70, 1, -45); Content.Position = UDim2.new(0, 65, 0, 40); Content.BackgroundTransparency = 1

    local WindowObj = {}
    function WindowObj:CriarAba(icon)
        local Scroll = Instance.new("ScrollingFrame", Content)
        Scroll.Size = UDim2.new(1, 0, 1, 0); Scroll.BackgroundTransparency = 1; Scroll.Visible = false; Scroll.AutomaticCanvasSize = 2; Scroll.ScrollBarThickness = 2
        Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 5)
        
        local SBtn = Instance.new("TextButton", Sidebar)
        SBtn.Size = UDim2.new(0, 45, 0, 45); SBtn.Text = icon; SBtn.BackgroundTransparency = 1; SBtn.TextColor3 = Library.Theme.TextDim; SBtn.TextSize = 22
        
        SBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Content:GetChildren()) do v.Visible = false end
            for _, v in pairs(Sidebar:GetChildren()) do if v:IsA("TextButton") then v.TextColor3 = Library.Theme.TextDim end end
            Scroll.Visible = true; SBtn.TextColor3 = Library.Theme.Accent
        end)
        if #Sidebar:GetChildren() == 2 then Scroll.Visible = true; SBtn.TextColor3 = Library.Theme.Accent end

        local Tab = {}
        function Tab:CriarBotao(t, c) Library.Components.Button(Scroll, t, c) end
        function Tab:CriarToggle(t, d, c) Library.Components.Toggle(Scroll, t, d, c) end
        function Tab:CriarSlider(t, mi, ma, d, c) Library.Components.Slider(Scroll, t, mi, ma, d, c) end
        function Tab:CriarDropdown(t, o, c) Library.Components.Dropdown(Scroll, t, o, c) end
        function Tab:CriarLabel(t) 
            local l = Instance.new("TextLabel", Scroll); l.Text = t; l.Size = UDim2.new(1,0,0,25); l.TextColor3 = Library.Theme.TextDim; l.BackgroundTransparency = 1; l.Font = Enum.Font.GothamBold; l.TextSize = 12
        end
        return Tab
    end
    
    function WindowObj:Notificar(t, d) print(t..": "..d) end
    return WindowObj
end

return Library
