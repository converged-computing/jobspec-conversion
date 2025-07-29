#!/bin/bash
#FLUX: --job-name=imagenet experiments
#FLUX: --queue=gpu
#FLUX: -t=129600
#FLUX: --urgency=16

python3 -m torch.distributed.launch \
    --nproc_per_node=2 \
    --use_env \
    --max_restarts 0 \
    --master_port 11112 \
    train.py loader.use_tfrecords=True val_loader.use_tfrecords=True +hydra_exp=$@
