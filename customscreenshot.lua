--
-- Author: donmaiq
-- Description: 
--   A script to save screenshots in different
--   locations based on whatever conditions.
--   Requires lua knowledge or some will to experiment.

local utils = require 'mp.utils'
local msg = require 'mp.msg'

local settings = {
  basepath = mp.get_property('screenshot-directory'),
  basetemplate = mp.get_property('screenshot-template'),

  --the command to creating your custom directory without the path
  createdir = { 'mkdir', '-p' }, 

  --patterns are in priority order, first match will be used for screenshot
  --about patterns in lua:
  --http://lua-users.org/wiki/PatternsTutorial
  --https://www.lua.org/pil/20.2.html
  --useful tool to test patterns: https://www.lua.org/demo.html
  patterns = {
    --you can copy paste the template below and change values to create more rules
    { 
      --this function will be called on file load to determine whether current file is a match for these rules or not
      --return booleanish value(for if statement)
      ['match'] =
        function()
          return mp.get_property('filename/no-ext'):match('%[SubGroup%]') and true or false
        end
      ,

      --function that will return the absolute save path for files
      ['savepath'] =
        function()
          --parse filename to create directory name - note that naming conventions differ so you need to modify this
          --in this case I parse it so that only the name stays, not creating new folder for every episode
          --you could also just use a static string, making all screenshots from this match save in same folder
          local dynamic_directory = mp.get_property('filename/no-ext'):match('%]%s(.*)%s%-%s%d')

          --join and return our custom path with basepath
          return utils.join_path(settings.basepath, dynamic_directory)
        end
      ,  

      --if not nil then overriding default screenshot-template, will property expand
      --needs to be a function that returns the template as a string
      ['filename'] =
        function()
          --remove brackets, their content and surrounding white space from filename
          local name = mp.get_property('filename/no-ext'):gsub('%s*[%[%(].-[%]%)]%s*', '')
          return name.."[%wMm%wSs]" --add property expanding part
        end
      , 
    },
  }
}

local state = {
  pattern = nil,
}

function on_load()
  state.pattern = nil

  for index, pattern in ipairs(settings.patterns) do
    if pattern.match() then
      state.pattern = pattern
      break
    end
  end
end

function screenshot(subs)
  subs = (subs or "")
  if state.pattern then
    custom_screenshot(state.pattern, subs)
  else
    mp.commandv("screenshot", subs)
  end
end

function custom_screenshot(pattern, subs)
  local savepath = pattern.savepath()

  --prepare and create/check directory
  local args = settings.createdir
  table.insert(args, savepath)
  res = utils.subprocess({ args = args })

  if not res.error and res.status == 0 then

    --set temporary screenshot settings
    if pattern.filename then
      mp.set_property('screenshot-template', pattern.filename())
    end
    mp.set_property("screenshot-directory", savepath)

    --take the screenshot
    mp.commandv("screenshot", subs)

    --reset screenshot settings
    mp.set_property("screenshot-directory", settings.basepath)
    mp.set_property("screenshot-template", settings.basetemplate)

  else
    msg.error("Failed to create directory "..savepath)
    msg.error("Status: "..(res.status or "unknown"))
    msg.error("Error: "..(res.error or "unknown"))
  end
end

mp.register_script_message("custom-screenshot", screenshot)
mp.register_event('file-loaded', on_load)
