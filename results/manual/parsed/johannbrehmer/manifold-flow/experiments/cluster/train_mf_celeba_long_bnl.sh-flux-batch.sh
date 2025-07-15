#!/bin/bash
#FLUX: --job-name=t-mfl-c
#FLUX: -c=4
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

source ~/.bashrc
module load cuda/10.1
conda activate ml
export OMP_NUM_THREADS=1
cd /sdcc/u/brehmer/manifold-flow/experiments
nvcc --version
nvidia-smi
python -u train.py -c configs/train_mf_celeba_april.config --modelname long_april --epochs 200 --resume 100 -i ${SLURM_ARRAY_TASK_ID}
