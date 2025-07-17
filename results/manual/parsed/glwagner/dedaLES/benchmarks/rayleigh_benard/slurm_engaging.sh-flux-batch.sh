#!/bin/bash
#FLUX: --job-name=kerr1-CS
#FLUX: -N=2
#FLUX: --queue=sched_mit_hill
#FLUX: -t=43200
#FLUX: --urgency=16

. /home/glwagner/software/miniconda3/etc/profile.d/conda.sh
conda activate dedalus
run="1"
closure="ConstantSmagorinsky"
mpiexec python3 rayleigh_benard_kerr.py $run $closure >> kerr_CS_$run.out
