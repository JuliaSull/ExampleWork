maxY = 10
startY = 0
totalTime = 0
speed = 0

firstFrame = true

function Initialize()

	--Space:ConnectLogicUpdate (Update)

end

function Update(event)
  if (firstFrame) then
    firstFrame = false
    startY = Owner.Transform.Translation.Y
  end
  
  totalTime = totalTime + event.DeltaTime
  
  local t = math.sin(totalTime)
  Owner.Transform:SetY(startY + (maxY * t))
  

end


function Destroy(event)
	--Space:DisconnectLogicUpdate(Update)
end

