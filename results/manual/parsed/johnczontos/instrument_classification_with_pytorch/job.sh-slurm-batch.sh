#!/bin/bash
#SBATCH --job-name=MIC
#SBATCH --account=soundbendor
#SBATCH --output=logs/run_model.out
#SBATCH --error=logs/run_model.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:6
#SBATCH --mem=128G
#SBATCH --time=1-00:00:00
#SBATCH --partition=soundbendor
#SBATCH --nodelist=cn-m-1

module load python/3.10 cuda/11.7 sox
source env/bin/activate
python run_model.py data/rwc_all/clean/split
