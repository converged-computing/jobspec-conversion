#!/bin/bash
#SBATCH --output=OUTPUTS/dst_sepsis-%j-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --array=1-140%140

echo $(tail -n+$SLURM_ARRAY_TASK_ID dst_exp_params.txt | head -n1)
cd ../scripts
python -u train_model.py $(tail -n+$SLURM_ARRAY_TASK_ID ../slurm_scripts/dst_exp_params.txt | head -n1)
