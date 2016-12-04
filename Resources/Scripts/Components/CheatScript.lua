--[[ PROPERTY(bool) ]]--
canCheckpoint1 = true

command0 = "Aubergine.Space:FindChild(\"Checkpoint 1\"):GetComponent(\"Checkpoint\"):Activate()"

--[[ PROPERTY(bool) ]]--
canCheckpoint2 = true

command1 = "Aubergine.Space:FindChild(\"Checkpoint 2\"):GetComponent(\"Checkpoint\"):Activate()"

--[[ PROPERTY(bool) ]]--
canCheckpoint3 = true

command2 = "Aubergine.Space:FindChild(\"Checkpoint 3\"):GetComponent(\"Checkpoint\"):Activate()"

--[[ PROPERTY(bool) ]]--
canCheckpointEnd = true

command3 = "Aubergine.Space:FindChild(\"Checkpoint End\"):GetComponent(\"Checkpoint\"):Activate()"



function Initialize()

	Space:ConnectLogicUpdate (Update)

end

function Update(event)

if (event.Input:KeyTriggered(Keys.V) and canCheckpoint1 == true) then Aubergine:ExecuteLuaString("Aubergine.Space:FindChild(\"Checkpoint 1\"):GetComponent(\"Checkpoint\"):Activate()") end

if (event.Input:KeyTriggered(Keys.B) and canCheckpoint2 == true) then Aubergine:ExecuteLuaString("Aubergine.Space:FindChild(\"Checkpoint 2\"):GetComponent(\"Checkpoint\"):Activate()") end

if (event.Input:KeyTriggered(Keys.N) and canCheckpoint3 == true) then Aubergine:ExecuteLuaString("Aubergine.Space:FindChild(\"Checkpoint 3\"):GetComponent(\"Checkpoint\"):Activate()") end

if (event.Input:KeyTriggered(Keys.M) and canCheckpointEnd == true) then Aubergine:ExecuteLuaString("Aubergine.Space:FindChild(\"Checkpoint End\"):GetComponent(\"Checkpoint\"):Activate()") end



end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
