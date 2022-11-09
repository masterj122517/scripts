#!/bin/bash
#picom --experimental-backends -b
#picom &
#/bin/bash ~/scripts/xmodmap.sh & 
#dunst &
#remaps &
#notify-send "failure is not an option"
#notify-send "You should bet on yourself"
#notify-send "Learn to stay focus at home that is really important!!!"

#/bin/bash ~/scripts/setxmodmap-colemak.sh & 
#/bin/bash ~/scripts/xmodmap-emacs.sh & 
#variety & 
#fcitx &
#/bin/bash ~/scripts/dwm-status.sh &

source ~/.profile
source ~/.config/zsh/env.zsh
$DWM/statusbar/statusbar.sh cron &


settings() {
    [ $1 ] && sleep $1
    $DWM/statusbar/statusbar.sh cron &
}


daemons() {
    [ $1 ] && sleep $1
    fcitx5 &
    nm-applet &
    xfce4-power-manager &
}


settings 1 &
daemons 3 &
