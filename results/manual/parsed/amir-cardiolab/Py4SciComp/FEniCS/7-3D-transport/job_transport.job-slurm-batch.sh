#!/bin/bash
#SBATCH --job-name=transport
#SBATCH --nodes=1
#SBATCH --ntasks=30
#SBATCH --cpus-per-task=1
#SBATCH --time=1-16:30:00
#SBATCH --chdir=/home/sci/amir.arzani/Python_tutorials/Fenics/NS_steady/

source ~/anaconda3/etc/profile.d/conda.sh
conda activate fenics2018							   
time mpirun python adv-diff-Dif2-CN.py > log.out
