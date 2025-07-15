#!/bin/bash
#FLUX: --job-name="cclm-debug"
#FLUX: -N=4
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export CRAY_CUDA_MPS='1'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export CRAY_CUDA_MPS=1
srun -u ./cclm_debug
