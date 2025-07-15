#!/bin/bash
#FLUX: --job-name=sample_ind
#FLUX: -c=4
#FLUX: --queue=amd
#FLUX: -t=3600
#FLUX: --priority=16

module load python
python3 ./src/empirical/indstock_new.py
