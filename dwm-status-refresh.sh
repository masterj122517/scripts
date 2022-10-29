#!/bin/bash


LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
export IDENTIFIER="unicode"

#. "$DIR/dwmbar-functions/dwm_transmission.sh"
#. "$DIR/dwmbar-functions/dwm_cmus.sh"
#. "$DIR/dwmbar-functions/dwm_resources.sh"
. "$DIR/dwmbar-functions/dwm_battery.sh"
#. "$DIR/dwmbar-functions/dwm_mail.sh"
#. "$DIR/dwmbar-functions/dwm_backlight.sh"
. "$DIR/dwmbar-functions/dwm_alsa.sh"
. "$DIR/dwmbar-functions/dwm_disk.sh"
#. "$DIR/dwmbar-functions/dwm_pulse.sh"
#. "$DIR/dwmbar-functions/dwm_weather.sh"
#. "$DIR/dwmbar-functions/dwm_vpn.sh"
#. "$DIR/dwmbar-functions/dwm_network.sh"
#. "$DIR/dwmbar-functions/dwm_keyboard.sh"
#. "$DIR/dwmbar-functions/dwm_ccurse.sh"
#. "$DIR/dwmbar-functions/dwm_date.sh"


print_others() {
    icons=()
    [ "$(docker ps | grep v2raya)" ] && icons=(${icons[@]} "")

    if [ "$icons" ]; then
        text=" ${icons[@]} "
        color=$others_color
        printf "%s%s%s" "$color" "$text" "$s2d_reset"
    fi
}


print_others() {
    icons=()
    [ "$(docker ps | grep v2raya)" ] && icons=(${icons[@]} "")

    if [ "$icons" ]; then
        text=" ${icons[@]} "
        color=$others_color
        printf "%s%s%s" "$color" "$text" "$s2d_reset"
    fi
}

print_cpu() {
    cpu_icon="閭"
    cpu_text=$(top -n 1 -b | sed -n '3p' | awk '{printf "%02d%", 100 - $8}')

    text=" $cpu_icon $cpu_text "
    color=$cpu_color
    printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

print_mem() {
    mem_total=$(cat /proc/meminfo | grep "MemTotal:"|awk '{print $2}')
    mem_free=$(cat /proc/meminfo | grep "MemFree:"|awk '{print $2}')
    mem_buffers=$(cat /proc/meminfo | grep "Buffers:"|awk '{print $2}')
    mem_cached=$(cat /proc/meminfo | grep -w "Cached:"|awk '{print $2}')
    men_usage_rate=$(((mem_total - mem_free - mem_buffers - mem_cached) * 100 / mem_total))
	mem_icon=""
    mem_text=$(echo $men_usage_rate | awk '{printf "%02d%", $1}')
    text=" $mem_icon $mem_text "
    color=$mem_color
    printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

print_time() {
    time_text="$(date '+%m/%d %H:%M')"
    case "$(date '+%I')" in
        "01") time_icon="" ;;
        "02") time_icon="" ;;
        "03") time_icon="" ;;
        "04") time_icon="" ;;
        "05") time_icon="" ;;
        "06") time_icon="" ;;
        "07") time_icon="" ;;
        "08") time_icon="" ;;
        "09") time_icon="" ;;
        "10") time_icon="" ;;
        "11") time_icon="" ;;
        "12") time_icon="" ;;
    esac

    text=" $time_icon $time_text "
    color=$time_color
    printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

print_vol() {
    OUTPORT=$SPEAKER
    [ "$(pactl list sinks | grep $HEADPHONE_A2DP)" ] && OUTPORT=$HEADPHONE_A2DP
    [ "$(pactl list sinks | grep $HEADPHONE_HSP_HFP)" ] && OUTPORT=$HEADPHONE_HSP_HFP
    [ "$(pactl list sinks | grep $HEADPHONE_A2DP_SONY)" ] && OUTPORT=$HEADPHONE_A2DP_SONY
    [ "$(pactl list sinks | grep $HEADPHONE_HSP_HFP_SONY)" ] && OUTPORT=$HEADPHONE_HSP_HFP_SONY
    [ "$(pactl list sinks | grep $VOICEBOX)" ] && OUTPORT=$VOICEBOX
    volunmuted=$(pactl list sinks | grep $OUTPORT -A 10 | grep 'Mute: no')
    vol_text=$(pactl list sinks | grep $OUTPORT -A 8 | sed -n '8p' | awk '{printf int($5)}')
    if [ "$vol_text" -eq 0 ] || [ ! "$volunmuted" ]; then vol_text="--"; vol_icon="婢";
    elif [ "$vol_text" -lt 10 ]; then vol_icon="奄"; vol_text=0$vol_text;
    elif [ "$vol_text" -le 20 ]; then vol_icon="奄";
    elif [ "$vol_text" -le 60 ]; then vol_icon="奔";
    else vol_icon="墳"; fi

    vol_text=$vol_text%

    text=" $vol_icon $vol_text "
    color=$vol_color
    printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

print_bat() {
    bat_text=$(acpi -b | sed 2d | awk '{print $4}' | grep -Eo "[0-9]+")
    [ ! "$bat_text" ] && bat_text=$(acpi -b | sed 2d | awk '{print $5}' | grep -Eo "[0-9]+")
    [ ! "$(acpi -b | grep 'Battery 0' | grep Discharging)" ] && charge_icon=""
    if  [ "$bat_text" -ge 95 ]; then charge_icon=""; bat_icon="";
    elif [ "$bat_text" -ge 90 ]; then bat_icon="";
    elif [ "$bat_text" -ge 80 ]; then bat_icon="";
    elif [ "$bat_text" -ge 70 ]; then bat_icon="";
    elif [ "$bat_text" -ge 60 ]; then bat_icon="";
    elif [ "$bat_text" -ge 50 ]; then bat_icon="";
    elif [ "$bat_text" -ge 40 ]; then bat_icon="";
    elif [ "$bat_text" -ge 30 ]; then bat_icon="";
    elif [ "$bat_text" -ge 20 ]; then bat_icon="";
    elif [ "$bat_text" -ge 10 ]; then bat_icon="";
    else bat_icon=""; fi

    bat_text=$bat_text%
    bat_icon=$charge_icon$bat_icon

    text=" $bat_icon $bat_text "
    color=$bat_color
    printf "%s%s%s" "$color" "$text" "$s2d_reset"
}

xsetroot -name "$(print_others)$(print_cpu)$(print_mem)$(print_time)$(dwm_alsa)$(print_bat)"
#xsetroot -name "$(print_others)$(print_mem)M ⬇️$vel_recv ⬆️$vel_trans $(dwm_alsa) $(battery) $(show_record)$(print_date) "
