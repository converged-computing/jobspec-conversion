#!/bin/bash
#FLUX: --job-name=debug
#FLUX: -c=2
#FLUX: --queue=unkillable
#FLUX: --priority=16

module load python/3.9 cuda/11.7 
source ~/venvs/gflownet/bin/activate
python ~/gflownet/src/gflownet/tasks/main.py
