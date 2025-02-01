# Waybar Custom module eq-switch

So I needed to turn on or off a LV2 plugin loaded in a pipewire filterchain.
I wanted a nice button to click to make it work and display the status.

Some `jq` was written to parse into the output of `pw-dump` to find the module and get the id.
Said `jq` filter creates a new Json-object that is compatible with how waybar interprets Json for custom modules.

There's a simple bash script that toggels the plugin on or off when you run it.

It can also calculate dB-values in order to have a simple volume adjustment for my subwoofer.

From there it was only a bit of waybar config:

```json
"custom/eqswitch": {
        "exec": "pw-dump | jq -f ./eq-switch.jq --compact-output --unbuffered",
	"on-click": "./eq-switch.sh eqt",
	"on-scroll-up": "./eq-switch.sh sub-",
	"on-scroll-down": "./eq-switch.sh sub+",
        "interval": 1,
	"return-type": "json",
	"tooltip": true,
        "format": "eq: {icon}",
        "format-icons": {
	    "enabled": "",
	    "disabled": ""
	}
}
    
```

Alter `exec`, `on-click`, `on-scroll-up`, `on-scroll-down` to adjust for the paths where you cloned this repository.

Have fun with it!
