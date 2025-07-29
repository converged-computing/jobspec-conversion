#!/bin/bash
#SBATCH --output=slurm_outputs_scripts/set_1_50_%A_%a.log
#SBATCH --mail-user=spandan_madan@g.harvard.edu
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8000
#SBATCH --time=3-00:00:00
#SBATCH --partition=seas_gpu,gpu,cox
#SBATCH --array=0-5

eval "$(conda shell.bash hook)"
conda activate python_env1
bash set_resnet_diversity.sh ${SLURM_ARRAY_TASK_ID}
