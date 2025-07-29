#!/bin/bash
#FLUX: --job-name=snl_sbc
#FLUX: --queue=lu
#FLUX: -t=360000
#FLUX: --urgency=16

ml load GCC/8.3.0
ml load CUDA/10.1.243
ml load OpenMPI/3.1.4
ml load PyTorch/1.6.0-Python-3.7.4
python /home/samwiq/snpla/'seq-posterior-approx-w-nf-dev'/'hodgkin_huxley'/run_script_sbc_snl.py 1 10 snl 3
