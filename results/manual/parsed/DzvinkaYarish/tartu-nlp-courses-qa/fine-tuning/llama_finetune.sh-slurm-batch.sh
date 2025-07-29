#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100-40g
#SBATCH --mem=32G
#SBATCH --time=2-18:40:00
#SBATCH --partition=gpu

module load cuda/11.7.0
module load any/python/3.8.3-conda
conda activate nlp
ROOT=/gpfs/space/projects/stud_ml_22/NLP
RUN_NAME=a100_longer_training_vicuna
nvidia-smi
gcc --version
python3.10 llama_finetune.py --output_dir $ROOT/experiments/$RUN_NAME --run_name $RUN_NAME --bf16
