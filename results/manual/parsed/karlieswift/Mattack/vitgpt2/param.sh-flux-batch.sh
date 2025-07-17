#!/bin/bash
#FLUX: --job-name=pytorch
#FLUX: -n=4
#FLUX: --queue=normal
#FLUX: --urgency=16

python  -m torch.distributed.launch --nproc_per_node=4 ddp_train_coco.py 
