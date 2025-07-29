#!/bin/bash
#SBATCH --job-name=eval_image_unet_stack_prjs_150k
#SBATCH --output=eval_image_unet_stack_prjs_150k.out
#SBATCH --error=eval_image_unet_stack_prjs_150k.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla-smx2:1
#SBATCH --mem=10000
#SBATCH --partition=gpu

module load anaconda/3.6
source activate /opt/ohpc/pub/apps/pytorch_1.10_openmpi
module load cuda/10.0.130
module load gnu/5.4.0
module load mvapich2
module load matlab
python --version
srun python -u eval_unet_invivo_CommQSM.py
