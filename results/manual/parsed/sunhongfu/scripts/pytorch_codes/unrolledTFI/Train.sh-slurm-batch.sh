#!/bin/bash
#SBATCH --job-name=train_unrolledTFI
#SBATCH --output=train_unrolledTFI.out
#SBATCH --error=train_unrolledTFI.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla-smx2:2
#SBATCH --mem=30000

module load anaconda/3.6
source activate /opt/ohpc/pub/apps/pytorch_1.10_openmpi
module load cuda/10.0.130
module load gnu/5.4.0
module load mvapich2
srun python -u train_QSM.py
