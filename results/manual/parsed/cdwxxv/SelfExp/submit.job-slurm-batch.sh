#!/bin/bash
#SBATCH --job-name=train.job
#SBATCH --output=/home/yuhewang/projects/SelfExp/results/temp_out-%j.txt
#SBATCH --error=/home/yuhewang/projects/SelfExp/results/temp_err-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=50000
#SBATCH --time=2-00:00:00
#SBATCH --nodelist=ai05

export TOKENIZERS_PARALLELISM='false'

nvidia-smi
                        #  --accelerator ddp
export TOKENIZERS_PARALLELISM=false
/cm/local/apps/python37/bin/python3.7  model/infer_model.py --ckpt ckpt/model_top10_debugged_retrained.ckpt \
                         --concept_map data/emotions_idx.json \
                         --dev_file data/dev_with_parse.json \
                         --paths_output_loc data/dev_output_emotions.csv
