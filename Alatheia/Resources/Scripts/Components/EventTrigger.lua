--[[ PROPERTY(Cog) ]]--
Triggerer = ""

--[[ PROPERTY(Cog) ]]--
Target = ""

--[[ PROPERTY(Component) ]]--
Component = ""

--[[ PROPERTY(Function) ]]--
Function = ""

function Initialize()

	Space:ConnectCollisionStarted (OnCollisionStarted)

end

function OnCollisionStarted(event)

  if (event.OtherObject.Name == Triggerer) then
  
    local exeString = ""
<<<<<<< HEAD
    exeString = exeString.."Aubergine.Space:FindChild(\""
    exeString = exeString..Target
    exeString = exeString.."\")"
    exeString = exeString..":GetComponent(\""
    exeString = exeString..Component
    exeString = exeString.."\"):"
    exeString = exeString..Function
    exeString = exeString.."()"
=======
    exeString = exeString + Target
    exeString = exeString + ".GetComponent("
    exeString = exeString + Component
    exeString = exeString + ":"
    exeString = exeString + Function
    exeString = exeString + "()"
    Aubergine:ExecuteLuaString(exeString)
>>>>>>> 896840a99403e24589484d38b5daa3dd4bfebe5a
  
  end

end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
