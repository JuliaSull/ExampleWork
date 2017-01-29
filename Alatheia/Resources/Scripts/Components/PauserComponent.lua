
function Initialize()
	Space:ConnectLogicUpdate (Update)
  Owner.Sprite:SetAlpha(0)
end

function Update(updateEvent)
  if (Owner.Sprite ~= nil) then
    if Aubergine.Paused then
      Owner.Sprite:SetAlpha(1)
    else
      Owner.Sprite:SetAlpha(0)
    end
  end
  
  if (Owner.SpriteText ~= nil) then
    if Aubergine.Paused then
      Owner.SpriteText:SetAlpha(1)
    else
      Owner.SpriteText:SetAlpha(0)
    end
  end
end

function UnpauseGame()
  Aubergine.Paused = false;

  if Aubergine.Paused then
    Owner.Sprite:SetAlpha(1)
  else
    Owner.Sprite:SetAlpha(0)
  end

end


function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
