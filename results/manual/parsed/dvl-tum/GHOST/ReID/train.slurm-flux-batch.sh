#!/bin/bash
#FLUX: --job-name=ResNetBackbonesAllReID
#FLUX: --queue=DEADLINE
#FLUX: -t=144000
#FLUX: --priority=16

source activate allreid_tv
python tools/train.py
