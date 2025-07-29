#!/bin/bash
#FLUX: --job-name=0709_12_23
#FLUX: --queue=amt
#FLUX: -t=1728000
#FLUX: --urgency=16

module load tensorflow
python3 time_miner.py 2018-07-09T12:00:00.0Z 2018-07-09T23:59:00.0Z
