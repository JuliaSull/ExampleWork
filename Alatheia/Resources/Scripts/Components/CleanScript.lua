--[[ PROPERTY(Integer) ]]--
Example = 0

FirstFrame = true


function Initialize()

	Space:ConnectLogicUpdate (Update)
  --Owner:ConnectCollisionStarted (OnCollisionStarted)

end

function Update(event)
  if (FirstFrame) then
    
    FirstFrame = false
  end
  
  
end

function OnCollisionStarted(event)

end

function PropertiesUpdate()

  
end

function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
