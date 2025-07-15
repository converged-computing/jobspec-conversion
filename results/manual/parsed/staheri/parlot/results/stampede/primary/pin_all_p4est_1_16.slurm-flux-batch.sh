#!/bin/bash
#FLUX: --job-name=wobbly-squidward-9604
#FLUX: --priority=16

export PATH='$PATH:/home1/02309/staheri/apps/p4est-install/bin'

export PATH=$PATH:/home1/02309/staheri/apps/pin-install/pin-3.0-76991-gcc-linux/
export PATH=$PATH:/home1/02309/staheri/apps/p4est-install/bin
mkdir -p $SCRATCH/results/pin_all_p4est_1_16
cd $SCRATCH/results/pin_all_p4est_1_16
time ibrun pin -t ../../DBGpin17allimages.so -- p4est_mesh unit 9 > ../outputs/pin_all_p4est_1_16.out
