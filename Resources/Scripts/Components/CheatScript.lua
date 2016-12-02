

function Initialize()

	Space:ConnectLogicUpdate (Update)

end

function Update(event)



end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
