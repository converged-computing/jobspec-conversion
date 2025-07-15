#!/bin/bash
#FLUX: --job-name=loopy-banana-6627
#FLUX: -c=64
#FLUX: --gpus-per-task=1
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
ROCR_VISIBLE_DEVICES=1,2,3 srun ../build/miniapps/heat3d/thrust/heat3d --nx 512 --ny 512 --nz 512 --nbiter 1000 --freq_diag 0
