#!/bin/bash
#FLUX: --job-name=gloopy-cinnamonbun-4929
#FLUX: --priority=16

cp -r $PROJECT/matrices $RAMDISK
module load intel/20.4
python3 run_epyc_mkl.py $RAMDISK
