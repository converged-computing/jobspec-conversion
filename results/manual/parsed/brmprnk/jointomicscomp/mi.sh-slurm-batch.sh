#!/bin/bash
#SBATCH --job-name=mutualinfo
#SBATCH --mail-user=stavrosmakrodi
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=30000
#SBATCH --time=01:30:00
#SBATCH --partition=general
#SBATCH --qos=short

ml use /opt/insy/modulefiles;
ml load cuda/11.0;
ml load cudnn/11.0-8.0.3.33;
DATASET=$1;
NPERM=10000;
python src/PoE/kldivergence_parallel.py './configs/best-models/'$DATASET'_poe.yaml' $2;
