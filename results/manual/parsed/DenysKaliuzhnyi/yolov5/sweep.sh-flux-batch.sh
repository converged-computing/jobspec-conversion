#!/bin/bash
#FLUX: --job-name=purple-citrus-4386
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: --priority=16

SWEEP_ID="5grn31dl"
module load any/python/3.8.3-conda
source env/bin/activate
wandb agent --project YOLOv5 --entity kaliuzhnyi --count 110 "$SWEEP_ID"
echo "DONE"
