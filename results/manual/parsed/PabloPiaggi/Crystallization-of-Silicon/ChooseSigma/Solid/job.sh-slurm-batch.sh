#!/bin/bash
#FLUX: --job-name=Si
#FLUX: -n=4
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
pwd; hostname; date
module purge
module load intel-mpi intel
LAMMPS_HOME=/home/ppiaggi/Programs/Lammps/lammps-git-cpu/build6
LAMMPS_EXE=${LAMMPS_HOME}/lmp_della
cycles=1
partitions=1
nn=1
srun $LAMMPS_EXE -sf omp -in start.lmp
date
