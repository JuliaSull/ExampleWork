
--Declare a local variable, local is not required but does not affect functionality
local speed = 1
local distanceToTravel = 100
local totalDistanceMoved = 0
local firstFrame = true

--Every component is required to have a function called Initialize
--When a component is created the Engine will call this function with no arguments
function Initialize()
	--Connect the LogicUpdate event on Space to the function called Update
	Space:ConnectLogicUpdate (Update)
  
  --Owner.Transform:Translate(AubergineEngine.Vector3(0, 0, math.random(5, 50)))
end

--This function was connected to the LogicUpdate event on the Space
--It will be called expecting one argument, and that will be a
--LogicUpdateEvent object
function Update(updateEvent)

  if (firstFrame) then
    firstFrame = false
    local percentDone = math.random(10, 75)
    Owner.Transform:SetX(math.random(-25, 75))
    Owner.Transform:SetY(math.random(-40, -60))
    Owner.Transform:SetZ(math.random() * 4 + 1) 
    local scale = math.random(1, 10)
    speed = (11 - scale) / 4
    Owner.Sprite:SetTint(0.6, 0.6, 0.6, 1)
    Owner.Transform:SetScaleX(scale)
    Owner.Transform:SetScaleY(scale)
    totalDistanceMoved = distanceToTravel * (percentDone / 100)
    Owner.Transform:SetY(Owner.Transform.Translation.Y + totalDistanceMoved)
  end

	local movement = AubergineEngine.Vector3(0, 0, 0)
  
  movement.Y = speed * updateEvent.dt
  totalDistanceMoved = totalDistanceMoved + movement.X
  if (totalDistanceMoved > distanceToTravel) then
  
    Owner.Transform:SetY(Owner.Transform.Translation.Y - totalDistanceMoved);
    totalDistanceMoved = 0
  end

	Owner.Transform:Translate(movement)
end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
