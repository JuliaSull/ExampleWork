
MoveVelocity = 40  -- If you are doing stiff x controlls have this high, like 80. else have low like 5
JumpForce = 2000   -- Change for how high you can jump
MaxJumpCount = 1   -- Change how many jumps she can do
JumpCount = 0      -- Don't change used to measure how many jumps were done
AddJumDur = 0.13      -- Change for how long she can stay in the air
AddJumTim = 0      -- Don't change used to measure how long she was in air
Deccel = 4;        -- Ignore this with stiff controlls, otherwise change how fast she

BarLength = 1.4545
WillTransition = false
WillGoMainLoop = false
TransitionTime = 0
TimeTillMainLoop = 0
CurrentTimeIntro = 0


ObjectGrappledTo = 0

jump_key_down = false  -- Helps find out if we jumped already

wasGrappling = false  -- If you were grappling
firstFrame = true
firstGrapple = true

maxSpeedX = 200
animRunSpeed = 200
airDrag = 0.999
groundDrag = 0.85

ObjectGrappledTo = nil

--[[ PROPERTY(Animation) ]]--
runanim = "sprint"

--[[ PROPERTY(Animation) ]]--
jumpanim = "jump"


--[[ PROPERTY(Animation) ]]--
idleanim = "idle1"

moveskele = "side"

jumpskele = "side_Eddie"

idleskele = "skeleton"

--[[ PROPERTY(Animation) ]]--
swinganim = "sprint"

function MagSquared(a)
  dx = a.X
  dy = a.Y

  return dx * dx + dy * dy
end

function Magnitude(a)
  return math.sqrt(MagSquared(a))
end

function Normalize(a)
  local mag = Magnitude(a)
  return AubergineEngine.Vector2(a.X / mag, a.Y  / mag)
end

function IsClockwise(a, b)
  if a.X * b.Y > a.Y * b.X then
    --print("clockwise")
    return true
  else
    --print("not clockwise")
    return false
  end

  return false
end

function Initialize()
	--Connect the LogicUpdate event to the function called Update
	Space:ConnectLogicUpdate(Update)

  --Load the HUD Space into the engine's UI Space

end

function Destroy()
	Space:DisconnectLogicUpdate(Update)
end

function PropertiesUpdate()
	print("Player Properties Updated")
	Owner.SpineComponent:SetSpineData(idleskele)
	Owner.SpineComponent:SetAnimation(idleanim)


end

