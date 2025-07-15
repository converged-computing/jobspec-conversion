#!/bin/bash
#FLUX: --job-name="slurm_dask_timing"
#FLUX: -N=3
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export CRAY_CUDA_MPS='1'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export CRAY_CUDA_MPS=1
conda activate karabo_dev_env
srun python3 time_karabo.py
