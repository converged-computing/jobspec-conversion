#!/bin/bash
#FLUX: --job-name=letizias-job
#FLUX: -c=12
#FLUX: -t=43200
#FLUX: --priority=16

args="${@}"
module load daint-gpu
module load cray-python
srun -ul $HOME/miniconda3/envs/zioboia/bin/python wtf_9.py "${args}" -u
