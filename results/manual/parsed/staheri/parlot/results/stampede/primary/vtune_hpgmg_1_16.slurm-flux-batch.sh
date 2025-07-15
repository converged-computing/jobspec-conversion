#!/bin/bash
#FLUX: --job-name=goodbye-poodle-5313
#FLUX: --priority=16

export PATH='$PATH:$HOME/apps/valgrind/bin'

export PATH=$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin
export PATH=$PATH:$HOME/apps/valgrind/bin
module load vtune
JOBB=vtune_hpgmg_1_16
mkdir -p $SCRATCH/results/$JOBB
cd $SCRATCH/results/$JOBB
time ibrun amplxe-cl -collect hotspots -result-dir "./$(hostname)"  hpgmg-fv 4 1 > ../outputs/$JOBB.out
