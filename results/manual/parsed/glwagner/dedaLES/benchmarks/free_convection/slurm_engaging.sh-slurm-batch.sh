#!/bin/bash
#FLUX: --job-name=merge
#FLUX: -N=2
#FLUX: --queue=sched_mit_hill
#FLUX: -t=7200
#FLUX: --urgency=16

. /home/glwagner/software/miniconda3/etc/profile.d/conda.sh
conda activate dedalus
analysis="freeconvection_nh64_nz64_Q1_bfreq22891_DNS"
mpiexec python3 merge.py $analysis
