#!/bin/bash
#SBATCH --job-name=imagenet experiments
#SBATCH --output=logs/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=2
#SBATCH --time=1-12:00:00

python3 -m torch.distributed.launch \
    --nproc_per_node=2 \
    --use_env \
    --max_restarts 0 \
    --master_port 11112 \
    train.py loader.use_tfrecords=True val_loader.use_tfrecords=True +hydra_exp=$@
