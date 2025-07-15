#!/bin/bash
#FLUX: --job-name=dirty-fork-0373
#FLUX: --priority=16

export NPROCS='`echo $LSB_HOSTS | wc -w`'
export OMP_NUM_THREADS='$NPROCS'

export NPROCS=`echo $LSB_HOSTS | wc -w`
export OMP_NUM_THREADS=$NPROCS
. $MODULESHOME/../global/profile.modules
module load singularity-3
source /home/data/nbc/nbclab-env/py3_environment
python test_dwidenoise.py
