#!/bin/bash
#FLUX: --job-name=dinosaur-pot-8973
#FLUX: --priority=16

export PATH='$PATH:$HOME/apps/valgrind/bin'

export PATH=$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin
export PATH=$PATH:$HOME/apps/valgrind/bin
module load vtune
JOBB=vtune_hpgmg_4_64
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun amplxe-cl -collect hotspots -result-dir "./$(hostname)"  hpgmg-fv 4 1 > ../outputs/$JOBB.out
