#!/bin/bash
#FLUX: --job-name=lovable-peanut-0554
#FLUX: --priority=16

export PATH='$PATH:/home1/02309/staheri/apps/p4est-itac/bin'

export PATH=$PATH:/home1/02309/staheri/apps/p4est-itac/bin
module load itac
JOBB=itac_hpgmg_16_256
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun hpgmg-fv 4 1 > ../outputs/$JOBB.out
