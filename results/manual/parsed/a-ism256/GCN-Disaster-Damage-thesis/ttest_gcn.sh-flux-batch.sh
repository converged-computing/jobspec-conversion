#!/bin/bash
#FLUX: --job-name=ttestgcn
#FLUX: --queue=msfea-ai
#FLUX: --urgency=16

module purge
module load python/3.8.2
module load torch/1.7.1-py38-gcc-7.2.0-cuda-10.1-openmpi-4.0.1
module load cuda
python3 ttest_gcn.py
