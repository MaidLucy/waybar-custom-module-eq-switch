#!/bin/bash
# script dir stolen from: 
# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
json=$(pw-dump | jq -f ${SCRIPT_DIR}/eq-switch.jq)
node_id=$(echo $json | jq '.id')
eq_switch=$(echo $json | jq '.inverse')
b_inc=$(echo $json | jq '.sub_p1')
b_dec=$(echo $json | jq '.sub_m1')
if [ "$1" == "sub+" ]; then
    pw-cli s $node_id Props '{ params = [ "LSP Crossover Stereo x8:bg_0" '$b_dec' ]}' > /dev/null
else if [ "$1" == "sub-" ]; then
    pw-cli s $node_id Props '{ params = [ "LSP Crossover Stereo x8:bg_0" '$b_inc' ]}' > /dev/null
else if [ "$1" == "eqt" ]; then
    pw-cli s $node_id Props '{ params = [ "LSP Parametric Equalizer x16 Stereo:enabled" '$eq_switch' ]}' > /dev/null
fi fi fi
sleep 0.1
pw-dump | jq -f ${SCRIPT_DIR}/eq-switch.jq --compact-output --unbuffered
