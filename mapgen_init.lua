--Minetest
--Copyright (C) 2014 sapier
--
--This program is free software; you can redistribute it and/or modify
--it under the terms of the GNU Lesser General Public License as published by
--the Free Software Foundation; either version 2.1 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU Lesser General Public License for more details.
--
--You should have received a copy of the GNU Lesser General Public License along
--with this program; if not, write to the Free Software Foundation, Inc.,
--51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


local labels = {
	top_layer_node = {
		fgettext("Dirt With Grass"),
    fgettext("Dirt With Snow"),
		fgettext("Dirt"),
		fgettext("Snow Block"),
    fgettext("Stone"),
    fgettext("Sandstone"),
    fgettext("Sand"),
    fgettext("Water Source (Water)"),
    fgettext("Ice")
	},
  
  top_filler_node = {
		fgettext("Dirt With Grass"),
    fgettext("Dirt With Snow"),
		fgettext("Dirt"),
		fgettext("Snow Block"),
    fgettext("Stone"),
    fgettext("Sandstone"),
    fgettext("Sand"),
    fgettext("Water Source (Water)"),
    fgettext("Ice")
	},
  
  stone_node = {
		fgettext("Stone"),
    fgettext("Dirt With Snow"),
		fgettext("Dirt"),
		fgettext("Snow Block"),
    fgettext("Dirt With Grass"),
    fgettext("Sandstone"),
    fgettext("Sand"),
    fgettext("Water Source (Water)"),
    fgettext("Ice")
	},
}

local dd_options = {
	top_layer_node = {
		table.concat(labels.top_layer_node, ","),
		{"dirt_with_grass", "dirt_with_snow" ,"dirt", "snowblock", "stone", "sandstone", "sand", "water_source", "ice"}
	},
  
  top_filler_node = {
		table.concat(labels.top_filler_node, ","),
		{"dirt_with_grass", "dirt_with_snow" ,"dirt", "snowblock", "stone", "sandstone", "sand", "water_source", "ice"}
	},
  
  stone_node = {
		table.concat(labels.stone_node, ","),
		{"stone", "dirt_with_snow" ,"dirt", "snowblock", "dirt_with_grass", "sandstone", "sand", "water_source", "ice"}
	},
}

local getSettingIndex = {
	Top_layer_node = function()
		local style = core.settings:get("top_layer_node")
		for idx, name in pairs(dd_options.top_layer_node[2]) do
			if style == name then return idx end
		end
		return 1
	end,
  
  Top_filler_node = function()
		local style = core.settings:get("top_filler_node")
		for idx, name in pairs(dd_options.top_filler_node[2]) do
			if style == name then return idx end
		end
		return 1
	end,
  
  Stone_node = function()
		local style = core.settings:get("stone_node")
		for idx, name in pairs(dd_options.stone_node[2]) do
			if style == name then return idx end
		end
		return 1
	end,
}




local menupath = core.get_mainmenu_path()
local basepath = core.get_builtin_path()

core.settings:set("test", "Hello")

local function current_game()
end


local function singleplayer_refresh_gamebar()
end


