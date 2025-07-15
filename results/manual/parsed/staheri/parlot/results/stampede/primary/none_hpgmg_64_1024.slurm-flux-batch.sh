#!/bin/bash
#FLUX: --job-name=butterscotch-leader-9170
#FLUX: --urgency=16

export PATH='$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin'

export PATH=$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin
JOBB=none_hpgmg_64_1024
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun hpgmg-fv 4 1 > ../outputs/$JOBB.out
