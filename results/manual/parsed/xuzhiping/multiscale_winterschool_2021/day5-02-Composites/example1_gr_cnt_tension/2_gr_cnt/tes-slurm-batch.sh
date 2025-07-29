#!/bin/bash
#SBATCH --job-name=MD_tension
#SBATCH --output=stdout.%j
#SBATCH --error=stderr.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=course
#SBATCH --constraint=ntasks-per-node=28
#SBATCH: --no-requeue

module load compiles/intel/2019/u4/config
exe="/apps/soft/lammps/lammps-7Aug19/e5_2680v4/opa/lammps-7Aug19/src/lmp_mpi"
exe="/home/train1/WORK/package/lammps-stable_29Oct2020/src/lmp_mpi"
exe="/apps/soft/lammps/lammps-3Mar20/src/lmp_mpi"
mpirun -np 4 ${exe} < gr_cnt.in
