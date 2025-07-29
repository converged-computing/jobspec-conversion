#!/bin/bash
#SBATCH --job-name=train_clay_v0.3.5
#SBATCH --output=model_train_%j.log
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=0
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export PYTHONUNBUFFERED='1'

eval "$(conda 'shell.bash' 'hook' 2> /dev/null)"
conda activate claymodel
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
export PYTHONUNBUFFERED=1
srun python trainer.py fit --model ClayMAEModule --data ClayDataModule --config configs/config.yaml --data.data_dir /fsx
