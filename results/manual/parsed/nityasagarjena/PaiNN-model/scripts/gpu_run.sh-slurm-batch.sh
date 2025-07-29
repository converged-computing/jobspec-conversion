#!/bin/bash
#FLUX: --job-name=PaiNN-training
#FLUX: -n=8
#FLUX: --queue=sm3090
#FLUX: -t=604800
#FLUX: --urgency=16

export MKL_NUM_THREADS='1'
export NUMEXPR_NUM_THREADS='1'
export OMP_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='1'

export MKL_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
nvidia-smi > gpu_info
ulimit -s unlimited
python3 md_run.py
