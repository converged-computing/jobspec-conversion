#!/bin/bash
#SBATCH --job-name=LIKWID
#SBATCH --account=pr83te
#SBATCH --output=data-0064.out
#SBATCH --error=data-0064.e
#SBATCH --mail-user=munch@lnm.mw.tum.de
#SBATCH --mail-type=END
#SBATCH --nodes=64
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=48
#SBATCH --chdir=./
#SBATCH --no-requeue

module unload intel-mpi/2019-intel
module unload intel/19.0.5
module load gcc/9
module load intel-mpi/2019-gcc
pwd
array=($(ls input_*.json));
mpirun -np 3072 ../irk-3D "${array[@]}"
