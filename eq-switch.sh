#!/bin/bash
json=$(pw-dump | jq -f ~/Software/eq-switch.jq)
node_id=$(echo $json | jq '.id')
set_to=$(echo $json | jq '.inverse')
pw-cli s $node_id Props '{ params = [ "LSP Parametric Equalizer x16 Stereo:enabled" '$set_to' ]}' > /dev/null
sleep 0.1
pw-dump | jq -f ./Software/eq-switch.jq --compact-output --unbuffered
