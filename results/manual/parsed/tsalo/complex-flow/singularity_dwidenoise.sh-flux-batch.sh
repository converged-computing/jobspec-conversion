#!/bin/bash
#FLUX: --job-name=dwi
#FLUX: -c=4
#FLUX: --queue=centos7
#FLUX: --urgency=16

export NPROCS='`echo $LSB_HOSTS | wc -w`'
export OMP_NUM_THREADS='$NPROCS'

export NPROCS=`echo $LSB_HOSTS | wc -w`
export OMP_NUM_THREADS=$NPROCS
. $MODULESHOME/../global/profile.modules
module load singularity-3
source /home/data/nbc/nbclab-env/py3_environment
python test_dwidenoise.py
