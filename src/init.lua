--[[
    ============================================================
    CRIMSON UI LIBRARY - V4.0 (MODULAR ARCHITECTURE)
    Structure: Multi-File Module Pattern
    Entry Point: src/init.lua
    Author: Raphael
    ============================================================
]]

local Library = {
    _version = "4.0",
    _author = "Raphael99090",
    Connections = {},
    Tweens = {}
}

-- ============================================================
-- [ SERVICES ]
-- ============================================================
local script_root = script.Parent
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- ============================================================
-- [ MODULE LOADING ]
-- ============================================================

local function require_module(module_name)
    local module = script_root:WaitForChild(module_name)
    return require(module)
end

-- Load modules in correct order
Library.Theme = require_module("modules/Theme")
Library.Utils = require_module("modules/Utils")
Library.Components = require_module("modules/Components")
Library.Window = require_module("modules/Window")

-- ============================================================
-- [ UTILITIES ]
-- ============================================================

function Library:Cleanup()
    for _, connection in ipairs(self.Connections) do
        if connection then pcall(function() connection:Disconnect() end) end
    end
    for _, tween in ipairs(self.Tweens) do
        if tween then pcall(function() tween:Cancel() end) end
    end
    self.Connections = {}
    self.Tweens = {}
end

function Library:GetVersion()
    return self._version
end

function Library:GetAuthor()
    return self._author
end

-- ============================================================
-- [ EXPORT ]
-- ============================================================

return Library
