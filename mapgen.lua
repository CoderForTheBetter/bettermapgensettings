
if clear_all_biomes_and_define == "true" then
  minetest.clear_registered_biomes();
end

if ore_generation_toggle == "false" then
  minetest.clear_registered_ores();
end


--For some reason, if this is enabled and all the other settings as well, then causes seg fault
if decorations_toggle == "false" then
  minetest.clear_registered_decorations();
end

if clear_all_schematics == "true" then
  minetest.clear_registered_schematics();
end

if clear_all_biomes_and_define == "true" then
  minetest.register_biome({
    name = "top",
    --node_dust = "",
    node_top = "default:" .. top_layer_node,
    depth_top = top_layer_depth,
    node_filler = top_filler_node,
    depth_filler = top_filler_depth,
    node_stone = "default:" .. stone_node,
    --node_water_top = "",
    --depth_water_top = ,
    --node_water = "",
    --node_river_water = "",
    --node_riverbed = "default:sand",
    --depth_riverbed = 2,
    y_min = -31000,---(top_layer_depth+top_filler_depth),
    y_max = 10, --Not sure what this should be
    heat_point = 50,
    humidity_point = 50,
  })
end