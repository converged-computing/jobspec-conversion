#!/bin/bash
#FLUX: --job-name=hanky-milkshake-1576
#FLUX: -N=2
#FLUX: -t=7200
#FLUX: --priority=16

source activate $1
 export NCCL_DEBUG=INFO
 export PYTHONFAULTHANDLER=1
srun python3 simple_image_classifier.py \
  --trainer.accelerator 'ddp' \
  --trainer.gpus 2 \
  --trainer.num_nodes 2 \
  --trainer.max_epochs 5
