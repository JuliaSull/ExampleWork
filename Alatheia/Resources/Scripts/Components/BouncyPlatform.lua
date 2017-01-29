
-- Note: Currently Collision started is still being worked on
-- So the current implementation is very basic. 
--[[
local yVel = 0

function Initialize()
	Owner:ConnectCollisionStarted (OnCollisionStarted)
  Owner:ConnectCollisionStarted (OnCollisionStarted)
end

function OnCollisionStarted(event)
  Aubergine:PushUserMessage("Collided")
  -- If we hit Alatheia
  if (event.CollidedWith.RigidBody ~= Nil) then
    
    
    -- Either set her Y Velocity to its absolute value
    -- or just make it 10. 
    local y = event.Velocity.Y
    if (y == 0) then
      y = 10
    end
    y = math.abs(y)
    
    --event.CollidedWith.RigidBody:SetVelocityY(y);
    
    --event.CollidedWith.Transform:SetY(event.CollidedWith.Transform.Translation.Y)
    
    yVel = y
    
    --Aubergine:PushUserMessage("Bounce! :"..y)
    
  end
end

function OnCollisionEnded(event)
  event.CollidedWith.RigidBody:SetVelocityY(yVel);
end

function Destroy(event)
	Space:DisconnectCollisionStarted(OnCollisionStarted)
  Space:DisconnectCollisionEnded(OnCollisionEnded)
end
--]]