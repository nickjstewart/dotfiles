#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi


#Load settings for xterm
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources



#load background script
sh ~/.fehbg &


#load custom keymaps
if [ -s ~/.Xmodmap]; then
  xmodmap ~/.Xmodmap
fi

##Load mpd if not already running
if ps aux | grep "[m]pd" > /dev/null
then
	echo "MPD already running"
else
	mpd .config/mpd/mpd.conf
fi

# set trackpoing speed
xinput -set-prop 10 140 4 0 0 0 4 0 0 0 1

#Export correct hardware acceleration
export VDPAU_DRIVER=va_gl

#Export terminal choice for i3
export TERMINAL=terminator

#setup autolocker
xautolock -time 15 -locker i3lockScript &

#start dropbox
dropbox &

#start pcmanfm
pcmanfm -d &

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
exec i3 


