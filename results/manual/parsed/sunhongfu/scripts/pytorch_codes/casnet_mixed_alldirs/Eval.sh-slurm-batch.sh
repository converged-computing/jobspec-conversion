#!/bin/bash
#SBATCH --job-name=eval_casnet_mixed_alldirs
#SBATCH --output=eval_casnet_mixed_alldirs.out
#SBATCH --error=eval_casnet_mixed_alldirs.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:tesla-smx2:1
#SBATCH --mem=100000
#SBATCH --partition=gpu

module load anaconda/3.6
source activate /opt/ohpc/pub/apps/pytorch_1.10_openmpi
module load cuda/10.0.130
module load gnu/5.4.0
module load mvapich2
module load matlab
python --version
srun python -u eval_QSM.py
