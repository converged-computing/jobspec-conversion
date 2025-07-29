#!/bin/bash
#SBATCH --job-name=sft
#SBATCH --account=researchers
#SBATCH --output=run_outputs/sft.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:a100_40gb:1
#SBATCH --time=1-00:00:00

hostname
nvidia-smi
python -m src.social_llama.training.sft
