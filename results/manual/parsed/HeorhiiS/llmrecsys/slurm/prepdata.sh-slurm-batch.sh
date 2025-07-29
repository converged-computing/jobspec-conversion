#!/bin/bash
#SBATCH --output=prep65.out
#SBATCH --error=prep65.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:1
#SBATCH --mem=200G
#SBATCH --time=05:30:00
#SBATCH --partition=nvidia

module purge
source ~/.bashrc
conda activate llamaenv
python ../convert_llama_weights_to_hf.py \
    --input_dir ../weights_dir/ --model_size 65B --output_dir ../converted_checkpoints/65B
