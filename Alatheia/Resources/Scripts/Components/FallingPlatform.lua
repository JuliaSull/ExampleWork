firstUse = true
updateMusic = false
fallTime = 3
musicUpdate = 0

local touchedPlayer = false
local timeRemaining = 0;
local fallSpeed = 90;

function Initialize()

	--Connect the LogicUpdate event on Space to the function called Update
	Space:ConnectLogicUpdate (Update)
  Owner:ConnectCollisionStarted (OnCollisionStarted)
  Owner:ConnectCollisionPersisted (OnCollisionPersisted)
  touchedPlayer = false
end


function Update(event)

  if (touchedPlayer == true) then  
    timeRemaining = timeRemaining - event.DeltaTime
    if (timeRemaining <= 0) then
      Owner.RigidBody.HasGravity = true
      Owner.RigidBody.Static = false
    end
  end

  if (Owner.RigidBody.Static == false) then
    local movement = AubergineEngine.Vector3(0, 0, 0)
    movement.Y = -fallSpeed * event.DeltaTime
    Owner.Transform:Translate(movement);
  end
  
  --if (firstUse) then
  --  firstUse = false
  --  updateMusic = true
  --end
  --
  --if (updateMusic and musicUpdate < 1) then
  --  musicUpdate = musicUpdate + event.DeltaTime
  --  player.SoundEmitter:SetGlobalVariable("OlympusLevelLoad", 3 + musicUpdate)
  --  player.SoundEmitter:UpdateSoundEvent("OlympusLevelLoad")
  --end
end

function OnCollisionStarted(event)

	if (event.CollidedWith.Name == "Alatheia" and
      touchedPlayer == false) then
     
    touchedPlayer = true;
    timeRemaining = fallTime;
  end

end

function OnCollisionPersisted(event)
  --print("222222222222222222222222222222") 
end

function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
  Space:DisconnectCollisionStarted (OnCollisionStarted)
end
