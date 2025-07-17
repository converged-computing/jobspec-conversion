#!/bin/bash
#FLUX: --job-name=stanky-fork-5898
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

module load cuda/10
/modules/apps/cuda/10.1.243/samples/bin/x86_64/linux/release/deviceQuery
python3 ./interface.py
