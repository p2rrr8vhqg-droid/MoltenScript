local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

local KEY = "sexy_Molten"

local keyGui = Instance.new("ScreenGui")
keyGui.ResetOnSpawn = false
keyGui.Parent = playerGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.fromScale(0.3, 0.25)
keyFrame.AnchorPoint = Vector2.new(0.5,0.5)
keyFrame.Position = UDim2.fromScale(0.5,0.5)
keyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
keyFrame.Parent = keyGui
Instance.new("UICorner", keyFrame)

local uiScale = Instance.new("UIScale", keyFrame)
uiScale.Scale = 0

local title = Instance.new("TextLabel", keyFrame)
title.Size = UDim2.fromScale(1, 0.3)
title.BackgroundTransparency = 1
title.Text = "Enter Key"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.fromScale(0.85, 0.25)
keyBox.Position = UDim2.fromScale(0.075, 0.4)
keyBox.PlaceholderText = "Key here"
keyBox.TextScaled = true
keyBox.Font = Enum.Font.Gotham
keyBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
keyBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", keyBox)

local submit = Instance.new("TextButton", keyFrame)
submit.Size = UDim2.fromScale(0.5,0.2)
submit.Position = UDim2.fromScale(0.25,0.7)
submit.Text = "Unlock"
submit.TextScaled = true
submit.Font = Enum.Font.GothamBold
submit.BackgroundColor3 = Color3.fromRGB(60,60,60)
submit.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", submit)

TweenService:Create(uiScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
   
local function startMainGui()
	TweenService:Create(uiScale, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0}):Play()
task.wait(0.25)
keyGui:Destroy()

	local keySpam = false
	local spamDelay = 0.12
	local deathTP = false
	local lastDeathCFrame

	local loopGoto = false
	local loopTargetName = ""

	local autoReset = false
	local resetDelay = 2

	local gui = Instance.new("ScreenGui", playerGui)
	gui.ResetOnSpawn = false

	local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.fromScale(0.05, 0.08)
toggleBtn.Position = UDim2.fromScale(0.01,0.46)
toggleBtn.Text = "â¡"
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
toggleBtn.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", toggleBtn)

	local frame = Instance.new("Frame", gui)
	frame.Size = UDim2.fromScale(0.3,0.85)
	frame.Position = UDim2.fromScale(0.35,0.12)
	frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
	Instance.new("UICorner", frame)

	local topBar = Instance.new("TextLabel", frame)
topBar.Size = UDim2.fromScale(1,0.1)
topBar.Text = "Molten Hub"
topBar.TextScaled = true
topBar.Font = Enum.Font.GothamBold
topBar.TextColor3 = Color3.new(1,1,1)
topBar.BackgroundColor3 = Color3.fromRGB(25,25,25)
	Instance.new("UICorner", topBar)

	do
		local dragging, startPos, startInput
	
