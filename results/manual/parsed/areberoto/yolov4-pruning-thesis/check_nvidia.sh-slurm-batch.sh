#!/bin/bash
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=00:01:00
#SBATCH --partition=gpus
#SBATCH --constraint=ntasks-per-node=1

date
nvidia-smi 
