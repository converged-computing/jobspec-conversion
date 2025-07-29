#!/bin/bash
#SBATCH --job-name=en_train
#SBATCH --output=/private/home/%u/logs/%x.out
#SBATCH --error=/private/home/%u/logs/%x.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gpus-per-task=2
#SBATCH --mem=5GB
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=1,volta32gb

source /private/home/%u/.bashrc
conda deactivate
conda activate vlnce
module purge
module load cuda/10.1
module load cudnn/v7.6.5.32-cuda.10.1
module load NCCL/2.5.6-1-cuda.10.1
printenv | grep SLURM
set -x
srun -u \
python -u run.py \
    --exp-config vlnce_baselines/config/rxr_baselines/rxr_cma_en.yaml \
    --run-type train
