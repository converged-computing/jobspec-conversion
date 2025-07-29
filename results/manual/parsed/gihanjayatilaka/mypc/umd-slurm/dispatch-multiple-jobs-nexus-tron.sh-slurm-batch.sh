#!/bin/bash
#SBATCH --job-name=pytorchjob
#SBATCH --account=nexus
#SBATCH --output=/vulcanscratch/gihan/umd-slurm/logs/outFile-%A_%a.txt
#SBATCH --error=/vulcanscratch/gihan/umd-slurm/logs/errorFile-%A_%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:rtxa6000:1
#SBATCH --mem=32gb
#SBATCH --time=06:00:00
#SBATCH --partition=tron
#SBATCH --qos=high
#SBATCH --array=9-16

export TORCH_HOME='/vulcanscratch/gihan/torch-hub/'

CONDA_ENV_NAME="longtails"
DIRECTORY="/vulcanscratch/gihan/long-tails/"
source ~/.bashrc
export TORCH_HOME=/vulcanscratch/gihan/torch-hub/
conda activate $CONDA_ENV_NAME
cd $DIRECTORY
sed -n "${SLURM_ARRAY_TASK_ID}p" < /vulcanscratch/gihan/umd-slurm/list-of-commands.sh
sed -n "${SLURM_ARRAY_TASK_ID}p" < /vulcanscratch/gihan/umd-slurm/list-of-commands.sh >&2
echo "------"
echo "------" >&2
eval $(sed -n "${SLURM_ARRAY_TASK_ID}p" < /vulcanscratch/gihan/umd-slurm/list-of-commands.sh)
echo "END of SLURM commands"
echo "END of SLURM commands" >&2
