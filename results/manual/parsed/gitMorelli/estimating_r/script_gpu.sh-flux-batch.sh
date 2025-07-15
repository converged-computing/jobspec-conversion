#!/bin/bash
#FLUX: --job-name=amorelli_job
#FLUX: --queue=longrun
#FLUX: --priority=16

module load cuda/11.4
module load cudnn/8.2
module load openmpi
module list
nvidia-smi
nvcc --version
srun python training.py
