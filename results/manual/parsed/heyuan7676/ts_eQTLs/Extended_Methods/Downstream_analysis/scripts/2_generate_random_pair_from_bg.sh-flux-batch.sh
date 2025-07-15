#!/bin/bash
#FLUX: --job-name=grated-spoon-7239
#FLUX: -t=36000
#FLUX: --priority=16

source ./GLOBAL_VAR.sh
module load python/2.7
python ${scripts_dir}/2_generate_random_pair_from_bg.py "$1" "$2"
