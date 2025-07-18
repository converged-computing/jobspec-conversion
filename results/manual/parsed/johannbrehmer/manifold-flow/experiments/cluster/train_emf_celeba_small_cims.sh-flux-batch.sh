#!/bin/bash
#FLUX: --job-name=t-emfs-c
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --urgency=16

export PATH='/home/brehmer/miniconda3/envs/ml/bin/:$PATH'
export OMP_NUM_THREADS='1'

module load cuda-10.2
conda activate ml
export PATH="/home/brehmer/miniconda3/envs/ml/bin/:$PATH"
export OMP_NUM_THREADS=1
dir=/data/brehmer/manifold-flow
cd $dir/experiments
nvcc --version
nvidia-smi
python -u train.py -c configs/train_mf_celeba_april.config --algorithm emf --modellatentdim 128 -i ${SLURM_ARRAY_TASK_ID} --dir $dir
