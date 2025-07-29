#!/bin/bash
#SBATCH --job-name=experiments
#SBATCH --output=run_outputs/prompt_augmentation.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=1-12:00:00

hostname
module load poetry
poetry shell
input_arg="$1"  # Capture the first command line argument
python -W ignore -m src.worker_vs_gpt.prompt_augmentation_hf "$input_arg"
