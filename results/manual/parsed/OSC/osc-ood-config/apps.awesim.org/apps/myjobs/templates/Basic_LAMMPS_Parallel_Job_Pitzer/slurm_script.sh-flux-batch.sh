#!/bin/bash
#FLUX: --job-name=anxious-diablo-2256
#FLUX: -N=2
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

scontrol show job $SLURM_JOBID
module load intel/19.0.5 mvapich2/2.3.4 lammps/3Mar20
cd $TMPDIR
sbcast -p /users/appl/srb/workshops/compchem/lammps/in.crack $TMPDIR/in.crack
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
srun --export=ALL -n 2 lammps < $TMPDIR/in.crack
