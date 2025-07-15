#!/bin/bash
#FLUX: --job-name=t-mf-c
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

module load cuda/10.1.105
source activate ml
export OMP_NUM_THREADS=1
cd /scratch/jb6504/manifold-flow/experiments
nvcc --version
nvidia-smi
dim=$((2**$SLURM_ARRAY_TASK_ID))
python -u train.py -c configs/train_mf_celeba_scan.config -i 0 --modelname scan_${dim} --modellatentdim ${dim}
