#!/bin/bash
#SBATCH --job-name=pong_selfplay_batch21
#SBATCH --output=pong_job.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --partition=teaching

singularity run --nv /data/containers/msoe-tensorflow-20.07-tf2-py3.sif python3 reinforcement_selfplay.py
