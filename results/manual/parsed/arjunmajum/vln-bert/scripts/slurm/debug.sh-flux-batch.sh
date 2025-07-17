#!/bin/bash
#FLUX: --job-name=debug
#FLUX: --queue=short
#FLUX: --urgency=16

python \
-m torch.distributed.launch \
--nproc_per_node=8 \
--nnodes=1 \
--node_rank=0 \
train.py \
--from_pretrained data/models/pytorch_model_9.bin \
--save_name testing \
--num_workers 0 \
--debug
