
--Declare a local variable, local is not required but does not affect functionality
local speed = 1
local distanceToTravel = 140
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
    speed = math.random() * 2 + 1
    Owner.Sprite:SetAlpha(0.7)
    local percentDone = math.random(10, 75)
    Owner.Transform:SetX(-50)
    Owner.Transform:SetY(math.random(-50, 10))
    Owner.Transform:SetZ(math.random() * 15 + 1)
    local randomTransform = math.random(10, 40)
    Owner.Transform:SetScaleX(randomTransform * 2.5)
    Owner.Transform:SetScaleY(randomTransform)
    
    
    totalDistanceMoved = distanceToTravel * (percentDone / 100)
    Owner.Transform:SetX(Owner.Transform.Translation.X + totalDistanceMoved)
  end

	local movement = AubergineEngine.Vector3(0, 0, 0)
  
  movement.X = speed * updateEvent.dt
  totalDistanceMoved = totalDistanceMoved + movement.X
  if (totalDistanceMoved > distanceToTravel) then
  
    Owner.Transform:SetX(Owner.Transform.Translation.X - totalDistanceMoved - (Owner.Transform.Scale.X / 2));
    totalDistanceMoved = 0
  end

	Owner.Transform:Translate(movement)
end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
