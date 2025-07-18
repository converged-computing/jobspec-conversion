#!/bin/bash
#FLUX: --job-name=swirl_001
#FLUX: -N=2
#FLUX: -n=4
#FLUX: -t=600
#FLUX: --urgency=16

srun --mpi=pmix_v2 swirl \
     --user:cuda=T \
     --cudaclaw:mthlim="1" \
     --cudaclaw:order="2 2" \
     --clawpack46:mthlim="1" \
     --clawpack46:order="1 0" \
     --nout=100
