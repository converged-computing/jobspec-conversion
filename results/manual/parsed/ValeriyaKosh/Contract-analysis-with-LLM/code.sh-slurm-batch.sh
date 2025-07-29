#!/bin/bash
#SBATCH --output=trial1.%J.out
#SBATCH --error=trial1.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20GB
#SBATCH --time=00:25:00

module load model-huggingface/all
  # run python
srun python Contract-analysis-with-LLM/code.py
