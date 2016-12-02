


function Initialize()
	Space:ConnectCollisionStarted(OnCollision)
end

function OnCollision(collisionEvent)
  score = Owner.GetComponent("ScoreComponent")
  
  if score == Nil  then
    score = CollidedWith.GetComponent("ScoreComponent")
  end
  
  if(score == Nil) then return end
  
  score.ScorePoints(1)
end


function Destroy(event)
	Space:DisconnectCollisionStarted(OnCollision)
end
