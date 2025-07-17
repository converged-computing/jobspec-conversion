#!/bin/bash
#FLUX: --job-name=poi_adam
#FLUX: -c=64
#FLUX: --gpus-per-task=1
#FLUX: --queue=amdrome
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module purge
module load openmpi/4.1.1
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
ROCR_VISIBLE_DEVICES=1,2,3 ../build/miniapps/vlp4d/kokkos/vlp4d SLD10_large.dat
