#!/bin/bash
#FLUX: --job-name=Interface
#FLUX: -n=20
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
pwd; hostname; date
module purge
module load intel-mpi intel
LAMMPS_HOME=/home/ppiaggi/Programs/Lammps/lammps-git-cpu/build4
LAMMPS_EXE=${LAMMPS_HOME}/lmp_della
srun $LAMMPS_EXE -in start.lmp
date
