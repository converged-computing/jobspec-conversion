#!/bin/bash
#SBATCH --account=<your_gpu_group>
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=10G
#SBATCH --time=12:00:00
#SBATCH --partition=maxwell

setpkgs -a tensorflow_0.11.0rc0
python fit-line.py
