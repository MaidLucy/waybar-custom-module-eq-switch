map(. | select(
    contains(
        { "info": {"params": {"PropInfo": [{"name": "LSP Parametric Equalizer x16 Stereo:enabled"}] }}}
    )
)) | .[0] |
{
    "id": .id,
    "eq_enabled": [ .info.params.Props.[].params ] | flatten(1) |
	[. as $arr | range(0; length; 2) | {
	    "key": ($arr[.]),
	    "value": $arr[. + 1]
	}] |
	map(. | select(
            contains({
	        "key": "LSP Parametric Equalizer x16 Stereo:enabled"
	    })
        )) |
	(.[0].value == 1)
} |
{
    "id": .id,
    "text": .id,
    "percentage": (if .eq_enabled == true then 100 else 0 end),
    "alt": (if .eq_enabled == true then "enabled" else "disabled" end),
    "class": (if .eq_enabled == true then "enabled" else "disabled" end),
    "inverse": (if .eq_enabled == true then 0 else 1 end)
}
