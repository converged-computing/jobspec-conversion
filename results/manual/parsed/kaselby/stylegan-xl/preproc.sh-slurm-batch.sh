#!/bin/bash
#FLUX: --job-name=stylegan-xl
#FLUX: --queue=a40
#FLUX: --urgency=16

src=$1
tgt=$2
res=$3
args=${@:4}
python dataset_tool.py --source=$src --dest=$tgt --resolution="${res}x${res}" --transform=center-crop $args
