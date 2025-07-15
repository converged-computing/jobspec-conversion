#!/bin/bash
#FLUX: --job-name=pl-run
#FLUX: -c=6
#FLUX: -t=3600
#FLUX: --priority=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun \
  python3 run_ec.py fit\
  --model ../configs/ef/model.yml \
  --trainer ../configs/ef/train.yml \
  --data ../configs/ef/data.yml \
  $@
