#!/bin/bash
#SBATCH --output=slurm_outputs_scripts/resnet_baselines_%a_%A.log
#SBATCH --mail-user=spandan_madan@g.harvard.edu
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=3-00:00:00
#SBATCH --array=0

eval "$(conda shell.bash hook)"
conda activate domain_adaptation
bash resnet_baseline_ids.sh ${SLURM_ARRAY_TASK_ID}
