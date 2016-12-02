--[[ PROPERTY(Texture) ]]--
OnTexture = "Button_Down.png"
             
--[[ PROPERTY(Texture) ]]--
OffTexture = "Button_Up.png"
             
--[[ PROPERTY(Texture) ]]--
OutTexture = "Button_Up.png"
             
--[[ PROPERTY(Texture) ]]--
DownTexture = "Button_Down.png"
             
--[[ PROPERTY(SoundEvent) ]]--
OverSound = "None"
             
--[[ PROPERTY(SoundEvent) ]]--
SelectSound = "None"
             
--[[ PROPERTY(Cog) ]]--
Target = "None"  
             
--[[ PROPERTY(Component) ]]--
Component = "None"
             
--[[ PROPERTY(Function) ]]--
Function = "None"
             
--[[ PROPERTY(Level) ]]--
LevelToLoad = "None"

--[[ PROPERTY(Cog) ]]--
CameraTarget = "None"

--[[ PROPERTY(Integer) ]]--
CameraSpeed = 1

--[[ PROPERTY(Cog) ]]--
WorldCameraTarget = "None"

--[[ PROPERTY(Integer) ]]--
WorldCameraSpeed = 1

--[[ PROPERTY(Boollock) ]]--
OnlyOnPause = true

--[[ PROPERTY(Bool) ]]--
ExitGame = false

currentState = "Off"
previousState = "Off"
wasClicked = false
clickWasInside = false


function Initialize()

  Space:ConnectLogicUpdate (Update)

end

function Update(event)

  if (OnlyOnPause and not Aubergine.Paused) then
    return
  end
  
  Owner.Sprite:SetAlpha(1)
  
  local mouseInside = IsMouseInsideUI(event);
  
  if (not OnlyOnPause)then
    mouseInside = IsMouseInside(event);
  end
  
  local mouseDown = event.Input:IsLeftMouseDown();
  local clickStarted = (mouseDown and not wasClicked)
  local clickEnded = (not mouseDown and wasClicked)
  
  if (mouseInside and mouseDown) then
    currentState = "Down"
    Owner.Sprite:SetTexture(DownTexture)
    --Aubergine:PushUserMessage("Down")
  elseif (mouseInside and not mouseDown) then
    currentState = "On"
    Owner.Sprite:SetTexture(OnTexture)
    --Aubergine:PushUserMessage("On")
  elseif (not mouseInside and not mouseDown) then
    currentState = "Off"
    Owner.Sprite:SetTexture(OffTexture)
    --Aubergine:PushUserMessage("OFF")
  end
  
  if (clickStarted and mouseInside) then
    clickWasInside = true
  end
  
  if (clickEnded and clickWasInside) then
    
    Activate()
    
  end
  
  if (not mouseDown) then
    clickWasInside = false
    
  end

  if (OverSound ~= "None" and previousState == "Off" and currentState == "On") then
    Owner.SoundEmitter:PlaySoundEvent(OverSound)
  end

  wasClicked = mouseDown
  previousState = currentState
  
end

function Activate()

  Aubergine:PushUserMessage(CameraTarget)
  if (SelectSound ~= "None" and SelectSound ~= "") then
    Owner.SoundEmitter:PlaySoundEvent(SelectSound)
  end

  if (Target ~= "None" and Component ~= "None" and Function ~= "None" and
      Target ~= "" and Component ~= "" and Function ~= "") then
    local exeString = ""
    exeString = exeString.."Aubergine.UISpace:FindChild(\""
    exeString = exeString..Target
    exeString = exeString.."\")"
    exeString = exeString..":GetComponent(\""
    exeString = exeString..Component
    exeString = exeString.."\"):"
    exeString = exeString..Function
    exeString = exeString.."()"
    
    Aubergine:ExecuteLuaString(exeString)
  end

  if (LevelToLoad ~= "None" and LevelToLoad ~= "") then
    Aubergine.Paused = false
    Aubergine:GetCamera().CameraController:SetTarget(nil)
    Aubergine:GetUICamera().CameraController:SetTarget(nil)
    Aubergine:PushUserMessage(LevelToLoad)
    Aubergine:LoadLevel(LevelToLoad) 
  end
  
  if (CameraTarget ~= "None" and CameraTarget ~= "") then
    local cam = Aubergine:GetUICamera()
    
    if (cam ~= nil) then
      cam.CameraController:SetTargetString(CameraTarget)
      cam.CameraController:SetSpeed(2000)
      cam.CameraController:SetSize(1500) 
    else
      Aubergine:PushUserMessage("THE CAMERA WAS NIL")
    end
  end
  
  if (WorldCameraTarget ~= "None" and WorldCameraTarget ~= "") then
    local cam = Aubergine:GetCamera()
    
    if (cam ~= nil) then
      cam.CameraController:SetTargetString(WorldCameraTarget)
      cam.CameraController:SetSpeed(WorldCameraSpeed)
    else
      Aubergine:PushUserMessage("THE CAMERA WAS NIL")
    end
  end
  
  if (ExitGame) then
    Aubergine:QuitGame()
  end
end

function IsMouseInsideUI(event)
  local mousePos = event.Input:GetUIMousePosition()
  local myPos = Owner.Transform.Translation
  local myScale = Owner.Transform.Scale
  local minX = myPos.X - (myScale.X / 2)
  local minY = myPos.Y - (myScale.Y / 2)
  local maxX = myPos.X + (myScale.X / 2)
  local maxY = myPos.Y + (myScale.Y / 2)

  return not (mousePos.X < minX or 
              mousePos.X > maxX or
              mousePos.Y < minY or
              mousePos.Y > maxY)
  
end

function IsMouseInside(event)
  local mousePos = event.Input:GetMousePosition()
  local myPos = Owner.Transform.Translation
  local myScale = Owner.Transform.Scale
  local minX = myPos.X - (myScale.X / 2)
  local minY = myPos.Y - (myScale.Y / 2)
  local maxX = myPos.X + (myScale.X / 2)
  local maxY = myPos.Y + (myScale.Y / 2)

  return not (mousePos.X < minX or 
              mousePos.X > maxX or
              mousePos.Y < minY or
              mousePos.Y > maxY)
  
end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
