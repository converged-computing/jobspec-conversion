#!/bin/bash
#SBATCH --job-name=rad-generate-dataset
#SBATCH --account=cs6501_sp24
#SBATCH --output=%u-%j-data.out
#SBATCH --error=%u-%j-data.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=256G
#SBATCH --time=3-00:00:00
#SBATCH --array=0-3

date
nvidia-smi
source env.sh
python generate_rad_dataset.py --id $SLURM_ARRAY_TASK_ID --alpha=100 --n 3000
