#!/bin/bash
#FLUX: --job-name=cifar10vit16
#FLUX: -t=108000
#FLUX: --priority=16

export LD_LIBRARY_PATH='/home/cap6411.student28/anaconda3/envs/env/lib'

echo "Slurm nodes assigned :$SLURM_JOB_NODELIST"
module purge
module load cuda
module load gcc/gcc-9.1.0
module load oneapi/mkl
source ~/.bashrc
conda activate vitenv
export LD_LIBRARY_PATH=/home/cap6411.student28/anaconda3/envs/env/lib
python cifar10vit16.py
