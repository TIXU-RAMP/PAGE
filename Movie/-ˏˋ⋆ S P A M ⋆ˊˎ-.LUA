print(told ya)
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local Player = Players.LocalPlayer
local PlayerGui = Player:FindFirstChildOfClass("PlayerGui")

-- UI Sounds
local ClickSound = Instance.new("Sound", SoundService)
ClickSound.SoundId = "rbxassetid://911393469" -- Button click sound

local OpenSound = Instance.new("Sound", SoundService)
OpenSound.SoundId = "rbxassetid://6026984224" -- UI open sound

local CloseSound = Instance.new("Sound", SoundService)
CloseSound.SoundId = "rbxassetid://911393469" -- UI close sound

-- List of available commands with associated functions
local Commands = {
    {Command = "/help", Func = function() print("Help command executed.") end},
    {Command = "/kick", Func = function() print("Kick command executed.") end},
    {Command = "/ban", Func = function() print("Ban command executed.") end},
    {Command = "/mute", Func = function() print("Mute command executed.") end},
    {Command = "/unmute", Func = function() print("Unmute command executed.") end},
    {Command = "/tp", Func = function() print("Teleport command executed.") end},
    {Command = "/give", Func = function() print("Give command executed.") end},
    {Command = "/heal", Func = function() print("Heal command executed.") end},
    {Command = "/kill", Func = function() print("Kill command executed.") end},
    {Command = "/teleport", Func = function() print("Teleport to location.") end},
    {Command = "/teleportto", Func = function() print("Teleport to player.") end},
    {Command = "/teleportall", Func = function() print("Teleport all players.") end},
    {Command = "/speed", Func = function() print("Speed command executed.") end},
    {Command = "/godmode", Func = function() print("God mode enabled.") end},
    {Command = "/setlevel", Func = function() print("Set level command executed.") end},
    {Command = "/summon", Func = function() print("Summon command executed.") end},
    {Command = "/reset", Func = function() print("Reset command executed.") end},
    {Command = "/spawn", Func = function() print("Spawn command executed.") end},
    {Command = "/promote", Func = function() print("Promote command executed.") end},
    {Command = "/demote", Func = function() print("Demote command executed.") end},
    {Command = "/info", Func = function() print("Info command executed.") end},
    {Command = "/status", Func = function() print("Status command executed.") end},
}

-- Screen GUI
local ScreenGui = Instance.new("ScreenGui", PlayerGui)

-- Main Frame
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0.5, 0, 0.4, 0)
Frame.Position = UDim2.new(0.25, 0, -0.5, 0) -- Start off-screen
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 10)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.Text = "Command UI"
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1

-- Command Box
local CommandBox = Instance.new("TextBox", Frame)
CommandBox.Size = UDim2.new(0.8, 0, 0.2, 0)
CommandBox.Position = UDim2.new(0.1, 0, 0.3, 0)
CommandBox.PlaceholderText = "Enter command..."
CommandBox.Text = ""
CommandBox.TextSize = 18
CommandBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local UICornerCmd = Instance.new("UICorner", CommandBox)
UICornerCmd.CornerRadius = UDim.new(0, 8)

-- Box to display the list of commands (Initially hidden)
local CommandListBox = Instance.new("Frame", Frame)
CommandListBox.Size = UDim2.new(0.8, 0, 0.3, 0)
CommandListBox.Position = UDim2.new(0.1, 0, 0.6, 0)
CommandListBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CommandListBox.Visible = false

local UICornerBox = Instance.new("UICorner", CommandListBox)
UICornerBox.CornerRadius = UDim.new(0, 8)

local CommandListText = Instance.new("TextLabel", CommandListBox)
CommandListText.Size = UDim2.new(1, 0, 1, 0)
CommandListText.Text = "Available Commands: \n" .. table.concat(Commands, "\n")
CommandListText.TextSize = 16
CommandListText.TextColor3 = Color3.fromRGB(200, 200, 200)
CommandListText.BackgroundTransparency = 1

-- Arrow Button
local ArrowButton = Instance.new("TextButton", Frame)
ArrowButton.Size = UDim2.new(0.1, 0, 0.1, 0)
ArrowButton.Position = UDim2.new(0.45, 0, 0.85, 0)
ArrowButton.Text = "▼"
ArrowButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
ArrowButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local UICornerArrow = Instance.new("UICorner", ArrowButton)
UICornerArrow.CornerRadius = UDim.new(0, 8)

-- Arrow rotation animation when clicked
local function ToggleCommandList()
    if CommandListBox.Visible then
        -- Hide the box with a smooth fade and slide
        TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.25, 0, -0.5, 0)}):Play()
        CommandListBox.Visible = false
        ArrowButton.Rotation = 0
        CloseSound:Play()
    else
        -- Show the box with a smooth fade and slide
        TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.25, 0, 0.3, 0)}):Play()
        CommandListBox.Visible = true
        ArrowButton.Rotation = 180
        OpenSound:Play()
    end
end

ArrowButton.MouseButton1Click:Connect(ToggleCommandList)
ArrowButton.TouchTap:Connect(ToggleCommandList)

-- Open UI Animation
TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.25, 0, 0.3, 0)}):Play()
OpenSound:Play()

-- Command Execution
CommandBox.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        ClickSound:Play()
        -- Execute the command
        for _, cmd in ipairs(Commands) do
            if CommandBox.Text:lower() == cmd.Command:lower() then
                cmd.Func()
                CommandBox.Text = "" -- Clear input after execution
                break
            end
        end
    end
