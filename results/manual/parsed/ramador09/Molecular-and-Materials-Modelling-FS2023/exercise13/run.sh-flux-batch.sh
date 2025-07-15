#!/bin/bash
#FLUX: --job-name=mol. dyn.
#FLUX: --queue=normal
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK:-1}'
export CRAY_CUDA_MPS='1'

module load daint-gpu
module load CP2K
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1}
export CRAY_CUDA_MPS=1
ulimit -s unlimited
srun -n 12 cp2k.popt -i md.inp -o md.out
