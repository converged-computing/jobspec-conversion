#!/bin/bash
#FLUX: --job-name=t-emf-c
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

module load cuda/10.1.105
source activate ml2
export OMP_NUM_THREADS=1
cd /scratch/jb6504/manifold-flow/experiments
nvcc --version
nvidia-smi
python -u train.py -c configs/train_mf_celeba_may.config --algorithm emf -i ${SLURM_ARRAY_TASK_ID}
