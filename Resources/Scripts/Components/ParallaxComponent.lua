--[[
	This is a script to serve as an example component

	It has no real use in this game but shows the features of lua components

	THINGS THAT YOU DO NOT CREATED SEE HERE BUT ALL COMPONENTS HAVE
	- ComponentType is a String holding the name of this type of component
	- Owner is a GameObject reference to the object that owns this component
	- Space is a GameObject reference to the space that the parent exists within


--Declare a local variable, local is not required but does not affect functionality
local cam

--Every component is required to have a function called Initialize
--Every component is required to have a function called Initialize
--When a component is created the Engine will call this function with no arguments
function Initialize()
	cam = Aubergine:GetCamera()

	--Connect the LogicUpdate event on Space to the function called Update
	Space:ConnectLogicUpdate (Update)

	Owner:ConnectDestruction(Destroy)
end

--This function was connected to the LogicUpdate event on the Space
--It will be called expecting one argument, and that will be a
--LogicUpdateEvent object
function Update(updateEvent)

	owner.Transform:Translation.X = cam.Transform:Translation.X * owner.Transform:Translation.Z
  owner.Transform:Translation.Y = cam.Transform:Translation.Y * owner.Transform:Translation.Z

end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
--]]