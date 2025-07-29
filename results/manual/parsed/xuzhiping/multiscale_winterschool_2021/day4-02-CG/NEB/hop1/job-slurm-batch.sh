#!/bin/bash
#SBATCH --job-name=lammps-NEB1
#SBATCH --output=stdout.%j
#SBATCH --error=stderr.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=course
#SBATCH --constraint=ntasks-per-node=24
#SBATCH: --no-requeue

module load compiles/intel/2019/u4/config
module load lib/gcc/9.2.0/config
mpirun -n 24 /home/train1/WORK/package/lammps-stable_29Oct2020/src/lmp_mpi -partition 12x2 -in in.neb.hop1 >log
