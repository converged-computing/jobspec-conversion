#!/bin/bash
#SBATCH --job-name=beam_collision_discriminator_trainer1
#SBATCH --output=output.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=24G
#SBATCH --time=02:10:00
#SBATCH --constraint=ntasks-per-node=1

python training.py
