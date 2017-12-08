A better mapgen settings mod. Based off of this link: https://forum.minetest.net/viewtopic.php?f=47&t=15272&start=400#p302138

This mod adds a new tab in the main menu that exposes settings for Minetest map generation. All of the map generation uses the minetest.register_biome LUA function, so mapgen will not be hindered by LUA mapgen, this mod is as fast as possible when it comes to map generation. The only way it could be faster is if I modified the base engine of Minetest and recomplied it.

INSTALLATION: This isn't exactly like other mods. Go ahead and clone this mod, rename it to "bettermapgensettings" and then move it into Minetest's "mods" folder like normal. Here comes the tricky part, you need to find where Minetest is installed on your computer (this folder should contain things like "bin", "builtin", "cache", "client", "doc", etc). Go into the "builtin" folder, and then into the "mainmenu" folder. select the file "init.lua" and rename it to something like "backup.init.lua" If something goes wrong in the future, come back here and rename that file back to "init.lua" to fix everything.

Next, go into the folder of this mod ("bettermapgensettings"), then go into the "mainmenu" folder, and copy "init.lua". Take this file and go back to where Minetest is installed, then go back to "builtin/mainmenu" and paste this new "init.lua" file in there (make sure you backed up the other one like I explained above). Now when you boot Minetest up you should have a new tab called "Mapgen" in your main menu (window with big "MINETEST").

USEAGE and WARNINGS: To use this mod, go into the new "Mapgen" tab on the main menu and adjust the settings how you see fit, they should be explained enough. Go create a new world and make sure to enable this mod in the "Configure" button. Make sure to note though, that if you use this mod on a world and generate new terrain, then the terrain will follow the settings you set with this mod. If you want to avoid the this, make sure not to enable this mod on a world you don't want to ruin.

If one of your worlds gets ruin, I don't assume any responsibility.
