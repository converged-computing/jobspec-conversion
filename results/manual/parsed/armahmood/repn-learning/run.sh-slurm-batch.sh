#!/bin/bash
#SBATCH --job-name=repn_learning
#SBATCH --account=def-ashique
#SBATCH --output=repn_learning%A%a.out
#SBATCH --error=repn_learning%A%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000M
#SBATCH --time=01:10:00
#SBATCH --array=0-575

python learner_xrel.py --search --save_losses --cfg ./cfg_temp/$SLURM_ARRAY_TASK_ID.json
