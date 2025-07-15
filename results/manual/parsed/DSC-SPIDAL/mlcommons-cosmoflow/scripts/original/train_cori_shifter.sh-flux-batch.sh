#!/bin/bash
#FLUX: --job-name=peachy-salad-3691
#FLUX: --urgency=16

module load singularity tensorflow/2.8.0
singularity run \
    --nv $CONTAINERDIR/tensorflow-2.8.0.sif \
    --env=OMP_NUM_THREADS=32,KMP_BLOCKTIME=1,KMP_AFFINITY="granularity=fine,compact,1,0",HDF5_USE_FILE_LOCKING=FALSE
  train.py \
    --config=../configs/cosmo.yaml 
