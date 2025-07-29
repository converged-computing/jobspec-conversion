#!/bin/bash
#SBATCH --job-name=Lotus
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-12:00:00
#SBATCH --constraint=ntasks-per-node=2

module load openmpi/3.0.0/gcc-6.4.0
module load gcc/6.4.0
module load python/2.7.14
module load boost/1.76.0
source ~/.profile
./Allrun -parallel 1
