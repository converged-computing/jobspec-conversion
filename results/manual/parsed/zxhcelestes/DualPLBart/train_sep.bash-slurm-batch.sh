#!/bin/bash
#SBATCH --job-name=lijie
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=3-00:00:00
#SBATCH --partition=batch
#SBATCH --constraint=ntasks-per-node=1

nvidia-smi
python -u train_sep.py \
--code_lang java \
--gpu --model_name sep_model \
--save_dir result_models/sep_models \
--train_code_path data/dual_data/java/train/code.original \
--train_summ_path data/dual_data/java/train/javadoc.original
