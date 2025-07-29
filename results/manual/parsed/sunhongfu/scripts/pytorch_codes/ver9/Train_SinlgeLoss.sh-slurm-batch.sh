#!/bin/bash
#SBATCH --job-name=yang_2L30EPO_pytorch
#SBATCH --error=ResNet_error.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla-smx2:2
#SBATCH --mem=50000
#SBATCH --partition=gpu

module load anaconda/3.6
source activate /opt/ohpc/pub/apps/pytorch_1.10_openmpi
module load cuda/10.0.130
module load gnu/5.4.0
module load mvapich2
python --version
srun python -u Train_D_Unet_singleLoss.py
