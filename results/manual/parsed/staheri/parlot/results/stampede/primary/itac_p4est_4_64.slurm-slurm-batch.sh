#!/bin/bash
#FLUX: --job-name=itac_p4est_4_64
#FLUX: -N=4
#FLUX: -n=64
#FLUX: --queue=normal
#FLUX: -t=600
#FLUX: --urgency=16

export PATH='$PATH:/home1/02309/staheri/apps/p4est-itac/bin'

export PATH=$PATH:/home1/02309/staheri/apps/p4est-itac/bin
module load itac
JOBB=itac_p4est_4_64
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun p4est_mesh unit 9 > ../outputs/$JOBB.out
