#!/bin/bash
#SBATCH --account=hpc2n2023-124
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=5-05:00:00

ml GCCcore/11.3.0 Python/3.10.4
source venv/bin/activate
python train.py configs/llama2_7b_chat_uncensored_original.yaml
