#!/bin/bash
#SBATCH --job-name=qb-bert
#SBATCH --account=scavenger
#SBATCH --output=/fs/www-users/entilzha/logs/%A.log
#SBATCH --error=/fs/www-users/entilzha/logs/%A.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=16g
#SBATCH --time=4-00:00:00
#SBATCH --qos=scavenger
#SBATCH --chdir=/fs/clip-quiz/entilzha/code/qb-bert/src
#SBATCH --exclude=materialgpu00

export SLURM_LOG_FILE='/fs/www-users/entilzha/logs/${SLURM_JOB_ID}.log'
export MODEL_CONFIG_FILE='$2'

set -x
hostname
nvidia-smi
source /fs/clip-quiz/entilzha/anaconda3/etc/profile.d/conda.sh > /dev/null 2> /dev/null
conda activate qb-bert
export SLURM_LOG_FILE="/fs/www-users/entilzha/logs/${SLURM_JOB_ID}.log"
export MODEL_CONFIG_FILE="$2"
cd $1
pwd
srun python qb/main.py train $2
