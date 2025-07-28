#!/bin/bash
#FLUX: --job-name=purple-general-6387
#FLUX: -n=2
#FLUX: --queue=gpu
#FLUX: -t=950400
#FLUX: --urgency=16

filename=$1
mpirun -n 2 python $filename --mode=gpu     # I want two gpus
