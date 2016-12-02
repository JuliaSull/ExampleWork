--[[
	This is a script file to handle initizing test cases.

	It has a few tests as well as some code that could be useful
	for reference later, such as handling game objects and textures
--]]

function PrintVec3(vec)
	print("("..vec.X..", "..vec.Y..", "..vec.Z..")")
end

function PrintVec2(vec)
	print("("..vec.X..", "..vec.Y..")")
end


local speedMultiplier = 8

--Create a GameObject and hold a reference to it
--local is not required, but I like to use it
--to be clear that a declaration is happening

--NOTICE that ':' was used instead of '.'
--		In lua ':' is used for calling member functions
--		and '.' is namespace/member access
player = Aubergine:CreateObject("Player")
player.Transform.Translation = AubergineEngine.Vector3(-80, -70, 5)
player.Transform.Scale = AubergineEngine.Vector2(20, 40)
player:AddSprite()
player.Sprite:SetTexture("valk_anim_02.png")
player.Sprite:SetFrames(8, 1)
player:AddSpriteAnimator()
player.SpriteAnimator.Framerate = 1 * speedMultiplier
player.SpriteAnimator.ShouldAnimate = true
player:AddComponent("PlayerController")

--When adding a component that has been implemented in lua, this is the syntax
--All previous components were C++, PlayerController is in lua
--The argument to the AddComponent function is the name of the component type as a string
--object1:GetComponent("PlayerController").speed = 35

local worldScale = AubergineEngine.Vector2(500, 300)
local worldStartY = 25

local background = Aubergine:CreateObject("Background")
background.Transform.Translation = AubergineEngine.Vector3(0, worldStartY, 1)
background.Transform.Scale = worldScale
background:AddSprite()
background.Sprite:SetTexture("background_1.png")

background:AddComponent("ParralaxComponent")
background:GetComponent("ParralaxComponent").multiplier = 8

local background2 = Aubergine:CreateObject("Background")
background2.Transform.Translation = AubergineEngine.Vector3(worldScale.X, worldStartY, 1)
background2.Transform.Scale = worldScale
background2:AddSprite()
background2.Sprite.MirrorX = true
background2.Sprite:SetTexture("background_1.png")

background:AddComponent("ParralaxComponent")
background:GetComponent("ParralaxComponent").multiplier = 8
background:GetComponent("ParralaxComponent").always_move = true

background2:AddComponent("ParralaxComponent")
background2:GetComponent("ParralaxComponent").multiplier = 8
background2:GetComponent("ParralaxComponent").always_move = true

local foreground = Aubergine:CreateObject("Foreground")
foreground.Transform.Translation = AubergineEngine.Vector3(0, worldStartY, 10)
foreground.Transform.Scale = worldScale
foreground:AddSprite()
foreground.Sprite:SetTexture("foreground_01.png")

local foreground2 = Aubergine:CreateObject("Foreground")
foreground2.Transform.Translation = AubergineEngine.Vector3(worldScale.X, worldStartY, 10)
foreground2.Transform.Scale = worldScale
foreground2:AddSprite()
foreground2.Sprite.MirrorX = true;
foreground2.Sprite:SetTexture("foreground_01.png")

foreground:AddComponent("ParralaxComponent")
foreground:GetComponent("ParralaxComponent").multiplier = 30
foreground:GetComponent("ParralaxComponent").always_move = true

foreground2:AddComponent("ParralaxComponent")
foreground2:GetComponent("ParralaxComponent").multiplier = 30
foreground2:GetComponent("ParralaxComponent").always_move = true


local mid = Aubergine:CreateObject("Ground")
mid.Transform.Translation = AubergineEngine.Vector3(0, worldStartY, 3)
mid.Transform.Scale = worldScale
mid:AddSprite()
mid.Sprite:SetTexture("midground.png")

local mid2 = Aubergine:CreateObject("Ground")
mid2.Transform.Translation = AubergineEngine.Vector3(worldScale.X, worldStartY, 3)
mid2.Transform.Scale = worldScale
mid2:AddSprite()
mid2.Sprite.MirrorX = true
mid2.Sprite:SetTexture("midground.png")

mid:AddComponent("ParralaxComponent")
mid:GetComponent("ParralaxComponent").multiplier = 21
mid:GetComponent("ParralaxComponent").always_move = true

mid2:AddComponent("ParralaxComponent")
mid2:GetComponent("ParralaxComponent").multiplier = 21
mid2:GetComponent("ParralaxComponent").always_move = true

local mid3 = Aubergine:CreateObject("Ground")
mid3.Transform.Translation = AubergineEngine.Vector3(worldScale.X * (0.5 * 0.7), worldStartY + 1, 2)
mid3.Transform.Scale = AubergineEngine.Vector2(worldScale.X * 0.7, worldScale.Y * 0.7)
mid3:AddSprite()
mid3.Sprite:SetTexture("midground.png")
mid3.Sprite.Tint = AubergineEngine.Vector4(0.6, 0.6, 0.7, 1)

local mid4 = Aubergine:CreateObject("Ground")
mid4.Transform.Translation = AubergineEngine.Vector3(worldScale.X * (1.5 * 0.7), worldStartY + 1, 2)
mid4.Transform.Scale = AubergineEngine.Vector2(worldScale.X * 0.7, worldScale.Y * 0.7)
mid4:AddSprite()
mid4.Sprite.MirrorX = true
mid4.Sprite:SetTexture("midground.png")
mid4.Sprite.Tint = AubergineEngine.Vector4(0.6, 0.6, 0.7, 1)

mid3:AddComponent("ParralaxComponent")
mid3:GetComponent("ParralaxComponent").multiplier = 15
mid3:GetComponent("ParralaxComponent").always_move = true

mid4:AddComponent("ParralaxComponent")
mid4:GetComponent("ParralaxComponent").multiplier = 15
mid4:GetComponent("ParralaxComponent").always_move = true