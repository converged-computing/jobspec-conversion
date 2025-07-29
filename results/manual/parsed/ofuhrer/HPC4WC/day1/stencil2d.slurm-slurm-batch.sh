#!/bin/bash
#FLUX: --job-name=stencil2d.$USER
#FLUX: --queue=debug
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export CRAY_CUDA_MPS='1'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export CRAY_CUDA_MPS=1
exe=stencil2d.x
nx=128
ny=128
nz=64
num_iter=1024
echo "==== START OF EXECUTION `date +%s` ===="
srun ./${exe}+orig -nx ${nx} -ny ${ny} -nz ${nz} -num_iter ${num_iter}
echo "===== END OF EXECUTION `date +%s` ====="
echo "==== START OF PROFILING `date +%s` ===="
srun ./${exe} -nx ${nx} -ny ${ny} -nz ${nz} -num_iter ${num_iter}
echo "===== END OF PROFILING `date +%s` ====="
exit 0
