REPLACE_1

function Initialize()

	Space:ConnectLogicUpdate (Update)

end

function Update(event)

REPLACE_2

end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
