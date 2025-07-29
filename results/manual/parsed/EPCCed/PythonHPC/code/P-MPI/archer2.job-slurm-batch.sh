#!/bin/bash
#SBATCH --job-name=traffic
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=standard
#SBATCH --qos=reservation

module load cray-python
srun --unbuffered --distribution=block:block --hint=nomultithread \
     python traffic.py
