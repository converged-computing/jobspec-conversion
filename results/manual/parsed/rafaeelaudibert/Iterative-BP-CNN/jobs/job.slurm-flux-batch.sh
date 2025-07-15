#!/bin/bash
#FLUX: --job-name=iterative-bp-cnn
#FLUX: -t=345600
#FLUX: --urgency=16

module load nvidia/latest
module load anaconda3/latest
. $ANACONDA_HOME/etc/profile.d/conda.sh
conda activate iterative-bp-cnn
python3 ~/Iterative-BP-CNN/main.py -Func Train
conda deactivate
