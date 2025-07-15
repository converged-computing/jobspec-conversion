#!/bin/bash
#FLUX: --job-name=urea
#FLUX: --urgency=16

module load plumed
module load gcc
module load gromacs/2020.2-cpu
sh GenTprFile.sh
mpirun -np $SLURM_NPROCS -c 3 gmx_mpi mdrun -ntomp 6 -v -deffnm urea -plumed plumed.dat
