#!/bin/bash
#SBATCH --job-name=instrument
#SBATCH --account=cascades
#SBATCH --output=logs/run_model.out
#SBATCH --error=logs/run_model.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem=124G
#SBATCH --time=3-00:00:00
#SBATCH --nodelist=cn-m-2

module load python/3.10 cuda/11.7 sox
cd /nfs/guille/eecs_research/soundbendor/zontosj/instrument_classification_with_pytorch
source env/bin/activate
python run_model.py data/rwc_all/clean/split
