map = {}     -- global table creation
map.v = {}   -- variables used by mods
map.f = {}   -- quasiglobal functions
map.p = {}   -- mod paths for global access
map.c = {}   -- configuration (defaults read from settingtypes.txt files)

test = "";
top_layer_node = "";
decorations_toggle = "";
cave_generation_toggle = "";
ore_generation_toggle = "";
clear_all_schematics = "";
clear_all_biomes_and_define = "";
top_layer_depth = -1;

top_filler_node = "";
top_filler_depth = -1;

stone_node = "";

-- @return void
map.i = function ()
  
  
    local name = minetest.get_current_modname()
    local path = minetest.get_modpath(name)
    local filename = path..DIR_DELIM..'settingtypes.txt'
    local file = io.open(filename, 'rb')

    if file ~= nil then
        local lines = {}
        for line in file:lines() do
            if line:match("^([a-zA-Z])") then
                local name = line:gsub(' .+', '')
                local value = line:gsub('^[^ ]+ %b() %a+ ', '')
                map.c[name] = value
            end
        end
    end

    map.v[name] = {}
    map.f[name] = {}
    map.p[name] = path..DIR_DELIM

    test = map.g("test", false);
    top_layer_node = map.g("top_layer_node", false);
    decorations_toggle = map.g("decorations_toggle", false);
    cave_generation_toggle = map.g("cave_generation_toggle", false);
    ore_generation_toggle = map.g("ore_generation_toggle", false);
    clear_all_schematics = map.g("clear_all_schematics", false);
    clear_all_biomes_and_define = map.g("clear_all_biomes_and_define", false);
    top_layer_depth = tonumber(map.g("top_layer_depth", false));
    
    top_filler_node = map.g("top_filler_node", false);
    top_filler_depth = tonumber(map.g("top_filler_depth", false));
    
    stone_node = map.g("stone_node", false);
    
    
    --Only retives a string, so convert to bool
    if cave_generation_toggle == "false" then
      cave_generation_toggle = false;
    else
      cave_generation_toggle = true;
    end
    
end





--- Get a configuration or default value.
--
-- Because Minetest does not provide a valid and sane way to get a value from
-- the configuration or – if not present – get a given default value instead,
-- this function exists. It searches the configuration for a value and if the
-- value does not exist it returns the default value defined in this modpack’s
-- `settingtypes.txt` file instead.
--
-- @param value             The descriptor of the value in question
-- @return string|int|bool  The configuration value or the default value
map.g = function (value, force_default)
    if force_default ~= true then
        local v = minetest.setting_get(value)
        return (v == nil and map.c[value] or v)
    else
        return map.c[value]
    end
end


--- Return a translated string.
--
-- Since there currently is no valid convenient way to translate mods (nor
-- is gettext used to translate mod strings) this function only returns
-- the given string. It will be updated/altered as soon as the is a way
-- to translate mods without 3d party mods/libraries.
--
-- @param string   The string that is to be translated
-- @return result  A two values return. 1) the translated string, 2) the
--                 untranslated original string.
map.t = function (string)
    local original = string
    local translated = string -- Will be actually translated if MT allows it
    return translated,original
end


-- Output a debug message.
--
-- Checks if debugging messages are enabled and if so reads and parses the
-- given debug message format and prints a debug message wherever the function
-- is called.
--
-- @param information The information to be shown
-- @return void
map.d = function (information)
    if map.g('xtend_default_debug') == 'false' then return end
    local current_mod = minetest.get_current_modname()
    local string = map.g('xtend_default_debug_format'):gsub('+.', {
        ['+i'] = information,
        ['+m'] = current_mod,
        ['+M'] = string.upper(current_mod),
        ['+n'] = '\n',
        ['+t'] = os.date('%H:%M:%S')
    })
    print(string)
end
