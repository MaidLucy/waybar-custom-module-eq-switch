# Waybar Custom module eq-switch

So I needed to turn on or off a LV2 plugin loaded in a pipewire filterchain.
I wanted a nice button to click to make it work and display the status.

Some `jq` was written to parse into the output of `pw-dump` to find the module and get the id.
Said `jq` filter creates a new Json-object that is compatible with how waybar interprets Json for custom modules.

There's a simple bash script that toggels the plugin on or off when you run it.

From there it was only a bit of waybar config:

```json
    "custom/eqswitch": {
        "exec": "pw-dump | jq -f ./eq-switch.jq --compact-output --unbuffered",
        "on-click": "./eq-switch.sh",
        "interval": 1,
        "return-type": "json",
        "format": "eq: {icon}",
        "format-icons": {
            "enabled": "",
            "disabled": ""
        }
    }
```

Alter `exec` and `on-click` to adjust for the paths were you cloned this repository.

Have fun with it!
