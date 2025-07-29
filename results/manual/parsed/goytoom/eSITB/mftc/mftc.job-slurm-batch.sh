#!/bin/bash
#SBATCH --job-name=mClassifier
#SBATCH --account=mdehghan_709
#SBATCH --output=../logs/mClassifier_%j.out
#SBATCH --error=../logs/mClassifier_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=03:00:00
#SBATCH --partition=gpu
#SBATCH --array=3-3

module purge
module restore selfharm
source ../../reddit/bin/activate
srun python moral_classifier.py ${SLURM_ARRAY_TASK_ID}
