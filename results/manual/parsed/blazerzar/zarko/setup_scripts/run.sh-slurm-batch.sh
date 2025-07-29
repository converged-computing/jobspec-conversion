#!/bin/bash
#SBATCH --job-name=pytorch
#SBATCH --output=output.txt
#SBATCH --error=error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=2gb
#SBATCH --time=00:30:00

srun singularity exec --nv ./containers/pytorch.sif python code/arso_to_dataframe.py
