#!/bin/bash
#SBATCH --job-name=nianet-cae
#SBATCH --output=nianet-cae-%j.out
#SBATCH --error=nianet-cae-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=3-00:00:00

singularity exec -e --pwd /app -B $(pwd)/logs:/app/logs,$(pwd)/data:/app/data,$(pwd)/configs:/app/configs --nv docker://spartan300/nianet:cae python main.py
