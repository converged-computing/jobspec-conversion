#!/bin/bash
#SBATCH --job-name=openpsg
#SBATCH --output=/scratch/users/%u/logs/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --gres=gpu:4
#SBATCH --mem=262144
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=4

export PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:128'

source ~/.bashrc
module load cuda
nvidia-smi -i $CUDA_VISIBLE_DEVICES
nvcc --version
CONFIG=$1
GPUS=4
PORT=$(shuf -i 10000-65535 -n 1)
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:128
PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
EVAL_PAN_RELS=False \
python -m torch.distributed.launch \
  --nproc_per_node=$GPUS \
  --master_port=$PORT \
  tools/train.py \
  $CONFIG \
  --auto-resume \
  --no-validate \
  --seed 666 \
  --launcher pytorch
