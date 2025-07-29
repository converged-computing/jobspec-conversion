#!/bin/bash
#SBATCH --job-name=BRATS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --time=1-06:00:00
#SBATCH --partition=gpu
#SBATCH --qos=normal
#SBATCH --array=0-4

export PATH='$HOME/miniconda/bin:$PATH'

epochs=50
nvidia-smi
export PATH="$HOME/miniconda/bin:$PATH"
source activate MONAI-BRATS
ulimit -n 2048
python brats_train.py --nfolds ${SLURM_ARRAY_TASK_COUNT} --fold ${SLURM_ARRAY_TASK_ID} --epochs $epochs
