#!/bin/sh

#time to wait for apps to launch, may need to be changed
APP_LAUNCH_WAIT=5

CONFIG=$HOME/.config/i3/config #config to modify
CONFIG_BACKUP=${CONFIG}_startup_backup #backup unmodified config location

APPS=(firefox urxvt) #binaries to open
NAMES=("firefox" "urxvt") #corresponding names of apps to open
WORKSPACES=("1" "EDIT") #name of workspaces to open apps in 
CRITERIA=(class title)  #criterion for comparing name, used by i3
                        #choose from class, id, instance, title
                        #usually use class and the value from xprop


cp $CONFIG $CONFIG_BACKUP

len=${#APPS[@]} #number of apps
for ((i=0; i<=$(expr $len - 1); i++)) do #append config for all apps
    APP=${APPS[i]}
    NAME=${NAMES[i]}
    WORKSPACE=${WORKSPACES[i]}
    CRITERION=${CRITERIA[i]}
    echo "for_window [$CRITERION=\"$NAME\"] move to workspace \"$WORKSPACE\"" >> $CONFIG
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
