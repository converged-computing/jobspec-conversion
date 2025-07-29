#!/bin/bash
#SBATCH --job-name=1_qem_rooms_matterport
#SBATCH --output=output/1_qem_rooms_matterport_%A_%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --mem=6G
#SBATCH --time=14-00:00:00
#SBATCH --array=0-1000

cd ../../../
python3.7 graph_level_generation.py \
--in_path raw_data/matterport/v1/scans \
--out_path data/matterport/ \
--level_params 0.04 30 30 30 \
--train \
--qem \
--dataset matterport \
--number $((SLURM_ARRAY_TASK_ID))
