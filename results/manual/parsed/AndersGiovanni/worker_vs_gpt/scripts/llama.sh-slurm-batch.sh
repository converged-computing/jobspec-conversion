#!/bin/bash
#SBATCH --job-name=llama
#SBATCH --account=researchers
#SBATCH --output=run_outputs/llama.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:a100_40gb:4
#SBATCH --time=04:00:00

hostname
nvidia-smi
python -m src.worker_vs_gpt.llm_local
