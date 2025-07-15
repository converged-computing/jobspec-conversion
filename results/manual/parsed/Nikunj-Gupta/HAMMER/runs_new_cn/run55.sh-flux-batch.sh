#!/bin/bash
#FLUX: --job-name=84054
#FLUX: -c=16
#FLUX: -t=14400
#FLUX: --priority=16

source ../venvs/hammer/bin/activate
module load python/intel/3.8.6
module load openmpi/intel/4.0.5
time python3 hammer-run.py  --envname cn --config configs/cn.yaml --nagents 3 --dru_toggle 1 --meslen 2 --randomseed 84054
