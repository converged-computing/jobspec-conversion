#!/bin/bash
#FLUX: --job-name=dinosaur-plant-0123
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export reset_counters='-resetstep 1000 -nsteps 2000'

ml purge  > /dev/null 2>&1 
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
ml GROMACS/2021-Python-3.7.4
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export reset_counters="-resetstep 1000 -nsteps 2000"
ml GCC/8.2.0-2.31.1  CUDA/10.1.105  OpenMPI/3.1.3
ml GROMACS/2019.2
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    mdargs="-ntomp $SLURM_CPUS_PER_TASK"
else
    mdargs="-ntomp 1"
fi
gmx mdrun -ntmpi 4 -ntomp $SLURM_CPUS_PER_TASK -dlb yes $reset_counters -s benchRIB.tpr 
