#!/bin/bash
#SBATCH --output=new_litllama.out
#SBATCH --error=new_litllama.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:8
#SBATCH --mem=480G
#SBATCH --time=05:30:00

module purge
source ~/.bashrc
conda activate llamaenv
python lit-llama/scripts/convert_checkpoint.py --checkpoint_dir "litllamadata/" --model_size 65B
