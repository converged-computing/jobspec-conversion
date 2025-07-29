#!/bin/bash
#SBATCH --job-name=torch-test
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=00:05:00

module load singularity 
singularity exec --nv /home/schickerur/venv/python-va3.sif  python3 gpu6.py
