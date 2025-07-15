#!/bin/bash
#FLUX: --job-name=bricky-squidward-5669
#FLUX: --urgency=16

module load cuda/10
/modules/apps/cuda/10.1.243/samples/bin/x86_64/linux/release/deviceQuery
python3 ./interface.py
