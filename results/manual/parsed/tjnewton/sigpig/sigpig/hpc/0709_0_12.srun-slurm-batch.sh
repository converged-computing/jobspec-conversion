#!/bin/bash
#FLUX: --job-name=0709_0_12
#FLUX: --queue=amt
#FLUX: -t=1728000
#FLUX: --urgency=16

module load tensorflow
python3 time_miner.py 2018-07-09T00:01:10.0Z 2018-07-09T12:00:00.0Z
