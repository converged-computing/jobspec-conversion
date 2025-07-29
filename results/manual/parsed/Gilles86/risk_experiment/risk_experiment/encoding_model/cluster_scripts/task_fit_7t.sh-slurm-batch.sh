#!/bin/bash
#SBATCH --job-name=fit_nprf_7t_unsmoothed
#SBATCH --output=/home/gdehol/logs/task_fit_7t_%A-%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=96G
#SBATCH --time=00:10:00

export PARTICIPANT_LABEL='$(printf "%02d" $SLURM_ARRAY_TASK_ID)'

module load volta
module load nvidia/cuda11.2-cudnn8.1.0
. $HOME/init_conda.sh
export PARTICIPANT_LABEL=$(printf "%02d" $SLURM_ARRAY_TASK_ID)
source activate tf2-gpu
python $HOME/git/risk_experiment/risk_experiment/encoding_model/fit_task.py $PARTICIPANT_LABEL 7t2 --bids_folder /scratch/gdehol/ds-risk --denoise --natural_space
