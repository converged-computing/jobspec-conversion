#!/bin/bash
#SBATCH --output=slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8192
#SBATCH --time=1-00:00:00

module load miniconda/4.11.0
conda run -n cerys python3.8 hello_world.py
