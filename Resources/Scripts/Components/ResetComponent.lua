--[[ PROPERTY(Integer) ]]--
OutOfBoundsWait = 1

--[[ PROPERTY(Integer) ]]--
OutOfBoundsReset = 1

--[[ PROPERTY(Integer) ]]--
ResetCameraSpeed = 1000

--[[ PROPERTY(Integer) ]]--
LowerBoundYReset = -800

--[[ PROPERTY(Integer) ]]--
startPosX = 0

--[[ PROPERTY(Integer) ]]--
startPosY = 0

FirstFrame = true

ResetX = 0
ResetY = 0

PreviousCameraSpeed = 50

ResetTime = 0
WaitTime = 0
IsWaiting = false
IsReseting = false

Camera = "None"

function Initialize()

	Space:ConnectLogicUpdate (Update)

end

function PropertiesUpdate()

  
end

function Update(event)
  if (FirstFrame) then
    Camera = Aubergine:GetCamera();
    FirstFrame = false
  end
  
  WaitTime = WaitTime - event.DeltaTime
  if (IsWaiting and WaitTime < 0) then
    Camera.CameraController:SetTarget(Owner);
    IsReseting = true
    ResetTime = OutOfBoundsReset
    IsWaiting = false
  end
  
  ResetTime = ResetTime - event.DeltaTime
  if (IsReseting and ResetTime < 0) then
    Camera.CameraController:SetSpeed(PreviousCameraSpeed);
    IsReseting = false
  end
  -- If the player has fallen out of the current screen,
  -- Put her back on the screen.
  -- This is primarily for testing stuff and can be
  -- removed
  if Owner.Transform.Translation.Y < LowerBoundYReset or event.Input:KeyDown(Keys.R) then
    --Owner.Transform:SetY(0)
    Owner.RigidBody:SetVelocityY(0)
    Owner.RigidBody:SetVelocityX(0)
    Owner.Transform.Translation = AubergineEngine.Vector3(ResetX, ResetY, Owner.Transform.Translation.Z)
    OutOfBounds()
  elseif event.Input:KeyDown(Keys.T) then
    Owner.RigidBody.IsOnGround = false
  end
  
end

function Kill()
  --OutOfBounds()
end

function OutOfBounds()
  WaitTime = OutOfBoundsWait
  IsWaiting = true
  if (Camera ~= "None") then
    PreviousCameraSpeed = Camera.CameraController:GetCameraSpeed()
    Camera.CameraController:SetTarget(nil);
    Camera.CameraController:SetSpeed(ResetCameraSpeed);
    
    Aubergine.UISpace:FindChild("LoseScreen"):GetComponent("FadeInOutWhite"):Activate()
    
  end
end

function SetResetLocation(x, y)
  ResetX = x
  ResetY = y
  
end

function OnCollisionStarted(updateEvent)
  
end

function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
