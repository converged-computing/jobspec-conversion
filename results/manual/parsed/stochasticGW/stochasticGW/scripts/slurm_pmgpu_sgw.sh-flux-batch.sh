#!/bin/bash
#FLUX: --job-name=carnivorous-leader-6533
#FLUX: -n=4
#FLUX: -c=32
#FLUX: --gpus-per-task=1
#FLUX: -t=1799
#FLUX: --priority=16

export SLURM_CPU_BIND='cores'

module swap PrgEnv-gnu PrgEnv-nvidia
module load cray-fftw
export SLURM_CPU_BIND="cores"
srun sgw_gpu.x
