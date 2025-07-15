#!/bin/bash
#FLUX: --job-name="merge"
#FLUX: --queue=sched_mit_hill
#FLUX: -t=3600
#FLUX: --priority=16

. /home/glwagner/software/miniconda3/etc/profile.d/conda.sh
conda activate dedalus
analysis="freeconvection_nx256_ny256_nz256_F0p0000000001_Ninv300_DNS"
mpiexec python3 merge.py $analysis >> merge_$analysis.out
