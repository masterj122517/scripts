
~/.zprofile
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
    vpn &
}


settings 1 &
daemons 3 &
