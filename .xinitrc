xrandr --output HDMI1 --right-of e-DP1
xsetroot -solid "#0c0c0c"
xset b off
export EDITOR=vim
export BROWSER=firefox
export GTK_THEME=Adwaita:dark
#export GTK_ICON_THEME=Papirus
export XDG_CURRENT_DESKTOP=i3
export XDG_SESSION_DESKTOP=i3
export XDG_SESSION_TYPE=x11
setxkbmap -option caps:escape_shifted_capslock
xinput set-prop "ELAN469D:00 04F3:304B Touchpad" "libinput Tapping Enabled" 1
exec i3
