#!/bin/bash
#FLUX: --job-name=loopy-itch-9322
#FLUX: --priority=16

module purge
module restore cuda
source deactivate
source activate maskRCNN
python balloon.py train --dataset=../../datasets/balloon --weights=last
