#!/bin/bash
#SBATCH --job-name=output
#SBATCH --output=WGAN_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=06:00:00

nvidia-docker run -v /home/$USER:/home/$USER mustang/wgan:1.0 python -u ../home/mvenkataraman_ph/Face-Super-Resolution-Through-Wasserstein-GANs/main.py
