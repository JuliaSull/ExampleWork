--A 'cage' environment that has some of the features of the global environment
--but cannot edit them
local cage =
{
	--Some base packages that will be needed
	string = string, table = table, math = math, time = time, date = date,

	--Forward the whole global space but with a new name
	Global = _G,

	-- some 'global' functions:
	next = next, ipairs = ipairs, pairs = pairs,
	require = require, type = type,
	tonumber = tonumber, tostring = tostring,
	unpack = unpack,
	setmetatable = setmetatable,
	getmetatable = getmetatable,

	-- global functions that are here because will want to overwrite later and compatability
	print = print,
	error = error,

}

--A metatable for things that should have all of the members of cage
local cageMT = {__index = cage}

function TriedToGlobal()

end

function PRINTSTUFF(stuff)
	--Aubergine:PushMessage(stuff)
end

function PRINTERROR(stuff)
	Aubergine:PushError(stuff)
end

function ScriptLoader (scriptname)
	--Print Debug Text
	--print("    Loading "..scriptname.."...")

	--Set up an table for the new environment that forwards global calls
	local scriptenv = {Global = _G, print = PRINTSTUFF, error = PRINTERROR}

	--Set the metatable to have all of the things from cage in it
	--setmetatable(scriptenv, cageMT) CAGED VERSION WITHOUT GLOBAL ACCESS

	--Set the metatable to have access to all global values
	setmetatable(scriptenv, {__index = _G})

	--Load the script into memory, assert to ensure that the file is valid
	local chunk, error = loadfile(scriptname)
  print("%%%%%%%%%%%%%%%%%%%"..scriptname);
	if chunk == nil then
		print("LUA ERROR: "..error)
	end
	--Print Debug Text
	--print ("    Loaded " .. scriptname .. ", setting up environment for ".. chunk.."...")

	--Set the environment that the new code will execute in to be the scriptenv
	setfenv(chunk, scriptenv)

	--Print Debug Text
	--print ("    Environment Ready for " .. scriptname .. ", executing...")

  --scriptenv.LogicUpdateSubscriptions = {}

	--Excecute that file (this should make the variables and stuff outside of functions)
	chunk ()



	--Print Debug Text
	--print ("     "..scriptname .. " Done.")

	return scriptenv
end

function DataCopy(orig)
  --Type of the thing to copy from
    local orig_type = type(orig)
	--Variable to hold the copy
    local copy

    print("Copying...")

	--If its a table, recursively copy each member of the table
    if orig_type == 'table' then
        --print("    Type is table")
        copy = {}
        --print("    Created empty table to copy into")
        for orig_key, orig_value in next, orig, nil do
            --print("    Copying "..orig_key.." accross...")
            copy[orig_key] = orig_value
            --print("    Done.")
        end
        --print("    Copying metatable")
        setmetatable(copy, getmetatable(orig))
    else -- Simple copy for number, string, boolean, etc
        --print("    Deep Copy on Simple Value")
        copy = orig
    end

    print("Copy completed")
    return copy
end

function DeepCopy(orig, depth)

	--Type of the thing to copy from
    local orig_type = type(orig)
	--Variable to hold the copy
    local copy

    print("Performing Deep Copy at layer "..depth)

	--If its a table, recursively copy each member of the table
    if orig_type == 'table' and depth < 1 then
        --print("    Type is table")
        copy = {}
        --print("    Created empty table to copy into")
        for orig_key, orig_value in next, orig, nil do
            --print("    Copying "..orig_key.." accross...")
            copy[DeepCopy(orig_key, depth+1)] = DeepCopy(orig_value, depth+1)
            --print("    Done.")
        end
        --print("    Copying metatable")
        setmetatable(copy, DeepCopy(getmetatable(orig), depth+1))
    else -- Simple copy for number, string, boolean, etc
        --print("    Deep Copy on Simple Value")
        copy = orig
    end

    print("Copy completed at layer "..depth..", returning the copy")
    return copy
end
