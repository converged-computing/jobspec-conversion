#!/bin/bash
#FLUX: --job-name=biz_ddp
#FLUX: -t=360000
#FLUX: --urgency=16

module load cuda
python tokenizer_train.py hparams/tokenizer.yaml
python -m torch.distributed.launch --nproc_per_node=4 train.py hparams/train_ddp.yaml --distributed_launch --distributed_backend='nccl'