end)
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local Player = Players.LocalPlayer
local PlayerGui = Player:FindFirstChildOfClass("PlayerGui")

-- UI Sounds
local ClickSound = Instance.new("Sound", SoundService)
ClickSound.SoundId = "rbxassetid://911393469" -- Button click sound

local OpenSound = Instance.new("Sound", SoundService)
OpenSound.SoundId = "rbxassetid://6026984224" -- UI open sound

local CloseSound = Instance.new("Sound", SoundService)
CloseSound.SoundId = "rbxassetid://911393469" -- UI close sound

-- List of available commands with associated functions
local Commands = {
    {Command = "/help", Func = function() print("Help command executed.") end},
    {Command = "/kick", Func = function() print("Kick command executed.") end},
    {Command = "/ban", Func = function() print("Ban command executed.") end},
    {Command = "/mute", Func = function() print("Mute command executed.") end},
    {Command = "/unmute", Func = function() print("Unmute command executed.") end},
    {Command = "/tp", Func = function() print("Teleport command executed.") end},
    {Command = "/give", Func = function() print("Give command executed.") end},
    {Command = "/heal", Func = function() print("Heal command executed.") end},
    {Command = "/kill", Func = function() print("Kill command executed.") end},
    {Command = "/teleport", Func = function() print("Teleport to location.") end},
    {Command = "/teleportto", Func = function() print("Teleport to player.") end},
    {Command = "/teleportall", Func = function() print("Teleport all players.") end},
    {Command = "/speed", Func = function() print("Speed command executed.") end},
    {Command = "/godmode", Func = function() print("God mode enabled.") end},
    {Command = "/setlevel", Func = function() print("Set level command executed.") end},
    {Command = "/summon", Func = function() print("Summon command executed.") end},
    {Command = "/reset", Func = function() print("Reset command executed.") end},
    {Command = "/spawn", Func = function() print("Spawn command executed.") end},
    {Command = "/promote", Func = function() print("Promote command executed.") end},
    {Command = "/demote", Func = function() print("Demote command executed.") end},
    {Command = "/info", Func = function() print("Info command executed.") end},
    {Command = "/status", Func = function() print("Status command executed.") end},
}

-- Screen GUI
local ScreenGui = Instance.new("ScreenGui", PlayerGui)

-- Main Frame
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0.5, 0, 0.4, 0)
Frame.Position = UDim2.new(0.25, 0, -0.5, 0) -- Start off-screen
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 10)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.Text = "Command UI"
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1

-- Command Box
local CommandBox = Instance.new("TextBox", Frame)
CommandBox.Size = UDim2.new(0.8, 0, 0.2, 0)
CommandBox.Position = UDim2.new(0.1, 0, 0.3, 0)
CommandBox.PlaceholderText = "Enter command..."
CommandBox.Text = ""
CommandBox.TextSize = 18
CommandBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local UICornerCmd = Instance.new("UICorner", CommandBox)
UICornerCmd.CornerRadius = UDim.new(0, 8)

-- Box to display the list of commands (Initially hidden)
local CommandListBox = Instance.new("Frame", Frame)
CommandListBox.Size = UDim2.new(0.8, 0, 0.3, 0)
CommandListBox.Position = UDim2.new(0.1, 0, 0.6, 0)
CommandListBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CommandListBox.Visible = false

local UICornerBox = Instance.new("UICorner", CommandListBox)
UICornerBox.CornerRadius = UDim.new(0, 8)

local CommandListText = Instance.new("TextLabel", CommandListBox)
CommandListText.Size = UDim2.new(1, 0, 1, 0)
CommandListText.Text = "Available Commands: \n" .. table.concat(Commands, "\n")
CommandListText.TextSize = 16
CommandListText.TextColor3 = Color3.fromRGB(200, 200, 200)
CommandListText.BackgroundTransparency = 1

-- Arrow Button
local ArrowButton = Instance.new("TextButton", Frame)
ArrowButton.Size = UDim2.new(0.1, 0, 0.1, 0)
ArrowButton.Position = UDim2.new(0.45, 0, 0.85, 0)
ArrowButton.Text = "▼"
ArrowButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
ArrowButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local UICornerArrow = Instance.new("UICorner", ArrowButton)
UICornerArrow.CornerRadius = UDim.new(0, 8)

-- Arrow rotation animation when clicked
local function ToggleCommandList()
    if CommandListBox.Visible then
        -- Hide the box with a smooth fade and slide
        TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.25, 0, -0.5, 0)}):Play()
        CommandListBox.Visible = false
        ArrowButton.Rotation = 0
        CloseSound:Play()
    else
        -- Show the box with a smooth fade and slide
        TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.25, 0, 0.3, 0)}):Play()
        CommandListBox.Visible = true
        ArrowButton.Rotation = 180
        OpenSound:Play()
    end
end

ArrowButton.MouseButton1Click:Connect(ToggleCommandList)
ArrowButton.TouchTap:Connect(ToggleCommandList)

-- Open UI Animation
TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.25, 0, 0.3, 0)}):Play()
OpenSound:Play()

-- Command Execution
CommandBox.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        ClickSound:Play()
        -- Execute the command
        for _, cmd in ipairs(Commands) do
            if CommandBox.Text:lower() == cmd.Command:lower() then
                cmd.Func()
                CommandBox.Text = "" -- Clear input after execution
                break
            end
        end
    end
end)
