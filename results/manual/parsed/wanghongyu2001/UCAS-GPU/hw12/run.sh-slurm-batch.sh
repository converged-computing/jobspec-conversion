#!/bin/bash
#SBATCH --job-name=opt
#SBATCH --output=test%j.out
#SBATCH --error=test%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=ntasks-per-node=1

module load mpich-4.0.2-gcc-4.8.5-kaz3kvk 
module load cmake-3.24.2-gcc-4.8.5-idyies2
module load cuda/11.3
./test /share/home/wanghongyu/Courses/UCAS-GPU/hw11/
