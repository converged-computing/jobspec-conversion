#!/bin/bash
#FLUX: --job-name=boopy-salad-2936
#FLUX: --priority=16

export PATH='$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin'

export PATH=$PATH:/home1/02309/staheri/apps/pin-install/pin-3.0-76991-gcc-linux/
export PATH=$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin
mkdir -p $SCRATCH/results/pin_all_hpgmg_64_1024
cd $SCRATCH/results/pin_all_hpgmg_64_1024
time ibrun pin -t ../../DBGpin17allimages.so -- hpgmg-fv 4 1 > ../outputs/pin_all_hpgmg_64_1024.out
