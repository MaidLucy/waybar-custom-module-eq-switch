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
	(.[0].value == 1),
    "sub_vol": [ .info.params.Props.[].params ] | flatten(1) |
	[. as $arr | range(0; length; 2) | {
	    "key": ($arr[.]),
	    "value": $arr[. + 1]
	}] |
	map(. | select(
            contains({
	        "key": "LSP Crossover Stereo x8:bg_0"
	    })
        )) |
	(.[0].value | log10 | . * 20 | round)
} |
{
    "id": .id,
    "text": .id,
    "sub_vol": .sub_vol,
    "sub_p1": pow(10; (.sub_vol + 1) / 20),
    "sub_m1": pow(10; (.sub_vol - 1) / 20),
    "percentage": (if .eq_enabled == true then 100 else 0 end),
    "alt": (if .eq_enabled == true then "enabled" else "disabled" end),
    "class": (if .eq_enabled == true then "enabled" else "disabled" end),
    "inverse": (if .eq_enabled == true then 0 else 1 end)
}
