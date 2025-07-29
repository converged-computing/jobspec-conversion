#!/bin/bash
#SBATCH --output=%x_%u_%j.out
#SBATCH --error=%x_%u_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=2000
#SBATCH --partition=mhigh,mhigh

python mlp_MIT_8_scene.py
