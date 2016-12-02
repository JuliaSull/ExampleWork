--[[
	This is a script to serve as an example component

	It has no real use in this game but shows the features of lua components

	THINGS THAT YOU DO NOT CREATED SEE HERE BUT ALL COMPONENTS HAVE
	- ComponentType is a String holding the name of this type of component
	- Owner is a GameObject reference to the object that owns this component
	- Space is a GameObject reference to the space that the parent exists within
--]]

--Declare a local variable, local is not required but does not affect functionality
local rotspeed = math.pi / 4

--Every component is required to have a function called Initialize
--When a component is created the Engine will call this function with no arguments
function Initialize()
	--Print out a message indicating that this function has been called
	--NOTE that .. is used for string concetenation
	print ("Called Initialize function on " .. ComponentType)

	--Print out who the owner of this component is
	print ("Owner: " .. Owner.Name)

	--Connect the LogicUpdate event on Space to the function called Update
	Space:ConnectLogicUpdate (Update)

	Owner:ConnectDestruction(Destroy)
end

--This function was connected to the LogicUpdate event on the Space
--It will be called expecting one argument, and that will be a
--LogicUpdateEvent object
function Update(updateEvent)

	--Rotate based on keyboard input
	local rotation = 0
	if updateEvent.Input:KeyDown(Keys.Q) then
		rotation = rotation + rotspeed * updateEvent.DeltaTime
	end
	if updateEvent.Input:KeyDown(Keys.E) then
		rotation = rotation - rotspeed * updateEvent.DeltaTime
	end

	--Apply the rotation from the keyboard to the object
	Owner.Transform:Rotate(rotation)


	if updateEvent.Input:KeyDown(Keys.Space) then
		Owner:Delete()
	end

end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
