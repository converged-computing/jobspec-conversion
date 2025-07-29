#!/bin/bash
#SBATCH --account=p200301
#SBATCH --nodes=3
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=8
#SBATCH --time=00:05:00
#SBATCH --partition=fpga
#SBATCH --qos=default
#SBATCH --constraint=ntasks-per-node=1

module load ifpgasdk && module load 520nmx && module load CMake && module load intel && module load deploy/EasyBuild
cd build
git pull
make main_node
srun main_node matrix_10000.bin rhs_10000.bin
