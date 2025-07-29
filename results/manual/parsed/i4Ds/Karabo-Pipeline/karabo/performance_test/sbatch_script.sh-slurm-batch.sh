#!/bin/bash
#FLUX: --job-name=slurm_dask_timing
#FLUX: -N=4
#FLUX: --queue=normal
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export CRAY_CUDA_MPS='1'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export CRAY_CUDA_MPS=1
conda activate karabo_dev_env
srun python3 time_karabo_parallelization_by_channel.py
