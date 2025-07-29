#!/bin/bash
#SBATCH --error=slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=1
#SBATCH --time=00:10:00

export MY_APP_ENV='hpc_vub'
export NCCL_DEBUG='INFO'

ENV_NAME=ssl_dd
export MY_APP_ENV=hpc_vub
export NCCL_DEBUG=INFO
module load PyTorch-Lightning/1.7.7-foss-2022a-CUDA-11.7.0
module load Hydra/1.3.2-GCCcore-11.3.0
virtualenv --system-site-packages $ENV_NAME
source $ENV_NAME/bin/activate
python -m pip install --upgrade pip
python -m pip install -e .
chmod +x src/train.py
python ./src/train.py
deactivate
