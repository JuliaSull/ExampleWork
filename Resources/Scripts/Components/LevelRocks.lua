
--[[ PROPERTY(Cog) ]]--
Target = "Alatheia"

--[[ PROPERTY(Integer) ]]--
distFromPlayer = 520


scatterY = 0
scatterZ = 0
scatterX = 0
speed = 0
player = 0
randomScale = 0

--[[ PROPERTY(Integer) ]]--
randomScatterYMin = -250
--[[ PROPERTY(Integer) ]]--
randomScatterYMax = 250

--[[ PROPERTY(Integer) ]]--
randomSpeedMin = 1
--[[ PROPERTY(Integer) ]]--
randomSpeedMax = 4

--[[ PROPERTY(Integer) ]]--
randomScaleXMin = 10
--[[ PROPERTY(Integer) ]]--
randomScaleXMax = 40

firstFrame = true

function Initialize()

	Space:ConnectLogicUpdate (Update)

end

function Update(event)

  if (Target == "None") then 
    Aubergine:PushUserMessage(Target)
    return
  end
  if (firstFrame) then
    
    firstFrame = false
    player = Space:FindChild(Target)
    local playerTransTemp = player.Transform.Translation
    speed = math.random(randomSpeedMin, randomSpeedMax)
    randomScale = math.random(randomScaleXMin, randomScaleXMax)
    Owner.Transform:SetScaleX(randomScale)
    Owner.Transform:SetScaleY(randomScale)
    Owner.Sprite:SetTint(0.5, 0.5, 0.5, 0.7)
    Owner.Transform:SetZ(math.random() * 25 + 1)
    
    scatterX = math.random(-distFromPlayer, distFromPlayer)
    Owner.Transform:SetX(playerTransTemp.X + scatterX)
  end

  local playerTrans = player.Transform.Translation
  local myTrans = Owner.Transform.Translation
  local distX = myTrans.X - playerTrans.X
  local distY = myTrans.Y - playerTrans.Y
  local dist = math.sqrt(distX * distX)
  local shouldSnapRight = false
  
  if (distX < 0) then 
    -- Because we went offscreen on the left side
    shouldSnapRight = true  
  end
  
  if (dist > distFromPlayer) then
    if (shouldSnapRight) then
      scatterY = math.random(randomScatterYMin, randomScatterYMax)
      scatterZ = math.random() * 25 + 1
      Owner.Transform:SetX(playerTrans.X + distFromPlayer)
      Owner.Transform:SetY(playerTrans.Y + scatterY)
      Owner.Transform:SetZ(scatterZ)
    else 
      scatterY = math.random(randomScatterYMin, randomScatterYMax)
      scatterZ = math.random() * 25 + 1
      Owner.Transform:SetX(playerTrans.X - distFromPlayer)
      Owner.Transform:SetY(playerTrans.Y + scatterY)
      Owner.Transform:SetZ(scatterZ)
    end
  end
  
  Owner.Transform:SetX(myTrans.X + (speed * event.DeltaTime))
end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
