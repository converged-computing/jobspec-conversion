#!/bin/bash
#FLUX: --job-name=arid-platanos-6060
#FLUX: --queue=longgpgpu
#FLUX: -t=2592000
#FLUX: --priority=16

module purge
module load gcc/8.3.0 fosscuda/2019b
module load pytorch/1.5.1-python-3.7.4
module load tensorflow-probability/0.9.0-python-3.7.4
nvidia-smi >nvidia-smi.txt
python3 ./tests/tpred.py 10
