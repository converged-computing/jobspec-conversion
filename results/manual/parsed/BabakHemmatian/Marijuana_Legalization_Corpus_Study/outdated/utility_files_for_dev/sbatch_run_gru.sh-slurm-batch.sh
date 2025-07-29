#!/bin/bash
#SBATCH --job-name=train_gru
#SBATCH --account=carney-frankmj-condo
#SBATCH --output=/users/afengler/batch_job_out/train_gru_%A_%a.out
#SBATCH --mail-user=alexander_fengler@brown.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --gres=gpu:1
#SBATCH --mem=24G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=quadrortx
#SBATCH --array=0-3

source /users/afengler/.bashrc
conda deactivate
conda activate tf-gpu-py37
machine='ccv'
python gru_language_model.py --machine $machine  --idx $SLURM_ARRAY_TASK_ID
