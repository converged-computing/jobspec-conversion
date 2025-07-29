#!/bin/bash
#SBATCH --output=log/cnn_regression_multi_starts-%a.out
#SBATCH --error=log/cnn_regression_multi_starts-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=8G
#SBATCH --partition=gpu
#SBATCH --array=1-20%3

eval $(spack load --sh miniconda3)
source activate active-learning
dirname=ModelFitting/CNN_Reg/"${SLURM_ARRAY_TASK_ID}"
mkdir -p $dirname
python3 src/cnn_regression_random_start.py "${SLURM_ARRAY_TASK_ID}" "${dirname}"
