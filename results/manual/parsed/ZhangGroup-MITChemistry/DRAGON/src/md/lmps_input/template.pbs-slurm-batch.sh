#!/bin/bash
#SBATCH --job-name=lmps
#SBATCH --nodes=1
#SBATCH --ntasks=14
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --no-requeue

module load gcc
module add mvapich2/gcc
lammpsdir="../LAMMPS-PreGenome/src/"
mpirun -np 14 $lammpsdir/lmp_openmpi -in in.chromosome
