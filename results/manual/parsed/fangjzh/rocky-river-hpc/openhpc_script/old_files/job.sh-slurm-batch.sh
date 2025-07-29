#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1

mpirun   /opt/ohpc/pub/apps/lammps/lmp_mpi  -i in.lj
