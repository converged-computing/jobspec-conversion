#!/bin/bash
#FLUX: --job-name=gassy-omelette-5099
#FLUX: --priority=16

ml load GCC/8.3.0
ml load CUDA/10.1.243
ml load OpenMPI/3.1.4
ml load PyTorch/1.6.0-Python-3.7.4
pwd
cd ..
pwd 
python /home/samwiq/snpla/seq-posterior-approx-w-nf-dev/hodgkin_huxley/run_script_snl.py 1 10 snl 9
