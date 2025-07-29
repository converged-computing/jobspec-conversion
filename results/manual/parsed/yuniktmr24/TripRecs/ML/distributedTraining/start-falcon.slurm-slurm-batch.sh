#!/bin/bash
#SBATCH --job-name=dy-dist
#SBATCH --output=result_epochs_.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:nvidia_a100_3g.39gb:2
#SBATCH --mem=4G
#SBATCH --time=10:00:00
#SBATCH --partition=peregrine-gpu
#SBATCH --qos=gpu_short
#SBATCH --constraint=ntasks-per-node=2

module purge
module load python/anaconda
srun python DistributedTraining.py
