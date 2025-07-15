#!/bin/bash
#FLUX: --job-name=dinosaur-leopard-7516
#FLUX: -c=64
#FLUX: --gpus-per-task=1
#FLUX: -t=600
#FLUX: --priority=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module purge
module load openmpi/4.1.1
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
ROCR_VISIBLE_DEVICES=1,2,3 ../build/miniapps/vlp4d/kokkos/vlp4d SLD10_large.dat
