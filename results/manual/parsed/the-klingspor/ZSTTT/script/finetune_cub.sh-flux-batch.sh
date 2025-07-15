#!/bin/bash
#FLUX: --job-name=nerdy-citrus-9960
#FLUX: -c=8
#FLUX: --queue=gpu-2080ti
#FLUX: -t=259200
#FLUX: --urgency=16

python /mnt/qb/work/akata/jstrueber72/ZSTTT/finetune_backbone.py --log_online --group finetune_resnet50_50_50_split --outname finetune --project zsttt --epochs 90 --learning_rate 1e-4 --save_model --save_valid
