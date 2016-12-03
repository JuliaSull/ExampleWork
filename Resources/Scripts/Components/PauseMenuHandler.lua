
FirstFrame = true


function Initialize()

	Space:ConnectLogicUpdate (Update)
  --Owner:ConnectCollisionStarted (OnCollisionStarted)

end

function Update(event)
 
  if(event.Input:KeyTriggered(Keys.Escape)) then
    Aubergine:TogglePaused()
    obj = Space:FindChild("MAIN PAUSED")
    cam = Aubergine:GetUICamera()
    cam.Transform:SetX(obj.Transform.Translation.X)
    cam.Transform:SetY(obj.Transform.Translation.Y)
    cam.CameraController:SetTarget(obj)
  end
  
  
end


function PropertiesUpdate()

  
end

function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
