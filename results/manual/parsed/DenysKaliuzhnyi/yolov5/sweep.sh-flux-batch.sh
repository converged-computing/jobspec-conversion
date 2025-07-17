#!/bin/bash
#FLUX: --job-name=train_monuseg
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

SWEEP_ID="5grn31dl"
module load any/python/3.8.3-conda
source env/bin/activate
wandb agent --project YOLOv5 --entity kaliuzhnyi --count 110 "$SWEEP_ID"
echo "DONE"
