#!/bin/bash
#SBATCH --job-name=woojung
#SBATCH --output=%x.o%j
#SBATCH --error=%x.e%j
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=01:30:00
#SBATCH --partition=ivy_v100_2

srun python /scratch/kedu14/woojung/albert/mycode/albert_practice.py
