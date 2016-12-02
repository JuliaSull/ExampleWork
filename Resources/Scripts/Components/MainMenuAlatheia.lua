--[[ PROPERTY(Skeleton) ]]--
skeleton = 0
--[[ PROPERTY(Animation) ]]--
animation = 0
--[[ PROPERTY(Cog) ]]--
Target = "None"

timecur = 0

--[[ PROPERTY(bool) ]]--
shouldPoint = true

local firstFrame = true;
centerScreen = 0

function Initialize()
  Space:ConnectLogicUpdate (Update)
end

function PropertiesUpdate()
	Aubergine:PushUserMessage("Properties Potato")
	Owner.SpineComponent:SetSpineData(skeleton)
	Owner.SpineComponent:SetAnimation(animation)
end

function Update(updateEvent)
  if (firstFrame) then
    firstFrame = false

    if (Target ~= "None") then
      centerScreen = Space:FindChild(Target)
      cam = Aubergine:GetCamera();
      cam.CameraController:SetTarget(centerScreen);
      cam.CameraController:SetSpeed(0.1);
      cam.CameraController:SetSize(67);

      cam.Transform:SetX(centerScreen.Transform.Translation.X)
      cam.Transform:SetY(centerScreen.Transform.Translation.Y)

      Owner.SpineComponent:SetSpineData(skeleton)
      Owner.SpineComponent:SetAnimation("idle1")
    end
  end

  if (centerScreen == nil) then
    if (Target ~= "None") then
      centerScreen = Space:FindChild("CenterScreen")
    end
    Owner.SoundEmitter:SetGlobalVariable("Wind", 90)
    Owner.SoundEmitter:PlaySoundEvent("MainMenuLoad")
  end



  --Point a the thing
  if shouldPoint then
    --print("POINTING!")
    --Hold the mouse position and the player positiondaw
    local worldMousePos = updateEvent.Input:GetMousePosition()
    local worldPlayerPos = Owner.Transform.Translation

    ----Find the offset of the arm
    --armOffset = AubergineEngine.Vector2((worldMousePos.X - (worldPlayerPos.X)) * scale, (worldMousePos.Y - worldPlayerPos.Y) * scale + 0.4)
    armOffset = Owner.SpineComponent:WorldToSpine(worldMousePos)

    if Owner.SpineComponent.Mirrored then
      armOffset.X = -armOffset.X
    end

    --CHange spine to make her point based off the arm offset
    --if MagSquared(armOffset) > 500 then
      Owner.SpineComponent:SetIKConstraint("Front arm", armOffset, 0)
  end

  --timecur = timecur + updateEvent.DeltaTime
  --local val = math.sin(timecur) * 100;
  --print(val)
  --Aubergine:SetVolume(0)

  --local pos = Aubergine:GetSoundEventPosition("MainMenuLoad", 1, 0);
  --Aubergine:PushUserMessage(pos)

end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
