local speed = 400 * math.random()
 
function Initialize()

	Space:ConnectLogicUpdate (Update)


end

function Update(event)
  Owner.Transform.Rotation = Owner.Transform.Rotation - (speed * event.DeltaTime * 3.14159 / 180)

end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
