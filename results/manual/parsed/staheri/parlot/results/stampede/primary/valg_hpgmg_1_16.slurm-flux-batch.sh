#!/bin/bash
#FLUX: --job-name=valg_hpgmg_1_16
#FLUX: -n=16
#FLUX: --queue=normal
#FLUX: -t=600
#FLUX: --urgency=16

export PATH='$PATH:$HOME/apps/valgrind/bin'

export PATH=$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin
export PATH=$PATH:$HOME/apps/valgrind/bin
JOBB=valg_hpgmg_1_16
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time valgrind --tool=callgrind ibrun hpgmg-fv 4 1 > ../outputs/$JOBB.out
