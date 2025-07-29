#!/bin/bash
#SBATCH --job-name=dpo
#SBATCH --account=researchers
#SBATCH --output=run_outputs/dpo.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:a100_40gb:1
#SBATCH --time=3-00:00:00
#SBATCH --partition=brown,red

hostname
nvidia-smi
python -m src.social_llama.training.dpo
