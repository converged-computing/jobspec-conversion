#!/bin/bash
#FLUX: --job-name=table
#FLUX: --queue=amd
#FLUX: --urgency=16

cd /mnt/personal/sykorvo1/PPOthesis/ppo
python run_model.py --load_model BEST/gustySides/ep780_4to5
