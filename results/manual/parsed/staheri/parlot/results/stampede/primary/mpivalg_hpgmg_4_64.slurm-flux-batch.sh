#!/bin/bash
#FLUX: --job-name=mpivalg_hpgmg_4_64
#FLUX: -N=4
#FLUX: -n=64
#FLUX: --queue=normal
#FLUX: -t=600
#FLUX: --urgency=16

export PATH='$PATH:$HOME/apps/valgrind/bin'

export PATH=$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin
export PATH=$PATH:$HOME/apps/valgrind/bin
JOBB=mpivalg_hpgmg_4_64
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun valgrind --tool=callgrind hpgmg-fv 4 1 > ../outputs/$JOBB.out
