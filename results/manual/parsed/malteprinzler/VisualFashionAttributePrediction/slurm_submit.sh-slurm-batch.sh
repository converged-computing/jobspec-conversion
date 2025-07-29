#!/bin/bash
#SBATCH --output=slurm_logs/out.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=5000
#SBATCH --constraint=ntasks-per-node=4

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

conda activate embedding
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun python3 train.py --gpus 4 --distributed_backend ddp --data_root /home/mprinzler/storage/iMaterialist --batch_size 16 $@
