#!/bin/sh

APP_LAUNCH_WAIT=5 #time to wait for apps to launch, may need to be changed

CONFIG=$HOME/.config/i3/config #config to modify
CONFIG_BACKUP=${CONFIG}_startup_backup #place to backup unmodified config 

APPS=(firefox urxvt) #binaries to open
NAMES=(firefox urxvt) #corresponding names of apps to open
WORKSPACES=(1, \$ws2) #name of workspaces to open apps in 
CRITERIA=(class class) #criteria to base name on, choose from class, id, instance, title

#backup config
cp $CONFIG $CONFIG_BACKUP

append_config() {
    echo "for_window [$1=\"$2\"] move to workspace $3" >> $CONFIG
}

len=${#APPS[@]} #number of apps
for ((i=0; i<=$(expr $len - 1); i++)) do #append config for all apps
    append_config ${CRITERIA[i]} ${NAMES[i]} ${WORKSPACES[i]}
done

#sync writes to config to disk, restart i3 with modified config
sync $CONFIG
i3-msg restart

#start apps
for ((i=0; i<=$(expr $len - 1); i++)) do
    nohup ${APPS[i]} &
done

sleep $APP_LAUNCH_WAIT

#restore original i3 config
mv $CONFIG_BACKUP $CONFIG
i3-msg restart
