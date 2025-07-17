#!/bin/bash
#FLUX: --job-name=rainbow-chair-1862
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
module restore cuda
source deactivate
source activate maskRCNN
python balloon.py train --dataset=../../datasets/balloon --weights=last
