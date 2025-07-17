#!/bin/bash
#FLUX: --job-name=extract_b0_masks
#FLUX: -c=4
#FLUX: -t=1800
#FLUX: --urgency=16

set -x
set -e
function abspath { echo $(cd $(dirname $1); pwd)/$(basename $1); }
dwi=`jq -r '.dwi' config.json`
bvals=`jq -r '.bvals' config.json`
num_processes=4
backend='loky'
echo `abspath $dwi`
echo `abspath $bvals`
singularity exec --cleanenv -e docker://dpys/extract_b0_mask:latest extract_b0_masks.py `abspath "$dwi"` `abspath "$bvals"` "$num_processes" "$backend"
