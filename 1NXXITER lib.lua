--[[
    1NXITER UI LIBRARY v6.0 (VISUAL FIX - BICOLOR)
    Estilo: 1NXITER Original (Vermelho no Topo / Preto em Baixo)
    Features: Abas, Toggles, Sliders, Dropdowns, Perfil, HWID.
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local Library = {}

-- Dados Fake
local SCRIPT_VERSION = "6.0 Visual"
local FAKE_HWID = "1NX-" .. string.upper(string.sub(HttpService:GenerateGUID(false), 1, 4)) .. "-" .. math.random(1000,9999)

-- ==============================================================================
-- 1. TEMA BICOLOR (IGUAL A FOTO)
-- ==============================================================================
local Theme = {
	Header     = Color3.fromRGB(180, 0, 0),    -- VERMELHO DO TOPO (Sólido)
	Background = Color3.fromRGB(15, 15, 15),   -- PRETO DO CORPO
	Sidebar    = Color3.fromRGB(30, 5, 5),     -- LATERAL ESCURA
	Accent     = Color3.fromRGB(255, 40, 40),  -- Vermelho Neon (Detalhes)
	Text       = Color3.fromRGB(240, 240, 240),
	TextDim    = Color3.fromRGB(160, 160, 160),
	ItemBg     = Color3.fromRGB(30, 30, 30),
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

-- ==============================================================================
-- 2. CRIAR JANELA (COM CABEÇALHO VERMELHO)
-- ==============================================================================
function Library:CriarJanela(NomeScript)
	local UI = {}
	
	if CoreGui:FindFirstChild("1NX_UI") then CoreGui["1NX_UI"]:Destroy() end
	if Player.PlayerGui:FindFirstChild("1NX_UI") then Player.PlayerGui["1NX_UI"]:Destroy() end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "1NX_UI"
	pcall(function() ScreenGui.Parent = CoreGui end)
	if ScreenGui.Parent == nil then ScreenGui.Parent = Player:WaitForChild("PlayerGui") end
	ScreenGui.ResetOnSpawn = false
	
	local NotifContainer = Instance.new("Frame"); NotifContainer.Name = "Notificacoes"; NotifContainer.Size = UDim2.new(0, 300, 1, 0); NotifContainer.Position = UDim2.new(1, -320, 0, 50); NotifContainer.BackgroundTransparency = 1; NotifContainer.Parent = ScreenGui
	local NotifList = Instance.new("UIListLayout"); NotifList.Parent = NotifContainer; NotifList.VerticalAlignment = Enum.VerticalAlignment.Top; NotifList.Padding = UDim.new(0, 10); NotifList.SortOrder = Enum.SortOrder.LayoutOrder

	-- Bolinha Flutuante
	local Bubble = Instance.new("TextButton")
	Bubble.Size = UDim2.new(0, 50, 0, 50); Bubble.Position = UDim2.new(0, 50, 0, 100)
	Bubble.BackgroundColor3 = Theme.Header; Bubble.Text = "1NX"; Bubble.TextColor3 = Theme.Text
	Bubble.Font = Enum.Font.GothamBlack; Bubble.Visible = false; Bubble.Parent = ScreenGui
	AddCorner(Bubble, 100); AddStroke(Bubble, Theme.Text, 2); MakeDraggable(Bubble)

	-- Frame Principal (CORPO PRETO)
	local Main = Instance.new("Frame")
	Main.Size = UDim2.new(0, 550, 0, 380)
	Main.Position = UDim2.new(0.5, -275, 0.5, -190)
	Main.BackgroundColor3 = Theme.Background -- Fundo Preto
	Main.Parent = ScreenGui
	AddCorner(Main, 10); MakeDraggable(Main)
	
	-- Borda Vermelha Fina em volta de tudo (Estilo Xit)
	AddStroke(Main, Theme.Header, 2) 

	-- Header (TOPO VERMELHO SÓLIDO)
	local Header = Instance.new("Frame"); Header.Size = UDim2.new(1, 0, 0, 45); Header.BackgroundColor3 = Theme.Header; Header.BorderSizePixel = 0; Header.Parent = Main
	AddCorner(Header, 10) -- Arredonda topo
	
	-- Tapa Buraco do Header (Para o vermelho não arredondar em baixo e conectar com o preto)
	local HeaderFix = Instance.new("Frame"); HeaderFix.Size = UDim2.new(1, 0, 0, 10); HeaderFix.Position = UDim2.new(0,0,1,-10); HeaderFix.BackgroundColor3 = Theme.Header; HeaderFix.BorderSizePixel=0; HeaderFix.Parent = Header

	-- Título e Botões do Header
	local Title = Instance.new("TextLabel"); Title.Text = "  " .. string.upper(NomeScript); Title.Size = UDim2.new(0.8, 0, 1, 0); Title.BackgroundTransparency = 1
	Title.TextColor3 = Theme.Text; Title.Font = Enum.Font.GothamBlack; Title.TextSize = 18; Title.TextXAlignment = Enum.TextXAlignment.Left; Title.Parent = Header
	
	local MinBtn = Instance.new("TextButton"); MinBtn.Text = "—"; MinBtn.Size = UDim2.new(0, 45, 1, 0); MinBtn.Position = UDim2.new(1, -45, 0, 0)
	MinBtn.BackgroundTransparency = 1; MinBtn.TextColor3 = Theme.Text; MinBtn.TextSize = 24; MinBtn.Font = Enum.Font.GothamBold; MinBtn.Parent = Header

	-- Sidebar (LATERAL ESCURA)
	local Sidebar = Instance.new("Frame"); Sidebar.Size = UDim2.new(0, 70, 1, -45); Sidebar.Position = UDim2.new(0, 0, 0, 45)
	Sidebar.BackgroundColor3 = Theme.Sidebar; Sidebar.BorderSizePixel=0; Sidebar.Parent = Main
	local SideCorner = AddCorner(Sidebar, 10)
	-- Tapa buraco da sidebar (para conectar reto em cima e na direita)
	local SFixTop = Instance.new("Frame"); SFixTop.Size = UDim2.new(1,0,0,20); SFixTop.BackgroundTransparency=1; SFixTop.Parent=Sidebar
	local SFixRight = Instance.new("Frame"); SFixRight.Size = UDim2.new(0,10,1,0); SFixRight.Position=UDim2.new(1,-10,0,0); SFixRight.BackgroundColor3=Theme.Sidebar; SFixRight.BorderSizePixel=0; SFixRight.Parent=Sidebar

	local SidebarLayout = Instance.new("UIListLayout"); SidebarLayout.Parent = Sidebar; SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center; SidebarLayout.Padding = UDim.new(0, 15)
	local SidePad = Instance.new("UIPadding"); SidePad.Parent = Sidebar; SidePad.PaddingTop = UDim.new(0,15)
	
	-- Container de Conteúdo (ONDE FICAM OS BOTÕES)
	local Content = Instance.new("Frame"); Content.Size = UDim2.new(1, -85, 1, -55); Content.Position = UDim2.new(0, 80, 0, 50)
	Content.BackgroundTransparency = 1; Content.Parent = Main

	-- Lógica de Minimizar
	MinBtn.MouseButton1Click:Connect(function() Main.Visible = false; Bubble.Visible = true end)
	Bubble.MouseButton1Click:Connect(function() Bubble.Visible = false; Main.Visible = true end)

	-- ==============================================================================
	-- NOTIFICAÇÕES (MANTIDO)
	-- ==============================================================================
	function Library:Notificar(Titulo, Texto, Tempo)
		local Frame = Instance.new("Frame"); Frame.Size = UDim2.new(1, 0, 0, 70); Frame.BackgroundColor3 = Theme.Background; Frame.Parent = NotifContainer
		AddCorner(Frame, 8); AddStroke(Frame, Theme.Header, 1) -- Borda vermelha na notificação tbm
		
		local T = Instance.new("TextLabel"); T.Text = Titulo; T.Size = UDim2.new(1, -10, 0, 25); T.Position = UDim2.new(0, 10, 0, 5); T.BackgroundTransparency=1; T.TextColor3 = Theme.Accent; T.Font = Enum.Font.GothamBlack; T.TextSize=14; T.TextXAlignment=Enum.TextXAlignment.Left; T.Parent = Frame
		local D = Instance.new("TextLabel"); D.Text = Texto; D.Size = UDim2.new(1, -10, 0, 35); D.Position = UDim2.new(0, 10, 0, 30); D.BackgroundTransparency=1; D.TextColor3 = Theme.Text; D.Font = Enum.Font.Gotham; D.TextSize=12; D.TextXAlignment=Enum.TextXAlignment.Left; D.TextWrapped=true; D.Parent = Frame
		
		Frame.Position = UDim2.new(1, 50, 0, 0)
		TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {Position = UDim2.new(0, 0, 0, 0)}):Play()
		task.spawn(function() task.wait(Tempo or 3); TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {Position = UDim2.new(1, 50, 0, 0)}):Play(); task.wait(0.5); Frame:Destroy() end)
	end

	-- ==============================================================================
	-- ABAS E COMPONENTES
	-- ==============================================================================
	local Tabs = {}
	local FirstTab = true

	function UI:CriarAba(Icone)
		local Tab = {}
		
		local SideBtn = Instance.new("TextButton")
		SideBtn.Text = Icone; SideBtn.Size = UDim2.new(0, 50, 0, 50); SideBtn.BackgroundTransparency = 1
		SideBtn.TextColor3 = Theme.TextDim; SideBtn.TextSize = 28; SideBtn.Parent = Sidebar
		
		local TabFrame = Instance.new("ScrollingFrame")
		TabFrame.Size = UDim2.new(1, 0, 1, 0); TabFrame.BackgroundTransparency = 1; TabFrame.BorderSizePixel = 0
		TabFrame.ScrollBarThickness = 2; TabFrame.ScrollBarImageColor3 = Theme.Accent; TabFrame.Parent = Content
		TabFrame.Visible = false
		
		local ListLayout = Instance.new("UIListLayout"); ListLayout.Parent = TabFrame; ListLayout.Padding = UDim.new(0, 8); ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		local ListPad = Instance.new("UIPadding"); ListPad.Parent = TabFrame; ListPad.PaddingTop = UDim.new(0, 5); ListPad.PaddingBottom = UDim.new(0, 5)

		if FirstTab then TabFrame.Visible = true; SideBtn.TextColor3 = Theme.Accent; FirstTab = false end
		
		SideBtn.MouseButton1Click:Connect(function()
			for _, t in pairs(Tabs) do t.Frame.Visible = false; t.Btn.TextColor3 = Theme.TextDim end
			TabFrame.Visible = true; SideBtn.TextColor3 = Theme.Accent
		end)
		table.insert(Tabs, {Frame = TabFrame, Btn = SideBtn})

		-- COMPONENTES (CHECKBOX, BOTAO, ETC)
		
		function Tab:CriarToggle(Texto, Padrao, Callback)
			local Container = Instance.new("Frame"); Container.Size = UDim2.new(1, 0, 0, 45); Container.BackgroundTransparency = 1; Container.Parent = TabFrame
			
			local Box = Instance.new("TextButton"); Box.Size = UDim2.new(0, 26, 0, 26); Box.Position = UDim2.new(0, 2, 0.5, -13); Box.BackgroundColor3 = Theme.ItemBg; Box.Text = ""; Box.AutoButtonColor = false; Box.Parent = Container
			AddCorner(Box, 6); local Stroke = AddStroke(Box, Theme.TextDim, 1.5)
			
			local Check = Instance.new("Frame"); Check.Size = UDim2.new(0, 16, 0, 16); Check.AnchorPoint = Vector2.new(0.5,0.5); Check.Position = UDim2.new(0.5,0,0.5,0)
			Check.BackgroundColor3 = Theme.Accent; Check.Visible = Padrao; Check.Parent = Box; AddCorner(Check, 4)
			
			local Label = Instance.new("TextLabel"); Label.Text = Texto; Label.Size = UDim2.new(1, -40, 1, 0); Label.Position = UDim2.new(0, 40, 0, 0)
			Label.BackgroundTransparency = 1; Label.TextColor3 = Theme.Text; Label.Font = Enum.Font.GothamMedium; Label.TextSize = 14; Label.TextXAlignment = Enum.TextXAlignment.Left; Label.Parent = Container
			
			local Ativado = Padrao
			Box.MouseButton1Click:Connect(function() Ativado = not Ativado; Check.Visible = Ativado; if Ativado then Stroke.Color = Theme.Accent else Stroke.Color = Theme.TextDim end; pcall(Callback, Ativado) end)
		end

		function Tab:CriarBotao(Texto, Callback)
			local Btn = Instance.new("TextButton"); Btn.Text = Texto; Btn.Size = UDim2.new(1, -10, 0, 42)
			Btn.BackgroundColor3 = Theme.ItemBg; Btn.TextColor3 = Theme.Text; Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 14; Btn.Parent = TabFrame
			AddCorner(Btn, 8); AddStroke(Btn, Theme.Accent, 1)
			
			Btn.MouseButton1Down:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -15, 0, 40)}):Play() end)
			Btn.MouseButton1Up:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -10, 0, 42)}):Play(); pcall(Callback) end)
			return function(NovoTexto) Btn.Text = NovoTexto end 
		end

		function Tab:CriarInput(Titulo, Padrao, Callback)
			local Container = Instance.new("Frame"); Container.Size = UDim2.new(1, 0, 0, 55); Container.BackgroundTransparency = 1; Container.Parent = TabFrame
			local Label = Instance.new("TextLabel"); Label.Text = Titulo; Label.Size = UDim2.new(1,0,0,20); Label.BackgroundTransparency=1; Label.TextColor3=Theme.TextDim; Label.Font=Enum.Font.Gotham; Label.TextSize=12; Label.TextXAlignment=Enum.TextXAlignment.Left; Label.Parent=Container
			local BoxBg = Instance.new("Frame"); BoxBg.Size=UDim2.new(1,-10,0,32); BoxBg.Position=UDim2.new(0,0,0,22); BoxBg.BackgroundColor3=Theme.ItemBg; BoxBg.Parent=Container; AddCorner(BoxBg, 8)
			local Box = Instance.new("TextBox"); Box.Text = Padrao; Box.Size=UDim2.new(1,-10,1,0); Box.Position=UDim2.new(0,10,0,0); Box.BackgroundTransparency=1; Box.TextColor3=Theme.Text; Box.Font=Enum.Font.GothamBold; Box.TextXAlignment=Enum.TextXAlignment.Left; Box.Parent=BoxBg
			Box.FocusLost:Connect(function() pcall(Callback, Box.Text) end)
		end

		function Tab:CriarDropdown(Titulo, Opcoes, Callback)
			local DropFrame = Instance.new("Frame"); DropFrame.Size = UDim2.new(1, 0, 0, 60); DropFrame.BackgroundTransparency = 1; DropFrame.ZIndex = 5; DropFrame.Parent = TabFrame
			local Label = Instance.new("TextLabel"); Label.Text = Titulo; Label.Size = UDim2.new(1,0,0,20); Label.BackgroundTransparency=1; Label.TextColor3=Theme.TextDim; Label.Font=Enum.Font.Gotham; Label.TextSize=12; Label.TextXAlignment=Enum.TextXAlignment.Left; Label.Parent=DropFrame
			local MainBtn = Instance.new("TextButton"); MainBtn.Text = Opcoes[1] or "..."; MainBtn.Size=UDim2.new(1,-10,0,32); MainBtn.Position=UDim2.new(0,0,0,22); MainBtn.BackgroundColor3=Theme.ItemBg; MainBtn.TextColor3=Theme.Text; MainBtn.Font=Enum.Font.GothamBold; MainBtn.ZIndex = 6; MainBtn.Parent=DropFrame; AddCorner(MainBtn, 6)
			local ListFrame = Instance.new("ScrollingFrame"); ListFrame.Size = UDim2.new(1, 0, 0, 0); ListFrame.Position = UDim2.new(0, 0, 1, 5); ListFrame.BackgroundColor3 = Theme.ItemBg; ListFrame.Visible = false; ListFrame.ZIndex = 10; ListFrame.Parent = MainBtn; AddCorner(ListFrame, 6); AddStroke(ListFrame, Theme.Header, 1)
			local UIList = Instance.new("UIListLayout"); UIList.Parent = ListFrame; UIList.Padding = UDim.new(0, 5); UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
			local Aberto = false
			MainBtn.MouseButton1Click:Connect(function()
				Aberto = not Aberto
				if Aberto then ListFrame.Visible = true; TweenService:Create(ListFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, math.min(#Opcoes * 30, 120))}):Play()
				else TweenService:Create(ListFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play(); task.wait(0.2); ListFrame.Visible = false end
			end)
			for _, opt in pairs(Opcoes) do
				local Btn = Instance.new("TextButton"); Btn.Text = opt; Btn.Size = UDim2.new(1, -10, 0, 25); Btn.BackgroundTransparency = 1; Btn.TextColor3 = Theme.TextDim; Btn.Font = Enum.Font.Gotham; Btn.ZIndex = 11; Btn.Parent = ListFrame
				Btn.MouseButton1Click:Connect(function() Aberto = false; MainBtn.Text = opt; TweenService:Create(ListFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play(); task.wait(0.2); ListFrame.Visible = false; pcall(Callback, opt) end)
			end
		end

		function Tab:CriarSlider(Titulo, Min, Max, Padrao, Callback)
			local Container = Instance.new("Frame"); Container.Size = UDim2.new(1, 0, 0, 55); Container.BackgroundTransparency = 1; Container.Parent = TabFrame
			local Label = Instance.new("TextLabel"); Label.Text = Titulo; Label.Size = UDim2.new(1, -50, 0, 20); Label.BackgroundTransparency=1; Label.TextColor3=Theme.TextDim; Label.Font=Enum.Font.Gotham; Label.TextSize=12; Label.TextXAlignment=Enum.TextXAlignment.Left; Label.Parent=Container
			local ValueLbl = Instance.new("TextLabel"); ValueLbl.Text = tostring(Padrao); ValueLbl.Size = UDim2.new(0, 40, 0, 20); ValueLbl.Position=UDim2.new(1,-45,0,0); ValueLbl.BackgroundTransparency=1; ValueLbl.TextColor3=Theme.Text; ValueLbl.Font=Enum.Font.GothamBold; ValueLbl.TextSize=12; ValueLbl.Parent=Container
			local BarBg = Instance.new("TextButton"); BarBg.Text=""; BarBg.Size=UDim2.new(1,-10,0,6); BarBg.Position=UDim2.new(0,0,0,35); BarBg.BackgroundColor3=Theme.ItemBg; BarBg.AutoButtonColor=false; BarBg.Parent=Container; AddCorner(BarBg, 100)
			local Fill = Instance.new("Frame"); Fill.Size=UDim2.new((Padrao - Min)/(Max - Min), 0, 1, 0); Fill.BackgroundColor3=Theme.Accent; Fill.Parent=BarBg; AddCorner(Fill, 100)
			local Circle = Instance.new("Frame"); Circle.Size=UDim2.new(0,14,0,14); Circle.Position=UDim2.new(1,-7,0.5,-7); Circle.BackgroundColor3=Theme.Text; Circle.Parent=Fill; AddCorner(Circle, 100)
			local Dragging = false
			BarBg.MouseButton1Down:Connect(function() Dragging = true end)
			UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = false end end)
			UserInputService.InputChanged:Connect(function(input)
				if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					local SizeScale = math.clamp((input.Position.X - BarBg.AbsolutePosition.X) / BarBg.AbsoluteSize.X, 0, 1)
					local Value = math.floor(Min + ((Max - Min) * SizeScale) * 10) / 10
					TweenService:Create(Fill, TweenInfo.new(0.05), {Size = UDim2.new(SizeScale, 0, 1, 0)}):Play(); ValueLbl.Text = tostring(Value); pcall(Callback, Value)
				end
			end)
		end

		function Tab:CriarLabel(Texto, Cor)
			local Label = Instance.new("TextLabel"); Label.Text = Texto; Label.Size = UDim2.new(1, 0, 0, 30); Label.BackgroundTransparency = 1; Label.TextColor3 = Cor or Theme.Text; Label.Font = Enum.Font.GothamBold; Label.TextSize = 14; Label.Parent = TabFrame
			return function(NovoTexto) Label.Text = NovoTexto end
		end

		function Tab:CriarPerfil()
			local Card = Instance.new("Frame"); Card.Size = UDim2.new(1, -10, 0, 160); Card.BackgroundColor3 = Color3.fromRGB(25,25,30); Card.Parent = TabFrame
			AddCorner(Card, 12); AddStroke(Card, Theme.ItemBg, 1)
			
			local Av = Instance.new("ImageLabel"); Av.Size=UDim2.new(0,70,0,70); Av.Position=UDim2.new(0,15,0,45); Av.BackgroundTransparency=1; Av.Parent=Card
			AddCorner(Av, 100); AddStroke(Av, Theme.Accent, 2)
			task.spawn(function() Av.Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150) end)
			
			local function AddInfo(t, v, y, c)
				local l = Instance.new("TextLabel"); l.Text=t..": "..v; l.Size=UDim2.new(0.6,0,0,18); l.Position=UDim2.new(0,100,0,y); l.BackgroundTransparency=1
				l.TextColor3=c or Theme.Text; l.Font=Enum.Font.GothamBold; l.TextSize=12; l.TextXAlignment=Enum.TextXAlignment.Left; l.Parent=Card
			end
			
			AddInfo("USUÁRIO", string.upper(Player.Name), 20, Theme.Text)
			AddInfo("ID", Player.UserId, 40, Theme.TextDim)
			AddInfo("VALIDADE", "VITALÍCIA (LIFETIME)", 60, Theme.Gold)
			AddInfo("HWID", FAKE_HWID, 80, Theme.Accent)
			AddInfo("VERSÃO", SCRIPT_VERSION, 100, Theme.TextDim)
			AddInfo("STATUS", "VIP ATIVO", 120, Theme.Success)
		end

		return Tab
	end

	return UI
end

return Library
