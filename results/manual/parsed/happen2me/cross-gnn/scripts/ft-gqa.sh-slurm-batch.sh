#!/bin/bash
#SBATCH --job-name=gqa
#SBATCH --output=runs/R-%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00

export TOKENIZERS_PARALLELISM='true'
export WANDB__SERVICE_WAIT='300'

hostname
which python
nvidia-smi
python -c "import torch; print('device_count:', torch.cuda.device_count())"
python -c "import torch_geometric; print('torch_geometric version:', torch_geometric.__version__)"
export TOKENIZERS_PARALLELISM=true
export WANDB__SERVICE_WAIT=300
python -u eval.py --config configs/gqa.yaml --config-profile test_gqa \
    --run-name test-gqa --model t5-gnn
