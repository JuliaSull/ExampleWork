--[[ PROPERTY(Double) ]]--
HoldTime = 2

--[[ PROPERTY(Double) ]]--
FadeTime = 2

--[[ PROPERTY(Double) ]]--
CameraSize = 50

--[[ PROPERTY(SoundEvent) ]]--
Music = "None"

--[[ PROPERTY(SoundEvent) ]]--
SoundToPlay = "None"

--[[ PROPERTY(Level) ]]--
LevelToLoad = "None"

Mode = "Hold"

FirstFrame = true;

timer = 0;

function Initialize()

	Space:ConnectLogicUpdate (Update)

end

function Update(event)

  if (FirstFrame) then
    if (Music ~= "None") then
      Owner.SoundEmitter:PlaySoundEvent(Music)
    end
    cam = Aubergine:GetCamera();
    cam.CameraController:SetTarget(Owner);
    cam.CameraController:SetSpeed(15);
    cam.CameraController:SetSize(CameraSize);
    cam.Transform:SetX(Owner.Transform.Translation.X)
    cam.Transform:SetY(Owner.Transform.Translation.Y)
    timer = HoldTime
    FirstFrame = false
  end
  if (Mode == "Hold") then
    timer = timer - event.DeltaTime
    if (timer < 0) then
      timer = FadeTime
      Mode = "FadeOut"
      if (SoundToPlay ~= "None") then
        Owner.SoundEmitter:PlaySoundEvent(SoundToPlay)
      end
    end
  elseif (Mode == "FadeOut") then
    timer = timer - event.DeltaTime

		if(Owner.Sprite ~= Nil)then
	    Owner.Sprite:SetAlpha(timer)
		end

    if (timer < 0) then
      if (LevelToLoad ~= "None") then
        Aubergine:LoadLevel(LevelToLoad)
      end
    end
  end

end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
