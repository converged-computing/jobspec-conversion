#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --gres=4
#SBATCH --mem-per-cpu=32G
#SBATCH --time=10:00:00
#SBATCH --qos=cs

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
mamba activate nhl_pred
python ~/NHL_Win_Predictor/xgboost_train.py
