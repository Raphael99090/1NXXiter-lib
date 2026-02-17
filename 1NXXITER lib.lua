--[[
    1NXITER UI LIBRARY v10.0 (VISUAL FIX + STABLE)
    Fixes: Sidebar Glitch, Header Color, Layout.
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local Library = {}
local SCRIPT_VERSION = "10.0 Stable"
local FAKE_HWID = "1NX-"..string.upper(string.sub(HttpService:GenerateGUID(false),1,4)).."-"..math.random(1000,9999)

-- TEMA BICOLOR CORRIGIDO
local Theme = {
	Header     = Color3.fromRGB(160, 0, 0),    -- Vermelho Sangue (Topo)
	Background = Color3.fromRGB(15, 15, 15),   -- Preto Absoluto (Corpo)
	Sidebar    = Color3.fromRGB(20, 5, 5),     -- Lateral Escura
	Accent     = Color3.fromRGB(255, 40, 40),  -- Vermelho Neon (Botões)
	Text       = Color3.fromRGB(240, 240, 240),
	TextDim    = Color3.fromRGB(140, 140, 140),
	ItemBg     = Color3.fromRGB(25, 25, 25),
	Success    = Color3.fromRGB(80, 255, 120),
	Gold       = Color3.fromRGB(255, 215, 0)
}

local function AddCorner(obj, radius)
	local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, radius); c.Parent = obj
	return c
end

local function AddStroke(obj, color, thickness)
	local s = Instance.new("UIStroke"); s.Color = color; s.Thickness = thickness; s.Parent = obj
	return s
end

local function MakeDraggable(obj)
	local dragging, dragInput, dragStart, startPos
	obj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = input.Position; startPos = obj.Position
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
		end
	end)
	obj.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			TweenService:Create(obj, TweenInfo.new(0.05), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
		end
	end)
end

