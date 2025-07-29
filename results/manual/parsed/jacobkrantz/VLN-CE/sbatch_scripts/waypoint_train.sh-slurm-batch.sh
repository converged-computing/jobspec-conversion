#!/bin/bash
#SBATCH --job-name=waypoint_train
#SBATCH --output=/private/home/%u/logs/%x.out
#SBATCH --error=/private/home/%u/logs/%x.err
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gpus-per-task=1
#SBATCH --mem=5GB
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=8

source /private/home/%u/.bashrc
conda deactivate
conda activate vlnce
MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
export MASTER_ADDR
module purge
module load cuda/10.1
module load cudnn/v7.6.5.32-cuda.10.1
module load NCCL/2.5.6-1-cuda.10.1
printenv | grep SLURM
set -x
srun -u \
python -u run.py \
    --exp-config vlnce_baselines/config/r2r_waypoint/2-wpn-dc.yaml \
    --run-type train
