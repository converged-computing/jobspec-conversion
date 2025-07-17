#!/bin/bash
#FLUX: --job-name=setup
#FLUX: -c=2
#FLUX: -t=900
#FLUX: --urgency=16

module load tensorflow/python3.6/1.5.0
module swap python3/intel  anaconda3/5.3.1
cd ~/simpleprince
conda env create
