
correctRange = 150   -- The range the mekazoo will start spinning the player
spinEpsilon = 50     -- The epsilon from correctRange spinning will occur
vacuumEpsilon = 25   -- The epsilon the mekazoo will continue to pull you in until
player = 0           -- The player. Must be named Alatheia
minSwingSpeed = 175  -- Minimum speed the player will go around the mekazoo
maxSwingSpeed = 500 -- Maximum speed the player will go around the mekazoo
acceleration = 1.05  -- Acceleration of swing
direction = 0        -- 1 = Clockwise, -1 = counterclockwise
startedMoving = 0    -- 1 if this was the first swing frames after hitting J
forceDirection = 0
firstGrapple = true
updateMusic = false
musicUpdate = 0
swingMultiplier = 0.5
maxSpeed = false

local isSwing = false

function mag(vec)
  return math.sqrt(vec.X * vec.X + vec.Y * vec.Y)
end

function Initialize()
  -- Subscribe to logic update
	Space:ConnectLogicUpdate (Update)
  Owner:ConnectGrappleStarted (GrappleStarted)
  Owner:ConnectGrappleEnded (GrappleEnded)
  -- Store the player
  player = Space:FindChild("Alatheia")
end

function Update(event)
  if (not firstGrapple and musicUpdate < 3) then
    musicUpdate = musicUpdate + event.DeltaTime
    player.SoundEmitter:SetGlobalVariable("Music Power", 1 + (musicUpdate / 3))
    --player.SoundEmitter:UpdateSoundEvent("OlympusLevelLoad")
  end

  if(isSwing) then
    player.RigidBody:SetVelocityX(player.RigidBody.Velocity.X * (1 + swingMultiplier * event.DeltaTime))
    player.RigidBody:SetVelocityY(player.RigidBody.Velocity.Y * (1 + swingMultiplier * event.DeltaTime))
    local vel = player.RigidBody.Velocity
    local moog = math.sqrt(vel.X * vel.X + vel.Y * vel.Y)
    local percentage = (moog / 975) * 100
    --Aubergine:PushUserMessage("Thing :"..percentage)
    player.SoundEmitter:SetGlobalVariable("Swing Velocity", percentage)
    --player.SoundEmitter:UpdateSoundEvent("MekazooSpeedUp")

    if (percentage >= 100 and not maxSpeed) then
      --player.SoundEmitter:StopSoundEventFadeOut("MekazooSpeedUp")
      
      maxSpeed = true
      --Aubergine:PushUserMessage("HERE")
    end
  end
end

function GrappleStarted(event)
  isSwing = true
  if (firstGrapple) then
    firstGrapple = false
  end
  maxSpeed = false
  player.SoundEmitter:PlaySoundEvent("MekazooSpeedUp")
  --player.SoundEmitter:PlaySoundEvent("MekazooSpeedUp")
end

function GrappleEnded(event)
  isSwing = false
  maxSpeed = false
  player.SoundEmitter:StopSoundEventFadeOut("MekazooSpeedUp")
  --player.SoundEmitter:StopSoundEventFadeOut("MekazooSpeedUp")
end

function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
