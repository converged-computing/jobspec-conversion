#!/bin/bash
#SBATCH --job-name=joncoron
#SBATCH --mail-user=jkarls15@student.aau.dk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --partition=batch
#SBATCH --qos=normal
#SBATCH --chdir=/user/student.aau.dk/jkarls15

srun singularity exec --nv tensorflow_20.02-tf1-py3.sif python P10-ExoskeletonTransferLearning/meta_temp.py
