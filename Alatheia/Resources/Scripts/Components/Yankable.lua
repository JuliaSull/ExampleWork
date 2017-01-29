dropSpeed = 50
yankTimeRequired = 1.0
fallTime = 7
startYanking = false
player = 0
isFalling = false

firstUse = true
updateMusic = false
musicUpdate = 0

player = Nil

function Initialize()

	Space:ConnectLogicUpdate (Update)
  Owner:ConnectGrappleStarted(GrappleStarted)
  Owner:ConnectGrappleEnded(GrappleEnded)
  player = Space:FindChild("Alatheia")
end

function Update(event)
  if (startYanking and yankTimeRequired > 0) then
    yankTimeRequired = yankTimeRequired - event.DeltaTime
  end 
  
  if (yankTimeRequired < 0 and not isFalling) then
    Owner.RigidBody.HasGravity = true
    Owner.RigidBody.Static = false
    fallTime = fallTime - event.DeltaTime
    isFalling = true
    
    pc = player:GetComponent("PlayerController")
    if(pc ~= Nil)then
      player.GrappleComponent:StopDrawRope();
      pc.isGrappling = false
      if (obj ~= nil) then 
        player.SoundEmitter:PlaySoundEvent("GrappleEnd")
      end
    end
  end
  
  if (isFalling and Owner.RigidBody.IsOnGround) then
    Owner.RigidBody.HasGravity = false
    Owner.RigidBody.Static = true
  end
  
  
  
  if (updateMusic and musicUpdate < 3) then
    musicUpdate = musicUpdate + event.DeltaTime
    player.SoundEmitter:SetGlobalVariable("Music Power", 3 + (musicUpdate / 3))
    player.SoundEmitter:UpdateSoundEvent("OlympusLevelLoad")
  end
end

function GrappleStarted(event)
  if (firstUse) then
    firstUse = false
    updateMusic = true
  end
  startYanking = true
  player = event.Player
end

function GrappleEnded(event)
  startYanking = false
end

function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
  Owner:DisconnectGrappleStarted(GrappleStarted)
  Owner:DisconnectGrappleEnded(GrappleEnded)
end
