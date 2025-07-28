#!/bin/bash
#FLUX: --job-name=mat2fem
#FLUX: -t=86400
#FLUX: --urgency=16

source /cluster/bin/jobsetup
module load matlab
module load python2
module load gcc
python mat2fem.py
