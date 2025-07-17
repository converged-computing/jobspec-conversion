#!/bin/bash
#FLUX: --job-name=gromacs
#FLUX: -n=24
#FLUX: --queue=ampere
#FLUX: --urgency=16

export OMP_NUM_THREADS='$ntomp'

if [ -n "$SLURM_CPUS_PER_TASK" ]; then
   ntomp="$SLURM_CPUS_PER_TASK"
else
   ntomp="1"
fi
export OMP_NUM_THREADS=$ntomp
mpirun gmx_mpi mdrun -ntomp $ntomp -deffnm $1
