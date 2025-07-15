#!/bin/bash
#FLUX: --job-name=placid-poodle-2456
#FLUX: -c=64
#FLUX: --gpus-per-task=1
#FLUX: -t=600
#FLUX: --priority=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
ROCR_VISIBLE_DEVICES=1,2,3 srun ../build/miniapps/vlp4d/thrust/vlp4d SLD10_large.dat
