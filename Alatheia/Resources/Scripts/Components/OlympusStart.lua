
firstFrame = true

function Initialize()

	Space:ConnectLogicUpdate (Update)
 
end

function Update(updateEvent)
  if (firstFrame) then
    firstFrame = false
    Owner.SoundEmitter:StopAllSoundEventsImmediate()
    Owner.SoundEmitter:PlaySoundEvent("OlympusWind")
    Owner.SoundEmitter:PlaySoundEvent("OlympusMusicIntro")
  end
end 


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
