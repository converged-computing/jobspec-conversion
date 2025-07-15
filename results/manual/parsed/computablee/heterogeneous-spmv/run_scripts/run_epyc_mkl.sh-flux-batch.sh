#!/bin/bash
#FLUX: --job-name=carnivorous-kitty-4411
#FLUX: --urgency=16

cp -r $PROJECT/matrices $RAMDISK
module load intel/20.4
python3 run_epyc_mkl.py $RAMDISK
