#!/bin/bash
#FLUX: --job-name=persnickety-muffin-0736
#FLUX: -c=6
#FLUX: -t=604800
#FLUX: --urgency=16

module load python/3.6
source tensorflow/bin/activate
python src/main.py ${scheme} -a ${algorithm} -l ${loss} -m ${model} -w ${weight} -p problems/sokoban/train_50000/ --learn -d Sokoban -b 2000 -g 10
