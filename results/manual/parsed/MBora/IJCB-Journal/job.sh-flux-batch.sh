#!/bin/bash
#FLUX: --job-name="lstm"
#FLUX: --priority=16

nvidia-smi
conda env list
source activate cave
spack load cuda/gypzm3r
spack load cudnn
srun python3 ./run.py