function Library:CriarJanela(NomeScript)
	local UI = {}
	
	if CoreGui:FindFirstChild("1NX_UI") then CoreGui["1NX_UI"]:Destroy() end
	if Player.PlayerGui:FindFirstChild("1NX_UI") then Player.PlayerGui["1NX_UI"]:Destroy() end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "1NX_UI"
	pcall(function() ScreenGui.Parent = CoreGui end)
	if ScreenGui.Parent == nil then ScreenGui.Parent = Player:WaitForChild("PlayerGui") end
	
	local NotifContainer = Instance.new("Frame", ScreenGui); NotifContainer.Size = UDim2.new(0, 300, 1, 0); NotifContainer.Position = UDim2.new(1, -320, 0, 50); NotifContainer.BackgroundTransparency = 1
	local NotifList = Instance.new("UIListLayout", NotifContainer); NotifList.Padding = UDim.new(0, 10); NotifList.VerticalAlignment = Enum.VerticalAlignment.Top

	-- Bolinha Flutuante
	local Bubble = Instance.new("TextButton", ScreenGui)
	Bubble.Size = UDim2.new(0, 50, 0, 50); Bubble.Position = UDim2.new(0, 50, 0, 100)
	Bubble.BackgroundColor3 = Theme.Header; Bubble.Text = "1NX"; Bubble.TextColor3 = Theme.Text; Bubble.Font = Enum.Font.GothamBlack; Bubble.Visible = false
	AddCorner(Bubble, 100); AddStroke(Bubble, Theme.Text, 2); MakeDraggable(Bubble)

	-- Main Frame
	local Main = Instance.new("Frame", ScreenGui)
	Main.Size = UDim2.new(0, 500, 0, 350)
	Main.Position = UDim2.new(0.5, -250, 0.5, -175)
	Main.BackgroundColor3 = Theme.Background
	Main.ClipsDescendants = true -- ISSO CONSERTA O BUG VISUAL (Corta o que passa pra fora)
	AddCorner(Main, 10); MakeDraggable(Main); AddStroke(Main, Theme.Header, 2)

	-- Header
	local Header = Instance.new("Frame", Main)
	Header.Size = UDim2.new(1, 0, 0, 40)
	Header.BackgroundColor3 = Theme.Header
	Header.BorderSizePixel = 0
	
	local Title = Instance.new("TextLabel", Header)
	Title.Text = "  " .. string.upper(NomeScript); Title.Size = UDim2.new(0.8, 0, 1, 0); Title.BackgroundTransparency = 1
	Title.TextColor3 = Theme.Text; Title.Font = Enum.Font.GothamBlack; Title.TextSize = 16; Title.TextXAlignment = Enum.TextXAlignment.Left
	
	local MinBtn = Instance.new("TextButton", Header)
	MinBtn.Text = "—"; MinBtn.Size = UDim2.new(0, 40, 1, 0); MinBtn.Position = UDim2.new(1, -40, 0, 0)
	MinBtn.BackgroundTransparency = 1; MinBtn.TextColor3 = Theme.Text; MinBtn.TextSize = 22; MinBtn.Font = Enum.Font.GothamBold

	-- Sidebar
	local Sidebar = Instance.new("Frame", Main)
	Sidebar.Size = UDim2.new(0, 60, 1, -40) -- Largura fixa, altura ajustada
	Sidebar.Position = UDim2.new(0, 0, 0, 40)
	Sidebar.BackgroundColor3 = Theme.Sidebar
	Sidebar.BorderSizePixel = 0
	
	local SideLayout = Instance.new("UIListLayout", Sidebar)
	SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	SideLayout.Padding = UDim.new(0, 10)
	local SidePad = Instance.new("UIPadding", Sidebar); SidePad.PaddingTop = UDim.new(0, 10)

	-- Content
	local Content = Instance.new("Frame", Main)
	Content.Size = UDim2.new(1, -70, 1, -50)
	Content.Position = UDim2.new(0, 65, 0, 45)
	Content.BackgroundTransparency = 1

	-- Logic
	MinBtn.MouseButton1Click:Connect(function() Main.Visible = false; Bubble.Visible = true end)
	Bubble.MouseButton1Click:Connect(function() Bubble.Visible = false; Main.Visible = true end)

	function Library:Notificar(Titulo, Texto, Tempo)
		local Frame = Instance.new("Frame", NotifContainer)
		Frame.Size = UDim2.new(1, 0, 0, 60); Frame.BackgroundColor3 = Theme.Background
		AddCorner(Frame, 6); AddStroke(Frame, Theme.Header, 1)
		
		local T = Instance.new("TextLabel", Frame); T.Text = Titulo; T.Size = UDim2.new(1, -10, 0, 20); T.Position = UDim2.new(0, 10, 0, 5); T.BackgroundTransparency=1; T.TextColor3 = Theme.Accent; T.Font = Enum.Font.GothamBlack; T.TextSize=14; T.TextXAlignment=Enum.TextXAlignment.Left
		local D = Instance.new("TextLabel", Frame); D.Text = Texto; D.Size = UDim2.new(1, -10, 0, 30); D.Position = UDim2.new(0, 10, 0, 25); D.BackgroundTransparency=1; D.TextColor3 = Theme.Text; D.Font = Enum.Font.Gotham; D.TextSize=12; D.TextXAlignment=Enum.TextXAlignment.Left; D.TextWrapped=true
		
		Frame.Position = UDim2.new(1, 50, 0, 0)
		TweenService:Create(Frame, TweenInfo.new(0.5), {Position = UDim2.new(0, 0, 0, 0)}):Play()
		task.spawn(function() task.wait(Tempo or 3); TweenService:Create(Frame, TweenInfo.new(0.5), {Position = UDim2.new(1, 50, 0, 0)}):Play(); task.wait(0.5); Frame:Destroy() end)
	end

	local Tabs = {}
	local FirstTab = true

	function UI:CriarAba(Icone)
		local Tab = {}
		
		local SideBtn = Instance.new("TextButton", Sidebar)
		SideBtn.Text = Icone; SideBtn.Size = UDim2.new(0, 40, 0, 40); SideBtn.BackgroundTransparency = 1
		SideBtn.TextColor3 = Theme.TextDim; SideBtn.TextSize = 24
		
		local Scroll = Instance.new("ScrollingFrame", Content)
		Scroll.Size = UDim2.new(1, 0, 1, 0); Scroll.BackgroundTransparency = 1; Scroll.BorderSizePixel = 0; Scroll.Visible = false; Scroll.ScrollBarThickness = 2; Scroll.ScrollBarImageColor3 = Theme.Accent
		local List = Instance.new("UIListLayout", Scroll); List.Padding = UDim.new(0, 6); List.SortOrder = Enum.SortOrder.LayoutOrder
		local Pad = Instance.new("UIPadding", Scroll); Pad.PaddingTop = UDim.new(0, 5); Pad.PaddingBottom = UDim.new(0, 5)

		if FirstTab then Scroll.Visible = true; SideBtn.TextColor3 = Theme.Accent; FirstTab = false end
		
		SideBtn.MouseButton1Click:Connect(function()
			for _, t in pairs(Tabs) do t.Frame.Visible = false; t.Btn.TextColor3 = Theme.TextDim end
			Scroll.Visible = true; SideBtn.TextColor3 = Theme.Accent
		end)
		table.insert(Tabs, {Frame = Scroll, Btn = SideBtn})

		function Tab:CriarToggle(Texto, Padrao, Callback)
			local F = Instance.new("Frame", Scroll); F.Size = UDim2.new(1, 0, 0, 40); F.BackgroundTransparency = 1
			local B = Instance.new("TextButton", F); B.Size = UDim2.new(0, 24, 0, 24); B.Position = UDim2.new(0, 2, 0.5, -12); B.BackgroundColor3 = Theme.ItemBg; B.Text = ""; B.AutoButtonColor = false; AddCorner(B, 6); local S = AddStroke(B, Theme.TextDim, 1.5)
			local C = Instance.new("Frame", B); C.Size = UDim2.new(0, 14, 0, 14); C.AnchorPoint = Vector2.new(0.5,0.5); C.Position = UDim2.new(0.5,0,0.5,0); C.BackgroundColor3 = Theme.Accent; C.Visible = Padrao; AddCorner(C, 4)
			local L = Instance.new("TextLabel", F); L.Text = Texto; L.Size = UDim2.new(1, -35, 1, 0); L.Position = UDim2.new(0, 35, 0, 0); L.BackgroundTransparency = 1; L.TextColor3 = Theme.Text; L.Font = Enum.Font.GothamMedium; L.TextSize = 13; L.TextXAlignment = Enum.TextXAlignment.Left
			local On = Padrao
			B.MouseButton1Click:Connect(function() On = not On; C.Visible = On; S.Color = On and Theme.Accent or Theme.TextDim; pcall(Callback, On) end)
		end

		function Tab:CriarBotao(Texto, Callback)
			local B = Instance.new("TextButton", Scroll); B.Text = Texto; B.Size = UDim2.new(1, -5, 0, 40); B.BackgroundColor3 = Theme.ItemBg; B.TextColor3 = Theme.Text; B.Font = Enum.Font.GothamBold; B.TextSize = 14; AddCorner(B, 8); AddStroke(B, Theme.Accent, 1)
			B.MouseButton1Click:Connect(function() TweenService:Create(B, TweenInfo.new(0.1), {Size = UDim2.new(1, -10, 0, 40)}):Play(); task.wait(0.1); TweenService:Create(B, TweenInfo.new(0.1), {Size = UDim2.new(1, -5, 0, 40)}):Play(); pcall(Callback) end)
			return function(t) B.Text = t end
		end

		function Tab:CriarInput(Titulo, Padrao, Callback)
			local F = Instance.new("Frame", Scroll); F.Size = UDim2.new(1, 0, 0, 50); F.BackgroundTransparency = 1
			local L = Instance.new("TextLabel", F); L.Text = Titulo; L.Size = UDim2.new(1,0,0,20); L.BackgroundTransparency=1; L.TextColor3=Theme.TextDim; L.Font=Enum.Font.Gotham; L.TextSize=12; L.TextXAlignment=Enum.TextXAlignment.Left
			local Bg = Instance.new("Frame", F); Bg.Size=UDim2.new(1,-5,0,30); Bg.Position=UDim2.new(0,0,0,20); Bg.BackgroundColor3=Theme.ItemBg; AddCorner(Bg, 8)
			local Box = Instance.new("TextBox", Bg); Box.Text = Padrao; Box.Size=UDim2.new(1,-10,1,0); Box.Position=UDim2.new(0,10,0,0); Box.BackgroundTransparency=1; Box.TextColor3=Theme.Text; Box.Font=Enum.Font.GothamBold; Box.TextXAlignment=Enum.TextXAlignment.Left
			Box.FocusLost:Connect(function() pcall(Callback, Box.Text) end)
		end

		function Tab:CriarDropdown(Titulo, Opcoes, Callback)
			local F = Instance.new("Frame", Scroll); F.Size = UDim2.new(1, 0, 0, 60); F.BackgroundTransparency = 1; F.ZIndex = 5
			local L = Instance.new("TextLabel", F); L.Text = Titulo; L.Size = UDim2.new(1,0,0,20); L.BackgroundTransparency=1; L.TextColor3=Theme.TextDim; L.Font=Enum.Font.Gotham; L.TextSize=12; L.TextXAlignment=Enum.TextXAlignment.Left
			local B = Instance.new("TextButton", F); B.Text = Opcoes[1] or "..."; B.Size=UDim2.new(1,-5,0,30); B.Position=UDim2.new(0,0,0,20); B.BackgroundColor3=Theme.ItemBg; B.TextColor3=Theme.Text; B.Font=Enum.Font.GothamBold; B.ZIndex = 6; AddCorner(B, 6)
			local Sc = Instance.new("ScrollingFrame", B); Sc.Size = UDim2.new(1, 0, 0, 0); Sc.Position = UDim2.new(0, 0, 1, 5); Sc.BackgroundColor3 = Theme.ItemBg; Sc.Visible = false; Sc.ZIndex = 10; AddCorner(Sc, 6); AddStroke(Sc, Theme.Header, 1)
			local UI = Instance.new("UIListLayout", Sc); UI.Padding = UDim.new(0, 5); UI.HorizontalAlignment = Enum.HorizontalAlignment.Center
			local Open = false
			B.MouseButton1Click:Connect(function() Open = not Open; Sc.Visible = Open; TweenService:Create(Sc, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, Open and math.min(#Opcoes*30, 120) or 0)}):Play() end)
			for _, o in pairs(Opcoes) do
				local Opt = Instance.new("TextButton", Sc); Opt.Text = o; Opt.Size = UDim2.new(1, -10, 0, 25); Opt.BackgroundTransparency = 1; Opt.TextColor3 = Theme.TextDim; Opt.Font = Enum.Font.Gotham; Opt.ZIndex = 11
				Opt.MouseButton1Click:Connect(function() Open = false; B.Text = o; TweenService:Create(Sc, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play(); pcall(Callback, o) end)
			end
		end

		function Tab:CriarSlider(Titulo, Min, Max, Padrao, Callback)
			local F = Instance.new("Frame", Scroll); F.Size = UDim2.new(1, 0, 0, 50); F.BackgroundTransparency = 1
			local L = Instance.new("TextLabel", F); L.Text = Titulo; L.Size = UDim2.new(1, -50, 0, 20); L.BackgroundTransparency=1; L.TextColor3=Theme.TextDim; L.Font=Enum.Font.Gotham; L.TextSize=12; L.TextXAlignment=Enum.TextXAlignment.Left
			local V = Instance.new("TextLabel", F); V.Text = tostring(Padrao); V.Size = UDim2.new(0, 40, 0, 20); V.Position=UDim2.new(1,-45,0,0); V.BackgroundTransparency=1; V.TextColor3=Theme.Text; V.Font=Enum.Font.GothamBold; V.TextSize=12
			local B = Instance.new("TextButton", F); B.Text=""; B.Size=UDim2.new(1,-5,0,6); B.Position=UDim2.new(0,0,0,30); B.BackgroundColor3=Theme.ItemBg; B.AutoButtonColor=false; AddCorner(B, 100)
			local Fil = Instance.new("Frame", B); Fil.Size=UDim2.new((Padrao - Min)/(Max - Min), 0, 1, 0); Fil.BackgroundColor3=Theme.Accent; AddCorner(Fil, 100)
			local C = Instance.new("Frame", Fil); C.Size=UDim2.new(0,14,0,14); C.Position=UDim2.new(1,-7,0.5,-7); C.BackgroundColor3=Theme.Text; AddCorner(C, 100)
			local Down = false
			B.MouseButton1Down:Connect(function() Down = true end); UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then Down = false end end)
			UserInputService.InputChanged:Connect(function(i)
				if Down and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
					local S = math.clamp((i.Position.X - B.AbsolutePosition.X) / B.AbsoluteSize.X, 0, 1)
					local Val = math.floor(Min + ((Max - Min) * S) * 10) / 10
					TweenService:Create(Fil, TweenInfo.new(0.05), {Size = UDim2.new(S, 0, 1, 0)}):Play(); V.Text = tostring(Val); pcall(Callback, Val)
				end
			end)
		end

		function Tab:CriarLabel(Texto, Cor)
			local L = Instance.new("TextLabel", Scroll); L.Text = Texto; L.Size = UDim2.new(1, 0, 0, 30); L.BackgroundTransparency = 1; L.TextColor3 = Cor or Theme.Text; L.Font = Enum.Font.GothamBold; L.TextSize = 14
			return function(t) L.Text = t end
		end

		function Tab:CriarPerfil()
			local C = Instance.new("Frame", Scroll); C.Size = UDim2.new(1, -5, 0, 160); C.BackgroundColor3 = Color3.fromRGB(20,20,25); AddCorner(C, 12); AddStroke(C, Theme.ItemBg, 1)
			local Av = Instance.new("ImageLabel", C); Av.Size=UDim2.new(0,70,0,70); Av.Position=UDim2.new(0,15,0,45); Av.BackgroundTransparency=1; AddCorner(Av, 100); AddStroke(Av, Theme.Accent, 2)
			task.spawn(function() Av.Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150) end)
			local function Info(t, v, y, c)
				local L = Instance.new("TextLabel", C); L.Text=t..": "..v; L.Size=UDim2.new(0.6,0,0,18); L.Position=UDim2.new(0,100,0,y); L.BackgroundTransparency=1; L.TextColor3=c or Theme.Text; L.Font=Enum.Font.GothamBold; L.TextSize=12; L.TextXAlignment=Enum.TextXAlignment.Left
			end
			Info("USER", string.upper(Player.Name), 20, Theme.Text); Info("ID", Player.UserId, 40, Theme.TextDim); Info("KEY", "LIFETIME", 60, Theme.Gold); Info("HWID", FAKE_HWID, 80, Theme.Accent); Info("VER", SCRIPT_VERSION, 100, Theme.TextDim); Info("STATUS", "VIP ACTIVE", 120, Theme.Success)
		end
		return Tab
	end
	return UI
end
return Library
