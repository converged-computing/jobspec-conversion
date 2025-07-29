#!/bin/bash
#SBATCH --output=/mnt/qb/work/bethge/dziadzio08/projects/disco/slurm/hostname_%j.out
#SBATCH --error=/mnt/qb/work/bethge/dziadzio08/projects/disco/slurm/hostname_%j.err
#SBATCH --mail-user=sebastian.dziadzio@uni-tuebingen.de
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:1
#SBATCH --mem=100G
#SBATCH --time=9-00:00:00

export WANDB__SERVICE_WAIT='300'
export HYDRA_FULL_ERROR='1'

scontrol show job $SLURM_JOB_ID
additional_args="$@"
source $HOME/.bashrc
source $WORK/virtualenvs/disco/bin/activate
python -m pip install --upgrade pip setuptools
python -m pip install -r $HOME/disco/requirements.txt
python -m pip install -e $HOME/disco
export WANDB__SERVICE_WAIT=300
export HYDRA_FULL_ERROR=1
GPU_TYPE=$(nvidia-smi --query-gpu=gpu_name --format=csv,noheader)
echo "Detected GPU: $GPU_TYPE"
if [[ "$GPU_TYPE" == *"RTX 2080 Ti"* ]]; then
    echo "Installing PyTorch for CUDA 11.7 for NVIDIA 2080Ti"
    python -m pip install torch==2.0.1+cu117 torchvision==0.15.2+cu117 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu117
elif [[ "$GPU_TYPE" == *"A100"* ]]; then
    echo "Installing PyTorch with the latest compatible version for NVIDIA A100"
    python -m pip install torch torchvision torchaudio
else
    echo "GPU type not recognized. Installing default PyTorch version."
    python -m pip install torch torchvision torchaudio
fi
python $HOME/disco/disco/train_from_disk.py $additional_args
