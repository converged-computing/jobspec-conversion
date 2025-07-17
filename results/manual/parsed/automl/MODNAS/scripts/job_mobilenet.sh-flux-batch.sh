#!/bin/bash
#FLUX: --job-name=adorable-earthworm-4702
#FLUX: -c=32
#FLUX: --queue=<partition
#FLUX: -t=432000
#FLUX: --urgency=16

export PYTHONPATH='.'

export PYTHONPATH=.
python -m torch.distributed.launch --nproc_per_node=8 --use_env search_spaces/MobileNetV3/search/mobilenet_search_base.py --one_shot_opt reinmax --opt_strategy "simultaneous" --hpn_type meta --use_pretrained_hpn 
