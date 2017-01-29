
fallTime = 3
<<<<<<< HEAD
=======

>>>>>>> 896840a99403e24589484d38b5daa3dd4bfebe5a
local touchedPlayer = false
local timeRemaining = 0;
local fallSpeed = 90;
local startY = 0
local movingDown = false
local firstUpdate = true

function Initialize()

	--Connect the LogicUpdate event on Space to the function called Update
	Space:ConnectLogicUpdate (Update)
  touchedPlayer = false
  
end


function Update(event)
  if (firstUpdate == true) then
    startY = Owner.Transform.Translation.Y
    firstUpdate = false
  end
  local movement = AubergineEngine.Vector3(0, 0, 0)
  movement.Y = fallSpeed * event.DeltaTime
  
  if (Owner.Transform.Translation.Y > startY + 100) then
    movingDown = true
  elseif (Owner.Transform.Translation.Y < startY) then
    movingDown = false
  end
  
  if (movingDown) then
    movement.Y = -fallSpeed * event.DeltaTime
  else 
    movement.Y = fallSpeed * event.DeltaTime
  end
  
  Owner.Transform:Translate(movement);
end

function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
  Space:DisconnectCollisionStarted (OnCollisionStarted)
end
