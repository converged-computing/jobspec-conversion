#!/bin/bash
#SBATCH --job-name=no_augment
#SBATCH --output=output_%a.out
#SBATCH --error=errors_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=30G
#SBATCH --time=09:00:00
#SBATCH --partition=gpu-nvlink,dgx-spa
#SBATCH --array=0-3

module load anaconda
module load cuda 
source activate w2v2
srun python -u /scratch/work/lunt1/wav2vec2-finetune/run_finetune.py \
--lang=fi \
--fold=$SLURM_ARRAY_TASK_ID \
