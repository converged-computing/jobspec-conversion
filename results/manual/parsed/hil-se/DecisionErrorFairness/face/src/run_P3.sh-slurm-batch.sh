#!/bin/bash
#SBATCH --job-name=scut_face
#SBATCH --account=loop
#SBATCH --output=log/%J_%a.o
#SBATCH --error=log/%J_%a.e
#SBATCH --mail-user=zxyvse@rit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:4
#SBATCH --mem=40G
#SBATCH --time=1-00:00:00

spack unload -a
spack load /xi3pch3
spack load py-keras
python3 fb_main.py run P3
