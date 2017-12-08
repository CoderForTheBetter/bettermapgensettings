dofile(minetest.get_modpath("bettermapgensettings").."/settings.lua")
map.i() -- init self
dofile(minetest.get_modpath("bettermapgensettings").."/nodeoverrides.lua")
dofile(minetest.get_modpath("bettermapgensettings").."/mapgen.lua")

minetest.register_on_joinplayer(function(player)
	minetest.chat_send_all(tostring(top_layer_depth));
end)
