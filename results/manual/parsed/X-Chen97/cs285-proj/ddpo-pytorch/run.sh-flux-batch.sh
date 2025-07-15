#!/bin/bash
#FLUX: --job-name=rl_test
#FLUX: -c=10
#FLUX: --queue=es1
#FLUX: -t=14400
#FLUX: --priority=16

echo current conda env is $CONDA_DEFAULT_ENV
echo "================"
echo current GPU condition is:
python gpu.py
echo available nCPU is:
nproc
echo "================"
echo start running:
accelerate launch scripts/train.py --config config/dgx.py:gender_equality
