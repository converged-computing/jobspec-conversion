#!/bin/bash
#FLUX: --job-name=vcl
#FLUX: --queue=devel
#FLUX: --priority=16

module load Anaconda3/2023.09-0
module use $DATA/easybuild/modules/all
module load CUDA/12.1.1
module load cuDNN/8.9.2.26-CUDA-12.1.1
source activate $DATA/.cache/conda/envs/vcl4
python run_$1.py $2
