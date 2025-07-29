#!/bin/bash
#SBATCH --output=logs/wwi_%j.out
#SBATCH --error=logs/wwi_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --array=0-1000

python grid_ww_iter.py gridvals/
