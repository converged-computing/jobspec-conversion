#!/bin/bash
#FLUX: --job-name=lovable-muffin-4346
#FLUX: -n=128
#FLUX: --queue=RM
#FLUX: -t=7200
#FLUX: --urgency=16

cp -r $PROJECT/matrices $RAMDISK
module load intel/20.4
python3 run_epyc_mkl.py $RAMDISK
