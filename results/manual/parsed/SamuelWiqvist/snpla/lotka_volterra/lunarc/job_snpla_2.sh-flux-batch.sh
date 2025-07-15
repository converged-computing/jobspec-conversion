#!/bin/bash
#FLUX: --job-name=red-cat-6530
#FLUX: --priority=16

ml load GCC/8.3.0
ml load CUDA/10.1.243
ml load OpenMPI/3.1.4
ml load PyTorch/1.6.0-Python-3.7.4
python /home/samwiq/snpla/'seq-posterior-approx-w-nf-dev'/'lotka_volterra'/run_script_snpla.py 1 11 2 0
