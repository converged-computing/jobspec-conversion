#!/bin/bash
#FLUX: --job-name=pin_main_hpgmg_4_64
#FLUX: -N=4
#FLUX: -n=64
#FLUX: --queue=normal
#FLUX: -t=600
#FLUX: --urgency=16

export PATH='$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin'

export PATH=$PATH:/home1/02309/staheri/apps/pin-install/pin-3.0-76991-gcc-linux/
export PATH=$PATH:/home1/02309/staheri/apps/hpgmg-original/build/bin
mkdir -p $SCRATCH/results/pin_main_hpgmg_4_64
cd $SCRATCH/results/pin_main_hpgmg_4_64
time ibrun pin -t ../../DBGpin17mainimage.so -- hpgmg-fv 4 1 > ../outputs/pin_main_hpgmg_4_64.out
