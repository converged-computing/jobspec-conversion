#!/bin/bash
#FLUX: --job-name=two_stream
#FLUX: -c=20
#FLUX: --queue=gpu
#FLUX: -t=18000
#FLUX: --urgency=16

source scripts/great_lakes/init.source
python -u scripts/run_model.py --use-visual --two-stream --train --gpus 1 --num-workers 4 --batch-size 64 "$*"
