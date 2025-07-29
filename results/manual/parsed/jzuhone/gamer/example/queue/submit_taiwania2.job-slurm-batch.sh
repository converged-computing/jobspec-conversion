#!/bin/bash
#SBATCH --job-name=YOUR_JOB_NAME
#SBATCH --account=YOUR_ACCOUNT
#SBATCH --output=log-%j
#SBATCH --mail-user=YOUR_EMAIL
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:8
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=8

module purge
module load compiler/gnu/4.8.5 nvidia/cuda/10.0 openmpi/3.1.4
srun ./gamer 1>>log 2>&1