local function get_formspec(tabview, name, tabdata)
	--Where the formspec is defined
	local retval = "label[0,-0.15;" .. fgettext("WARNING: if this mod is enabled on a world, it will start generating with these settings. Use same settings per world. Press 'Enter' for number boxes.") .. "]" .. 
  "box[-0.1,-0.1;12.03,5.7;#999999]" ..
			"checkbox[0.25,0;cb_decorations_toggle;" .. fgettext("Decorations toggle (checked = decorations on)") .. ";"
			.. dump(core.settings:get_bool("decorations_toggle")) .. "]" ..
      
      "checkbox[0.25,0.4;cb_ore_generation_toggle;" .. fgettext("Ore generation toggle (checked = ores on)") .. ";"
				.. dump(core.settings:get_bool("ore_generation_toggle")) .. "]" ..
        
      "checkbox[0.25,0.8;cb_clear_all_schematics;" .. fgettext("Clear all schematics (checked = cleared)") .. ";"
				.. dump(core.settings:get_bool("clear_all_schematics")) .. "]" ..
        
      "checkbox[0.25,1.2;cb_clear_all_biomes_and_define;" .. fgettext("Clear all biomes and define a single one (checked = cleared)") .. ";"
				.. dump(core.settings:get_bool("clear_all_biomes_and_define")) .. "]" ..
        
      "checkbox[0.25,1.6;cb_cave_generation_toggle;" .. fgettext("Cave generation toggle (checked = caves on)") .. ";"
				.. dump(core.settings:get_bool("cave_generation_toggle")) .. "]"
      
      
      
      
      --User wants to define a biome that spreads the whole world
      if dump(core.settings:get_bool("clear_all_biomes_and_define")) == "true" then
        retval = retval .. "label[0.25,2.4;" .. fgettext("Top layer node:") .. "]" ..
        
        "label[0.25,3.5;" .. fgettext("Top layer depth/height:") .. "]" ..
        "field[0.55,4.325;1.4,0.5;te_top_layer_depth;;"
      .. dump(tonumber(core.settings:get("top_layer_depth"))) .. "]" ..
      
			"dropdown[0.25,2.8;2.5;dd_top_layer_node;" .. dd_options.top_layer_node[1] .. ";"
			.. getSettingIndex.Top_layer_node() .. "]"
      
      
      .."label[3,2.4;" .. fgettext("Top filler node:") .. "]" ..
          "label[3,3.5;" .. fgettext("Top filler depth/height:") .. "]" ..
          "field[3.3,4.325;1.4,0.5;te_top_filler_depth;;"
        ..   dump(tonumber(core.settings:get("top_filler_depth"))) .. "]" ..
          "dropdown[3,2.8;2.5;dd_top_filler_node;" .. dd_options.top_filler_node[1] .. ";"
        ..   getSettingIndex.Top_filler_node() .. "]"
        
        
        .."label[5.8,2.4;" .. fgettext("Stone node:") .. "]" ..
          "dropdown[5.8,2.8;2.5;dd_stone_node;" .. dd_options.stone_node[1] .. ";"
        ..   getSettingIndex.Stone_node() .. "]"
      
      end
	

	--Need to return the formspec to be displayed, otherwise it aborts
	return retval
end



--Loads the settings choosen by the user
local function mapgen_button_handler(this, fields, name, tabdata)
	

	if fields["cb_decorations_toggle"] then
		core.settings:set("decorations_toggle", fields["cb_decorations_toggle"])
		return true
	end
  if fields["cb_cave_generation_toggle"] then
		core.settings:set("cave_generation_toggle", fields["cb_cave_generation_toggle"])
		return true
	end
  if fields["cb_ore_generation_toggle"] then
		core.settings:set("ore_generation_toggle", fields["cb_ore_generation_toggle"])
		return true
	end
  if fields["cb_clear_all_schematics"] then
		core.settings:set("clear_all_schematics", fields["cb_clear_all_schematics"])
		return true
	end
  if fields["cb_clear_all_biomes_and_define"] then
		core.settings:set("clear_all_biomes_and_define", fields["cb_clear_all_biomes_and_define"])
		return true
	end


  if fields.key_enter then
      if fields["te_top_layer_depth"] then
					core.settings:set("top_layer_depth", fields["te_top_layer_depth"])
      end
      if fields["te_top_filler_depth"] then
					core.settings:set("top_filler_depth", fields["te_top_filler_depth"])
      end
  end


	--Note dropdowns have to be handled LAST!
	local ddhandled = false

	for i = 1, #labels.top_layer_node do
		if fields["dd_top_layer_node"] == labels.top_layer_node[i] then
			core.settings:set("top_layer_node", dd_options.top_layer_node[2][i])
			ddhandled = true
		end
    if fields["dd_top_filler_node"] == labels.top_filler_node[i] then
			core.settings:set("top_filler_node", dd_options.top_filler_node[2][i])
			ddhandled = true
		end
    if fields["dd_stone_node"] == labels.stone_node[i] then
			core.settings:set("stone_node", dd_options.stone_node[2][i])
			ddhandled = true
		end
	end
end


local function on_change(type, old_tab, new_tab)
	
end


--------------------------------------------------------------------------------
return {
	name = "mapgen",
	caption = fgettext("Mapgen"),
	cbf_formspec = get_formspec,
	cbf_button_handler = mapgen_button_handler,
	on_change = on_change
}
