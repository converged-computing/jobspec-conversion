#!/bin/bash
#SBATCH --job-name=DNA
#SBATCH --account=nn4654k
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3000M
#SBATCH --time=00:30:00
#SBATCH --qos=devel
#SBATCH --constraint=ntasks-per-node=2

module load PETSc/3.4.4
make clean
make
mpiexec -n 2 test
exit 0
