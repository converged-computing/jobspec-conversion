#!/bin/bash
#FLUX: --job-name=hairy-general-3700
#FLUX: --urgency=16

module purge
module restore cuda
source deactivate
source activate maskRCNN
python balloon.py train --dataset=../../datasets/balloon --weights=last
