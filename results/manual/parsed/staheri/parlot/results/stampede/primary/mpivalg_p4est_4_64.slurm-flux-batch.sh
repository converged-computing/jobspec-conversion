#!/bin/bash
#FLUX: --job-name=swampy-sundae-1346
#FLUX: --priority=16

export PATH='$PATH:$HOME/apps/valgrind/bin'

export PATH=$PATH:/home1/02309/staheri/apps/p4est-install/bin
export PATH=$PATH:$HOME/apps/valgrind/bin
JOBB=mpivalg_p4est_4_64
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun valgrind --tool=callgrind p4est_mesh unit 9 > ../outputs/$JOBB.out
