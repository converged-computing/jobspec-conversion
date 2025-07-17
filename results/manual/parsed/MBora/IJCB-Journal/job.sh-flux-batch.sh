#!/bin/bash
#FLUX: --job-name=lstm
#FLUX: -c=16
#FLUX: --queue=gpu_a100_8
#FLUX: -t=719
#FLUX: --urgency=16

nvidia-smi
conda env list
source activate cave
spack load cuda/gypzm3r
spack load cudnn
srun python3 ./run.py
