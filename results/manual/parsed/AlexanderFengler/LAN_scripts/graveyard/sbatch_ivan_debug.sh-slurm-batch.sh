#!/bin/bash
#SBATCH --job-name=ivan_debug
#SBATCH --account=carney-frankmj-condo
#SBATCH --output=/users/afengler/batch_job_out/ivan_debug_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=32G
#SBATCH --time=18:00:00
#SBATCH --array=0-2

source /users/afengler/.bashrc
module load cudnn/8.1.0
module load cuda/11.1.1
module load gcc/10.2
conda deactivate
conda deactivate
conda activate lanfactory
python -u ivan_debug.py
