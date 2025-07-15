#!/bin/bash
#FLUX: --job-name="FC0"
#FLUX: -N=4
#FLUX: --queue=sched_mit_hill
#FLUX: -t=14400
#FLUX: --priority=16

. /home/glwagner/software/miniconda3/etc/profile.d/conda.sh
conda activate dedalus
mpiexec python3 free_convection_example.py >> FC0.out
