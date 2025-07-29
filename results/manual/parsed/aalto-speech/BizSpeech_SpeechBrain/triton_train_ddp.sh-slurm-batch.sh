#!/bin/bash
#SBATCH --job-name=biz_ddp
#SBATCH --account=dgx-spa
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --mem=16GB
#SBATCH --time=4-04:00:00
#SBATCH --partition=dgx-spa

module load cuda
python tokenizer_train.py hparams/tokenizer.yaml
python -m torch.distributed.launch --nproc_per_node=4 train.py hparams/train_ddp.yaml --distributed_launch --distributed_backend='nccl'
