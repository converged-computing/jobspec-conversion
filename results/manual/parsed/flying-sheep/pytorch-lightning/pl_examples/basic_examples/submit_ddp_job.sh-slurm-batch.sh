#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=0
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=2

source activate $1
 export NCCL_DEBUG=INFO
 export PYTHONFAULTHANDLER=1
srun python3 simple_image_classifier.py \
  --trainer.accelerator 'ddp' \
  --trainer.gpus 2 \
  --trainer.num_nodes 2 \
  --trainer.max_epochs 5