topBar.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			startInput = i.Position
			startPos = frame.Position
		end
	end)
		UserInputService.InputChanged:Connect(function(i)
		if dragging then
			local delta = i.Position - startInput
			frame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
		UserInputService.InputEnded:Connect(function()
			dragging = false
		end)
	done

	local function button(text,y)
		local b = Instance.new("TextButton", frame)
		b.Size = UDim2.fromScale(0.9,0.075)
		b.Position = UDim2.fromScale(0.05,y)
		b.Text = text
		b.TextScaled = true
		b.Font = Enum.Font.GothamBold
		b.BackgroundColor3 = Color3.fromRGB(60,60,60)
		b.TextColor3 = Color3.new(1,1,1)
		Instance.new("UICorner", b)
		return b
	end

	local gotoBtn = button("LoopGoto: OFF",0.12)
	local nameBox = Instance.new("TextBox", frame)
	nameBox.Size = UDim2.fromScale(0.9,0.075)
	nameBox.Position = UDim2.fromScale(0.05,0.21)
	nameBox.PlaceholderText = "Username"
	nameBox.TextScaled = true
	nameBox.Font = Enum.Font.Gotham
	nameBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
	nameBox.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", nameBox)

	gotoBtn.MouseButton1Click:Connect(function()
		loopGoto = not loopGoto
		gotoBtn.Text = "LoopGoto: "..(loopGoto and "ON" or "OFF")
	end)
	nameBox.FocusLost:Connect(function()
		loopTargetName = nameBox.Text
	end)

	local spamBtn = button("Key Spam: OFF",0.32)
	spamBtn.MouseButton1Click:Connect(function()
		keySpam = not keySpam
		spamBtn.Text = "Key Spam: "..(keySpam and "ON" or "OFF")
	end)

	local delayBox = Instance.new("TextBox", frame)
delayBox.Size = UDim2.fromScale(0.9,0.075)
delayBox.Position = UDim2.fromScale(0.05,0.42)
delayBox.PlaceholderText = "Spam Delay (sec)"
delayBox.Text = tostring(spamDelay)
delayBox.TextScaled = true

delayBox.Font = Enum.Font.Gotham

delayBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
delayBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", delayBox)
delayBox.FocusLost:Connect(function()
		local val = tonumber(delayBox.Text)
		if val and val>=0.02 and val<=1 then
			spamDelay = val
		else
			delayBox.Text = tostring(spamDelay)
		end
	end)

	local resetBtn = button("AutoReset: OFF",0.52)
	resetBtn.MouseButton1Click:Connect(function()
		autoReset = not autoReset
		resetBtn.Text = "AutoReset: "..(autoReset and "ON" or "OFF")
	end)

	local resetBox = Instance.new("TextBox", frame)
resetBox.Size = UDim2.fromScale(0.9,0.075)
resetBox.Position = UDim2.fromScale(0.05,0.62)
resetBox.PlaceholderText = "Reset Delay (sec)"
resetBox.Text = tostring(resetDelay)
resetBox.TextScaled = true
resetBox.Font = Enum.Font.Gotham
resetBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
resetBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", resetBox)
resetBox.FocusLost:Connect(function()
		local val = tonumber(resetBox.Text)
		if val and val>=0.05 and val<=10 then
			resetDelay = val
		else
			resetBox.Text = tostring(resetDelay)
		end
	end)

	local deathBtn = button("DeathTP: OFF",0.72)
deathBtn.MouseButton1Click:Connect(function()
		deathTP = not deathTP
		deathBtn.Text = "DeathTP: "..(deathTP and "ON" or "OFF")
	end)


toggleBtn.MouseButton1Click:Connect(function()
		frame.Visible = not frame.Visible
	end)

	local function setupChar(char)
		if not char then return end
		local hum = char:WaitForChild("Humanoid")
		local hrp = char:WaitForChild("HumanoidRootPart")

		hum.Died:Connect(function()
			lastDeathCFrame = hrp.CFrame
			if autoReset then
				task.wait(resetDelay)
				if player.Character then
					player:LoadCharacter()
				end
			end
		end)

		if deathTP and lastDeathCFrame then
			task.wait(0.15)
			hrpt.CFrame = lastDeathCFrame
		end
	end

	if player.Character then setupChar(player.Character) end
		player.CharacterAdded:Connect(setupChar)

	RunService.Heartbeat:Connect(function()
		if loopGoto and loopTargetName~="" then
			local target = Players:FindFirstChild(loopTargetName)
			if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					hrpt.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-2)
				end
			end
		end

		if keySpam then
			local keys = {Enum.KeyCode.One,Enum.KeyCode.Two,Enum.KeyCode.Three,Enum.KeyCode.Four}
			for _,k in ipairs(keys) do
				if not keySpam then break end
				VirtualInputManager:SendKeyEvent(true,k,false,game)
				task.wait(0.02)
				VirtualInputManager:SendKeyEvent(false,k,false,game)
				task.wait(spamDelay)
			end
		end
	end)
end

submit.MouseButton1Click:Connect(function()
	if keyBox.Text==KEY then
		startMainGui()
	else
		keyGui:Destroy()
	end
end