#!/bin/bash
#SBATCH --job-name=albedo_baseline_models
#SBATCH --account=dsi
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100gb

module load anaconda
python model.py > albedo_df_updated/XGboost_record.txt
