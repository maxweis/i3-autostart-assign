# i3-autostart-assign
Automatiically start applications in specified workspaces upon launch of i3. <br><br>
Patches i3 config temporarily to assign apps to workspaces, launches apps, then restores old configuration.

## usage
Call in i3 configuration like this:
`exec --no-startup-id exec ~/.startup_apps.sh`

## configuration
* Set `APP_LAUNCH_WAIT` to the time in seconds your apps take to launch
* Set `CONFIG` to path to i3 configuration.

### adding an app
* Add app binary name to `APPS` array.
* Add name to `NAMES` to identify app based on the criterion in `CRITERIA`. <br>
  Set criterion for app to `class`, `instance`, or `title`.
  Usually use class or title. Find class using `xprop`.
* Add the name of the workspace to assign the app to`WORKSPACES`.

## rationale
This is the only reliable and efficient way to launch multiple applications at launch of i3 I have found.
