#!/bin/bash
#FLUX: --job-name=joyous-hippo-3623
#FLUX: --queue=fge
#FLUX: -t=900
#FLUX: --priority=16

date
cd /scratch1/RDARCH/rda-goesstf/conus2/Code
MYPY=/scratch1/RDARCH/rda-goesstf/anaconda/bin/python
srun -n $SLURM_NTASKS $MYPY MAIN_TRAIN_and_SAVE_MODEL.py $1
date
