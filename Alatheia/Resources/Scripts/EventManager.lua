

function Connect(eventType, func)
	EventsTable[eventType][EventsIndexTable[eventType]] = func
	EventsIndexTable[eventType] = EventsIndexTable[eventType] + 1
end