function Update(event)
  --Aubergine:PushUserMessage("Z: "..Owner.Transform.Translation.Z)
  if (firstFrame) then
    firstFrame = false
    Owner.SpineComponent:SetAnimated(true)
    cam = Aubergine:GetCamera();
    cam.CameraController:SetTarget(Owner);
    cam.CameraController:SetSpeed(800);
    cam.CameraController:SetSize(500);
    cam.Transform:SetX(Owner.Transform.Translation.X + 1000)
    cam.Transform:SetY(Owner.Transform.Translation.Y)
    Owner.SoundEmitter:SetGlobalVariable("IsIntro", 1)
    Aubergine:LoadUILevel("HUD Space")


  end

  if (event.Input:KeyDown(Keys.H)) then
    cam = Aubergine:GetCamera();
    cam.CameraController:SetTarget(Owner);
    cam.CameraController:SetSpeed(800);
    cam.CameraController:SetSize(500);
    cam.Transform:SetX(Owner.Transform.Translation.X)
    cam.Transform:SetY(Owner.Transform.Translation.Y)
  end

  currentTime = Aubergine:GetSoundEventPosition("OlympusMusicMain", 0, 0);

  Owner.SoundEmitter:SetGlobalVariable("Music Time", currentTime)

  CurrentTimeIntro = Aubergine:GetSoundEventPosition("OlympusMusicIntro", 0, 0);

  --Aubergine:PushUserMessage(currentTime)

  --


  --If grappling, rotate player to look swing-ey
  if isGrappling and ObjectGrappledTo ~= nil then
    local x = Owner.Transform.Translation.X - ObjectGrappledTo.Transform.Translation.X
    local y = Owner.Transform.Translation.Y - ObjectGrappledTo.Transform.Translation.Y

    local angle = math.atan2(y, x) + (math.pi / 2)

    Owner.Transform.Rotation = angle

    local vel = Owner.RigidBody.Velocity
    local clockwise = IsClockwise(vel, AubergineEngine.Vector2(x, y))

    ----Find the offset of the arm
    armOffset = AubergineEngine.Vector2(0, 0.95)

    --Change spine to make her point based off the arm offset
    Owner.SpineComponent:SetIKConstraint("Front arm", armOffset, 0)

    --local handpos = Owner.SpineComponent:SpineToWorld(Owner.SpineComponent:GetIKConstraintPos("Front arm"))--AubergineEngine.Vector3(0, 0, 0)--
    local handpos = Owner.SpineComponent:GetIKConstraintPos("Front arm")
    local scale = 0.02
    handpos = AubergineEngine.Vector3(Owner.Transform.Translation.X - (x * 0.11), Owner.Transform.Translation.Y - (y * 0.11), 0)
    --print("hand: "..handpos.X..","..handpos.Y)
    local pos = Owner.Transform.Translation
    Owner.GrappleComponent:DrawRope(handpos, Owner.GrappleComponent:GetHitLocation(), 2)

    if clockwise then
      Owner.SpineComponent.Mirrored = true
    else
      Owner.SpineComponent.Mirrored = false
    end

  else
    --Hold the mouse position and the player positiondaw
    local worldMousePos = event.Input:GetMousePosition()
    local worldPlayerPos = Owner.Transform.Translation



    ----Find the offset of the arm
    local scale = 0.02
    armOffset = AubergineEngine.Vector2((worldMousePos.X - (worldPlayerPos.X)) * scale, (worldMousePos.Y - worldPlayerPos.Y) * scale + 0.4)
    --armOffset = Owner.SpineComponent:WorldToSpine(worldMousePos)

    if event.Input:IsRightMouseDown() then
      --print("Player World: "..worldPlayerPos.X..", "..worldPlayerPos.Y)
      --print("World Mouse Position: "..worldMousePos.X..", "..worldMousePos.Y)
      --print("Spine Mouse Position: "..armOffset.X..", "..armOffset.Y)
    end

    if Owner.SpineComponent.Mirrored then
      armOffset.X = -armOffset.X
    end

    --CHange spine to make her point based off the arm offset
    --if MagSquared(armOffset) > 500 then
      Owner.SpineComponent:SetIKConstraint("Front arm", armOffset, 0)
    --end
  end

  if (event.Input:IsLeftMouseDown() and not isGrappling) then
    local selfTrans = Owner.Transform.Translation;
    local mousePos = event.Input:GetMousePosition();
    ObjectGrappledTo = Owner.GrappleComponent:CastRayToMouse(selfTrans, mousePos);



    isGrappling = true
    if (ObjectGrappledTo ~= nil) then
      Owner.SoundEmitter:PlaySoundEvent("GrappleStart")
      Owner.SpineComponent:SetSpineData(moveskele)
      Owner.SpineComponent:SetAnimation(swinganim)
      Owner.SpineComponent:SetAnimationSpeed(1)

      if (firstGrapple) then
        WillTransition = true
        TransitionTime = 0
        while (TransitionTime < currentTime) do
          TransitionTime = TransitionTime + BarLength
        end

        Owner.SoundEmitter:SetGlobalVariable("IsIntro", 0.5)
        Owner.SoundEmitter:UpdateSoundEvent("OlympusMusicIntro")

        firstGrapple = false
      end
    end

  elseif (not event.Input:IsLeftMouseDown() and isGrappling) then
    Owner.GrappleComponent:StopDrawRope();
    isGrappling = false
    ObjectGrappledTo = 0
    Owner.SpineComponent:SetSpineData(moveskele)
    Owner.SpineComponent:SetAnimation(runanim)
    if (ObjectGrappledTo ~= nil) then
      Owner.SoundEmitter:PlaySoundEvent("GrappleEnd")
    end
  end

  --Holds the current Velocity
  local curVel = AubergineEngine.Vector3(0, 0, 0)

	--Holds the direction the player should move
  local movDir = AubergineEngine.Vector3(0, 0, 0)

  if (CurrentTimeIntro > TransitionTime  and WillTransition and not WillGoMainLoop) then
    WillTransition = false
    TimeTillMainLoop = CurrentTimeIntro + 2.809
    WillGoMainLoop = true
    --Aubergine:PushMessage("ONE")
  elseif (CurrentTimeIntro > TimeTillMainLoop and WillGoMainLoop) then
    Owner.SoundEmitter:SetGlobalVariable("Music Power", 1)
    Owner.SoundEmitter:SetGlobalVariable("IsIntro", 0)
    Owner.SoundEmitter:PlaySoundEvent("OlympusMusicMain")
    --Aubergine:PushMessage("THREE")
    WillGoMainLoop = false
  end

  if (Owner.RigidBody.IsOnGround) then
      Owner.Transform.Rotation = 0
    if Owner.RigidBody.Velocity.X < -0.1 then
        Owner.SpineComponent:SetMirrored(true)
        --Owner.SpineComponent:SetAnimated(true)
        Owner.SpineComponent:SetSpineData(moveskele)
        Owner.SpineComponent:SetAnimation(runanim)
        Owner.SpineComponent:SetAnimationSpeed(Owner.RigidBody.Velocity.X / -animRunSpeed)
        --Aubergine:PushUserMessage("Running Left Speed Ratio: "..Owner.RigidBody.Velocity.X / -maxSpeedX)
    elseif Owner.RigidBody.Velocity.X > 0.1 then
        Owner.SpineComponent:SetMirrored(false)
        --Owner.SpineComponent:SetAnimated(true)
        Owner.SpineComponent:SetSpineData(moveskele)
        Owner.SpineComponent:SetAnimation(runanim)
        Owner.SpineComponent:SetAnimationSpeed(Owner.RigidBody.Velocity.X / animRunSpeed)
        --Aubergine:PushUserMessage("Running Right Speed Ratio: "..Owner.RigidBody.Velocity.X / maxSpeedX)
    else
      --Owner.SpineComponent:SetMirrored(false)
      --Owner.SpineComponent:SetAnimated(true)
      Owner.SpineComponent:SetSpineData(idleskele)
      Owner.SpineComponent:SetAnimation(idleanim)
      Owner.SpineComponent:SetAnimationSpeed(1)
    end
   else
     if isGrappling then
       Owner.SpineComponent:SetSpineData(moveskele)
       Owner.SpineComponent:SetAnimation(swinganim)
       Owner.SpineComponent:SetAnimationSpeed(Magnitude(Owner.RigidBody.Velocity) / 500)
     else
       Owner.Transform.Rotation = 0
       if Owner.RigidBody.Velocity.Y > -5 then
         Owner.SpineComponent:SetSpineData(moveskele)
         Owner.SpineComponent:SetAnimation(swinganim)
         Owner.SpineComponent:SetAnimationSpeed(0.2)
       else
         Owner.SpineComponent:SetSpineData(jumpskele)
         Owner.SpineComponent:SetAnimation(jumpanim)
         Owner.SpineComponent:SetAnimationSpeed(0.3)
       end

       if Owner.RigidBody.Velocity.X > 0 then
           Owner.SpineComponent:SetMirrored(false)
       else
           Owner.SpineComponent:SetMirrored(true)
       end
    end
   end

	----If we want to go left
  if event.Input:KeyDown(Keys.A) or event.Input:KeyDown(Keys.Left) then
    if(Owner.RigidBody.Velocity.X > -maxSpeedX) then
      --Holds the normal of the ground (or would except it will always be this and we want to move at least somewhat
      -- in air, which won't happen in we rely on the ground normal)
      local hold = AubergineEngine.Vector3(0,1,0)
      --Multiply that by the Velocity she moves
      hold.X = hold.X * MoveVelocity
      hold.Y = hold.Y * MoveVelocity
      --Rotate that to the left, sending her that way
      movDir = Owner:RotateVector(hold, 90)


    end
  elseif event.Input:KeyDown(Keys.D) or event.Input:KeyDown(Keys.Right) then
    if(Owner.RigidBody.Velocity.X < maxSpeedX) then
      --This is all the same things but moving her to the right
      local hold = AubergineEngine.Vector3(0,1,0)
      hold.X = hold.X * MoveVelocity
      hold.Y = hold.Y * MoveVelocity
      movDir = Owner:RotateVector(hold, -90)
    end
  else
    --Owner.SpineComponent:SetAnimation("walk3")
    --Owner.SpineComponent:SetAnimated(false)
  end

  --Setting the current Velocity she should go (or velocity change)
  curVel.X = movDir.X
  curVel.Y = movDir.Y

  --Set the velocity on the rigidbody, making them go vroom vroom
  --If you want stiff controlls in the x direction(i.e hard stoping, no drag), keep it like this else use the next one(i.e slows down then stops, drag)
  --Owner.RigidBody:SetVelocityX(curVel.X)
  --Something to do with drag

  local dragToUse = 1
  if Owner.RigidBody.IsOnGround then
    dragToUse = groundDrag
    --Aubergine:PushUserMessage("Ground Drag "..groundDrag)
  else
    dragToUse = airDrag
    --Aubergine:PushUserMessage("Air Drag "..airDrag)
  end
  Owner.RigidBody:SetVelocityX((Owner.RigidBody.Velocity.X + curVel.X) * dragToUse)
  Owner.RigidBody:SetVelocityY((Owner.RigidBody.Velocity.Y + curVel.Y) * dragToUse)


  --Press W or Up or space to jump
  if event.Input:KeyDown(Keys.W) or event.Input:KeyDown(Keys.Up) or event.Input:KeyDown(Keys.Space) then
   --If we weren't already jumping last frame
    if jump_key_down == false then
	   --We might still be on the ground then
      if Owner.RigidBody.IsOnGround == true then
      --if we were then we haven't jumped yet
        JumpCount = 0
      end
      --If we weren't just on the ground, it means we have started our jump or are falling
      if Owner.RigidBody.IsOnGround == false then
      --meaning increment how many times we jumped
        JumpCount = JumpCount + 1
      end
      --No matter what our jump timer has just started
      AddJumTim = 0
      Owner.SpineComponent:SetSpineData(jumpskele)
      Owner.SpineComponent:SetAnimation(jumpanim)
    end

    jump_key_down = true
  else
    jump_key_down = false
  end

	--Our jump timer is running
	AddJumTim = AddJumTim + event.DeltaTime

	--If we still have time left on our jump, and if we still have more jumps
	if(AddJumTim < AddJumDur and JumpCount < MaxJumpCount) then
	--apply the jump force
    --Owner.SpineComponent:SetAnimated(false)
	 Owner.RigidBody:SetVelocityY(Owner.RigidBody.Velocity.Y + JumpForce * event.DeltaTime)
   print("Velocity is "..Owner.RigidBody.Velocity.Y.." adding "..JumpForce * event.DeltaTime)
	end

	--Owner.RigidBody:SetVelocityX(Owner.RigidBody.Velocity.X + velocityChange.X)
  --Owner.RigidBody:SetVelocityY(Owner.RigidBody.Velocity.Y + velocityChange.Y)



  if event.Input:KeyDown(Keys.LeftShift) then
    runanim = "sprint"
    animRunSpeed = 200
    maxSpeedX = 500
  elseif event.Input:KeyDown(Keys.LeftCtrl) then
    runanim = "walk3"
    animRunSpeed = 50
    maxSpeedX = 50
  else
    runanim = "sprint"
    animRunSpeed = 200
    maxSpeedX = 200
  end

end
