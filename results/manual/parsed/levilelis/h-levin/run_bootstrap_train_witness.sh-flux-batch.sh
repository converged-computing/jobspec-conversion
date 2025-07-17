#!/bin/bash
#FLUX: --job-name=hello-bike-5869
#FLUX: -c=6
#FLUX: -t=604800
#FLUX: --urgency=16

module load python/3.6
source tensorflow/bin/activate
python src/main.py ${scheme} -a ${algorithm} -l ${loss} -m ${model} -p problems/witness/puzzles_4x4_50k_train/ --learn -d Witness -b 2000
