#!/bin/bash
#SBATCH --job-name=Inference
#SBATCH --output=preds/preds.out
#SBATCH --error=preds/preds.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00

export PATH='/opt/conda/bin:$PATH'

echo "Running on $(hostname)"
export PATH=/opt/conda/bin:$PATH
conda info --envs
source activate final_PGx_env
python ./BARTNER_adapted/predictor.py
