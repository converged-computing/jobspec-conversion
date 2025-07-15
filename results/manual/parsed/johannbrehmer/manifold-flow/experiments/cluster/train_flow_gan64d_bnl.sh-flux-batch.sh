#!/bin/bash
#FLUX: --job-name=t-f-g
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
python -u train.py -c configs/train_flow_gan64d_april.config -i ${SLURM_ARRAY_TASK_ID} --dir /sdcc/u/brehmer/manifold-flow
