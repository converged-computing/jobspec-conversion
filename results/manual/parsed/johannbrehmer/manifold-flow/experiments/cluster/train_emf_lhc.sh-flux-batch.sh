#!/bin/bash
#FLUX: --job-name=t-emf-l
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

source activate ml
export OMP_NUM_THREADS=1
cd /scratch/jb6504/manifold-flow/experiments
python -u train.py -c configs/train_mf_lhc_june.config --algorithm emf -i ${SLURM_ARRAY_TASK_ID}
