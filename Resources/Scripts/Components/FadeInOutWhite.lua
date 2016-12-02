--[[ PROPERTY(Integer) ]]--
FadeInTime = 1

--[[ PROPERTY(Integer) ]]--
HoldTime = 1

--[[ PROPERTY(Integer) ]]--
FadeOutTime = 1

FirstFrame = true

IsActivated = false
IsFadingIn = false
IsFadingOut = false
IsHolding = false

fadeTimer = 0

function Initialize()

	Space:ConnectLogicUpdate (Update)
  --Owner:ConnectCollisionStarted (OnCollisionStarted)
end

function Update(event)
  if (FirstFrame) then 
    fadeTimer = FadeInTime
    Owner.Sprite:SetAlpha(0)
    IsFadingIn = true
    FirstFrame = false
  end
  
  if (IsActivated) then
    fadeTimer = fadeTimer - event.DeltaTime  
    if (fadeTimer < 0) then fadeTimer = 0 end
    --print("TIME.."..(fadeTimer / FadeInTime))
    if (IsFadingIn) then
      Owner.Sprite:SetAlpha(1 - (fadeTimer / FadeInTime))
    elseif (IsFadingOut) then 
      Owner.Sprite:SetAlpha(fadeTimer / FadeInTime) 
    end
    if (IsFadingIn and fadeTimer <= 0) then
      IsFadingIn = false
      IsHolding = true
      IsFadingOut = false 
      fadeTimer = HoldTime
    end
    if (IsHolding and fadeTimer <= 0) then
      IsFadingIn = false
      IsHolding = false
      IsFadingOut = true 
      fadeTimer = FadeOutTime
    end
    
    if (IsFadingOut and fadeTimer <= 0) then
      IsFadingOut = false
      IsActivated = false 
    else 
      --print("sdfsdfsd")
    end
   
  end
  
end

function Activate()
  
  IsActivated = true
  IsFadingIn = true
  IsFadingOut = false
  IsHolding = false
  fadeTimer = FadeInTime
  Owner.Sprite:SetAlpha(0)

  cam = Aubergine:GetUICamera()
  
  cam.Transform:SetX(Owner.Transform.Translation.X)
  cam.Transform:SetY(Owner.Transform.Translation.Y)
end

function PropertiesUpdate()

  
end

function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
