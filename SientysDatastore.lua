--[[
Sientys Datastore API v0.0.1

Notes:

Use the players ID if saving player data.
The data can be stored in any format at 1MB due to roblox limitation.

Each key represents a different "Volume" that has a limit to how much can be stored on a volume, free licence is 10GB

The initialize function connects to a specific pool in a volume by ID. These ID's are created on the website. If you do not want to use pools. Just use the @ for the default Pool.

]]

local HTTPService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local module = {}

module.key = ""
module.APP = nil
local APIURI = "http://localhost:8090/"
function module.SetKey()
	print("Sientys Datastore Crypto [INFO]: Attempting connection with key...")
	local re = {
		reType = "SETKEY",
		KEY = module.key
	}
	local JSONre = HTTPService:JSONEncode(re)
	pcall(function()
		local response = HTTPService:PostAsync(APIURI, JSONre, Enum.HttpContentType.ApplicationJson, false)
		local JSONde = HTTPService:JSONDecode(response)
		if JSONde.Application then
			print("Sientys Datastore Crypto [INFO]: Connection successful!")
			module.APP = JSONde.Application
			return JSONde.Application
		end
	end)
	if module.APP == nil then
		error("Sientys Datastore Crypto [FATAL]: Connection was not succesful, check key and make sure the service is operating.")
		return nil
	end
	
end
function module.Initialize()
	local re = {
		reType = "INIT",
		APP = module.APP
	}
	local JSONre = HTTPService:JSONEncode(re)
	local response = HTTPService:PostAsync(APIURI, JSONre, Enum.HttpContentType.ApplicationJson, false)
	local JSONde = HTTPService:JSONDecode(response)
	
end
function module.CreateDirectory(name)
	if name == nil then
		error("Cannot have Entry or Name NIL")
	end
	local re = {
		reType = "CREATE-D",
		APP = module.APP,
	}
end
function module.RemoveDirectory(name)
	if name == nil then
		error("Cannot have Entry or Name NIL")
	end
end
function module.SetEntry(entry, name, data)
	local Data = data or "Hello World!"
	if entry == nil or name == nil then
		error("Cannot have Entry or Name NIL")
	end
end
function module.GetEntry(entry, name, data)
	if entry == nil or name == nil then
		error("Cannot have Entry or Name NIL")
	end
end
function module.RemoveEntry(entry, name)
	if entry == nil or name == nil then
		error("Cannot have Entry or Name NIL")
	end
end
game:BindToClose(function()
	if not module.APP == nil then
		local re = {
			reType = "CLOSE",
			APP = module.APP
		}
		local stopre = HTTPService:JSONEncode(re)
		HTTPService:PostAsync(APIURI, stopre, Enum.HttpContentType.ApplicationJson, false)
	end
end)
return module
