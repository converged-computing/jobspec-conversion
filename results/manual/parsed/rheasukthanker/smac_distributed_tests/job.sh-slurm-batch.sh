#!/bin/bash
#SBATCH --job-name=fairnas
#SBATCH --output=logs/%j.%x.%N.out
#SBATCH --error=logs/%j.%x.%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=6-00:00:00
#SBATCH --partition=mldlc_gpu-rtx2080

python src/search/search_dask.py
