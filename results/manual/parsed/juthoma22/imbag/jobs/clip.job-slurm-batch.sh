#!/bin/bash
#SBATCH --job-name=clip-gpu-country
#SBATCH --output=outputs/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --time=2-23:59:59

module load singularity
singularity run --nv --bind /home/data_shares/geocv:/home/data_shares/geocv /opt/itu/containers/pytorch/latest python src/ImbagClip.py separate 3
