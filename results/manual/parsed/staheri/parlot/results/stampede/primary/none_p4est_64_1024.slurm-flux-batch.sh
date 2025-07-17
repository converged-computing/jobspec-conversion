#!/bin/bash
#FLUX: --job-name=none_p4est_64_1024
#FLUX: -N=64
#FLUX: -n=1024
#FLUX: --queue=normal
#FLUX: -t=600
#FLUX: --urgency=16

export PATH='$PATH:/home1/02309/staheri/apps/p4est-install/bin'

export PATH=$PATH:/home1/02309/staheri/apps/p4est-install/bin
JOBB=none_p4est_64_1024
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun p4est_mesh unit 9 > ../outputs/$JOBB.out
