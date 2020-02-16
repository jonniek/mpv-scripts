A collection of all my mpv scripts. 
  
What are lua scripts? [Mpv.io lua documentation](https://mpv.io/manual/master/#lua-scripting)  
Where should I put them? [Unix](https://mpv.io/manual/stable/#files) [Windows](https://mpv.io/manual/stable/#files-on-windows)  
How do I use them? Use default keybinds or bind your own in [input.conf](https://mpv.io/manual/stable/#input-conf).

Some of my scripts require you to edit some settings in the head of lua files to work as intended(usually paths).  
Some of my scripts use script-messages for control instead of script-bindings to allow more dynamic commands to be parsed from parameters. You can call script-messages from any other lua script with `mp.command("script-message _name_ _arg1_ _arg2_")`, [mpv-repl](https://github.com/rossy/mpv-repl) by typing or just simply bind them to a key in input.conf like this `H script-message addscrollingsub "hello world"`.  

If you have problems with any of my scripts or have feature requests feel free to open an issue. Contributions are also welcome.  

### [playlistmanager](https://github.com/donmaiq/Mpv-Playlistmanager) 
Show playlist in a readable, navigatable and editable format as an osd_message. Cool quirks like filename formatting, saving, loading, shuffling sorting and more included. Now with the option to resolve urls to titles!

### [Filenavigator](https://github.com/donmaiq/mpv-filenavigator)
Navigate your local system and open directories or files, or add files to your playlist.

### [waifu2x](https://github.com/donmaiq/mpv-waifu2x)  
Take screenshots or convert images with waifu2x upscalling algorithm.

### [nextfile](https://github.com/donmaiq/mpv-nextfile)  
Force open next or previous file in the currently playing files directory.

### [unseen-playlistmaker](https://github.com/donmaiq/unseen-playlistmaker)
Keeps track of your watched files locally and loads unseen files from a specified directory into a playlist on keybind.  

### [appendUrl.lua](https://github.com/donmaiq/mpv-scripts/blob/master/appendURL.lua)  
Appends url from clipboard to playlist.  
  
`a script-binding appendURL`

### [customscreenshot.lua](https://github.com/donmaiq/mpv-scripts/blob/master/customscreenshot.lua)
Save screenshots in customized directories based on given conditions such as filename pattern match. Gives a lot of freedom for the user for the expense of requiring some lua knowledge with patterns, strings and mpv lua api. Read the lua file settings for more details. If you need any help with this script you can open an issue.  
  
`KEY script-message custom-screenshot [subtitles|video|window]` - take a custom screenshot  

### [cycleaudiodevice.lua](https://github.com/donmaiq/mpv-scripts/blob/master/cycleaudiodevice.lua)
Cycles predefined audio devices. Created this because updating device name on many places was not convenient. Now I can just call script message with headphones/speakers from different places like for example [context](https://gist.github.com/avih/bee746200b5712220b8bd2f230e535de) menu script or an alias startup command and only change them in one place between systems/setups. Set devices to match your system before using with help of `mpv --audio-device=help`. If you toggle only with key consider using a simple input config like `ctrl+A cycle-values audio-device "auto" "openal/device1" "pulse/device2.analog-stereo"` instead of this script.  
  
`ctrl+A script-binding cycleaudiodevice`  
argument below is index or nicename of device  
`KEY script-message setaudiodevice argument` - set audio device on runtime  
`--script-opts=audio=argument` - set audio device on startup  

### [radio.lua](https://github.com/donmaiq/mpv-scripts/blob/master/radio.lua)  
Loads a radio playlist/file on keybind with ability to save song names into a file. Requires idle or idle=once.  
  
`R script-binding radio-toggle` - toggle radio on runtime  
`r script-binding mark-song`  
`mpv --no-video --idle=once --script-opts=radio-autostart=yes` - start radio on startup  

### [trashfileonend.lua](https://github.com/donmaiq/mpv-scripts/blob/master/trashfileonend.lua)  
Allows you to remove one or consecutive files after they have ended playing. Settings for different eof-reasons and default behaviour are inside lua settings variable. Use with toggling keybind or send command directly with script message.  
  
`ctrl+alt+x script-binding toggledeletefile`  
`script-message trashfileonend true true` - deletefile[true, false], oneonly[true, false]  
`mpv --script-opts=trashfileonend-deletefile=yes` - open mpv with deletefile enabled
  
### [movingsubtitles](https://gist.github.com/jonniek/c3fed06cd7990518e8b2389f48ba3619)
Experimental nicovideo style scrolling subtitles/messages. There seems to be some kind of memoryleak that crashes the script after some time. Also has some hardcoded limits and string transformations that you might want to change. Messages can be sent with script-message from mpv scripts or IPC socket from other sources.  
  
`H script-message addscrollingsub "hello world"`  
`$ echo 'script-message addscrollingsub "hello world"' | socat - /tmp/mpvsocket`  
`mp.command("script-message addscrollingsub \"hello world\"")`

## LICENSE
Scripts in this repo: appendUrl under ISC and rest UNLICENSE
