#!/bin/bash
#FLUX: --job-name=muffled-avocado-5377
#FLUX: -n=40
#FLUX: --exclusive
#FLUX: --queue=l_long
#FLUX: -t=259200
#FLUX: --priority=16

export OMP_NUM_THREADS='$omp_threads'

if [ -n "$SLURM_CPUS_PER_TASK" ]; then
 omp_threads=$SLURM_CPUS_PER_TASK
else
 omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads
echo "OMP_NUM_THREADS=" $omp_threads
module unload PrgEnv-cray
module load PrgEnv-intel
license=5-1563
releasename=544_18Apr17
variant=""
build=cnl7.0_intel19.1.3.304
releasever=5.4.4
bindir="/ddn/projects/vasp/5-2728/544_18Apr17/cnl6.0_intel17.0.1.132/src/vasp.5.4.4/bin"
srun --propagate=STACK,MEMLOCK --hint=nomultithread  $bindir/vasp_std
