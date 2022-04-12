# Sientys Datastore
A more free way to store data. It doesn't have to be ROBLOX!

A datastore that is offsite and features a more flexible way of storing data in any format!

# Introduction

This API uses HTTP POST requests *Will Change* to a server with a key and directory ID, the server will store this information in the desired location and return the ok signal if the data was stored.

# Setting Up

The API can be downloaded in the releases tab, the API will be called SientysDS.lua and is used in a module script.

# Usage

Since this is still under early stages I will provide a key if you have a valid reason to become a tester. 

The API will store any variable type. The variable may be converted to string for storing in UTF8 format, tables/arrays are stored in JSON format.

# Initializing

First you need to declare the module script, for example:

```lua
local module = require(MODULE SCRIPT)
```

Afterwards you will need to initialize the client with the key to use the datastore:

```lua
module:SetKey(KEY)
local result, success = module:Initialize()
```

The 2 functions are used to set up a connection to the server. SetKey() is used to set the API key used to interact with a "Pool". Initialize() establishes a handshake to confirm the key is correct and a secure connection is established, this function returns the headers provided which can be used to determine if its read/write or other settings, it will also return if the connection was successful or not.

# Directories

A Directory is a way to organise data sets in different areas to help organise large amounts of files. There is a root directory if you dont have a need to use directories, to retrieve it just use the GetRootDirectory function:

```lua
local rootDirectory = module:GetRootDirectory()
```

To get a directory, you will need to provide its name and location, If it is not in another directory, just put @:

```lua
local directory = module:GetDirectory("@", "TurtleStorage") --If the directory does not exist it will return nil
```

Creating Directories is similar to retrieving them, 

```lua
local newDirectory = module:CreateDirectory("Turtle-"..ID) -- Can not have spaces! The server will reject if you attempt to and return nil.
```

The CreateDirectory function returns the directory assuming you have a valid name.

Removing Directories can be done by using the RemoveDirectory() function. Here is a example of a directory getting deleted (WARNING! any data in a directory will get destroyed!)

```lua
module:RemoveDirectory("Turtle-"..ID)
```

That wraps directories, the datastore API referes to files as entries. Entries contain the data saved on the datastore, they also include a creation date, last edited date, client source and a few more bits n bobs. Here is an example of a new Entry being made in the root directory and data being set:

```lua
module:SetEntry(rootDirectory, "name here", "nonsense here")
```

This function will set a entry with new values, a entry is automatically created if not present. 

To get a entry. use the GetEntry() function to retrieve stored data, this function will return nil if nothing is present.

```lua
local data = module:GetEntry(rootDirectory, "name here")
```
