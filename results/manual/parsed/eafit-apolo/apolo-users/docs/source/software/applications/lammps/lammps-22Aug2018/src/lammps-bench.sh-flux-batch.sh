#!/bin/bash
#FLUX: --job-name=LAMMPS_Bench
#FLUX: -n=16
#FLUX: --queue=longjobs
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export WDIR='<REPO_DIR>/bench'

export OMP_NUM_THREADS=1
module load lammps
export WDIR=<REPO_DIR>/bench
srun --mpi=pmi2 lammps -in $WDIR/in.lj
srun --mpi=pmi2 lammps -in $WDIR/in.chain
srun --mpi=pmi2 lammps -in $WDIR/in.eam
srun --mpi=pmi2 lammps -in $WDIR/in.chute
srun --mpi=pmi2 lammps -in $WDIR/in.rhodo
