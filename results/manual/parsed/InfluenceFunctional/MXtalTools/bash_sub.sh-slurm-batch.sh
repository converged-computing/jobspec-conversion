#!/bin/bash
#SBATCH --mail-user=YOUR_EMAIL_ADDRESS
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=40000M
#SBATCH --time=04:00:00
#SBATCH --array=0-2

source activate YOUR_CONDA_ENV
python main.py --user YOUR_USERNAME --yaml_config /PATH_TO_EXPERIMENT_CONFIGS/experiment_$SLURM_ARRAY_TASK_ID.yaml  # runs experiment_0.yaml --> experiment_2.yaml
