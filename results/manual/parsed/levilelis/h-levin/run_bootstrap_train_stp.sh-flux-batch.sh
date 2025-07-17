#!/bin/bash
#FLUX: --job-name=doopy-caramel-6397
#FLUX: -c=6
#FLUX: -t=259200
#FLUX: --urgency=16

module load python/3.6
source tensorflow/bin/activate
python src/main.py ${scheme} -a ${algorithm} -l ${loss} -m ${model} -p problems/stp/puzzles_5x5_train/ --learn -d SlidingTile -b 7000 -g 10
