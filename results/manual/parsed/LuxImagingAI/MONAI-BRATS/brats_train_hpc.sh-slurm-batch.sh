#!/bin/bash
#SBATCH --job-name=BRATS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --time=1-06:00:00
#SBATCH --partition=gpu
#SBATCH --qos=normal
#SBATCH --array=0-3

epochs=100
conda activate MONAI-BRATS
nvidia-smi
python brats_train.py --nfolds ${SLURM_ARRAY_TASK_COUNT} --fold ${SLURM_ARRAY_TASK_ID} --epochs $epochs
