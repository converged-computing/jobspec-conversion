#!/bin/bash
#SBATCH --mail-user=n_jaku01@uni-muenster.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1
#SBATCH --time=1-12:00:00
#SBATCH --partition=gpuhgx

module load palma/2021b
module load Singularity
module load CUDA/11.6.0
singularity run --nv --bind .:/code open3d.sif train_essen.py "$1"
