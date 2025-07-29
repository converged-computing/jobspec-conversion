#!/bin/bash
#SBATCH --output=out/rle-mini-challenge-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:0
#SBATCH --time=06:00:00
#SBATCH --partition=performance

singularity pull docker://yanickschraner/rle-mini-challenge
singularity exec -B ${HOME}/rle-assginment:${HOME}/rle-assginment rle-mini-challenge_latest.sif ${HOME}/rle-assginment/dqn_example.py --mode train --nocuda --num_envs 16 --total_steps 10000000
