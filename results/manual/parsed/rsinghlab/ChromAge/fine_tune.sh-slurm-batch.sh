#!/bin/bash
#SBATCH --output=H3K4me3-post-process.out
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100G
#SBATCH --time=02:00:00

module load python/3.7.4
source ChromAge_venv/bin/activate
python3 /users/masif/data/masif/ChromAge/simple_nn.py
deactivate
