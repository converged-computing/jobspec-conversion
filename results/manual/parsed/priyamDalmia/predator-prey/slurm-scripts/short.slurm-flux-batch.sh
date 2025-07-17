#!/bin/bash
#FLUX: --job-name=grated-egg-7784
#FLUX: --queue=shortgpgpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load pytorch/1.5.1-python-3.7.4
python3 trainers/tprey.py
