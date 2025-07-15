#!/bin/bash
#FLUX: --job-name=nvdiffrecmc
#FLUX: -c=8
#FLUX: --priority=16

scenes=(
bear
clock
dog
durian
jade
man
sculpture
stone
)
scene="man"
echo "====== Scene: $scene ======"
python train.py --config configs/${scene}.json
