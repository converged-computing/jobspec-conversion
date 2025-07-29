#!/bin/bash
#FLUX: --job-name=sGW
#FLUX: -n=128
#FLUX: -c=2
#FLUX: -t=1799
#FLUX: --urgency=16

export SLURM_CPU_BIND='cores'

module swap PrgEnv-nvidia PrgEnv-gnu
module load cray-fftw
export SLURM_CPU_BIND="cores"
srun sgw_cpu.x
