#!/bin/bash
#FLUX: --job-name=ornery-platanos-6784
#FLUX: -t=288000
#FLUX: --urgency=16

module purge
module load baskerville
module load bask-apps/test
module load Miniconda3/4.10.3
module load cuDNN/8.0.4.30-CUDA-11.1.1
module load libsndfile
source activate asteroid1
which python
echo $CUDA_VISIBLE_DEVICES
./run.sh
