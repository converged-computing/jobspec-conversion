#!/bin/bash
#SBATCH --job-name=ex1_prs_gr
#SBATCH --output=stdout.%j
#SBATCH --error=stderr.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=28
#SBATCH --no-requeue

module load compiles/intel/2019/u4/config
exe="/home/train1/WORK/package/lammps-stable_29Oct2020/src/lmp_mpi"
mpiexec.hydra -n 28 ${exe} < porous_gr.in >& log
gnuplot < plot.plt
