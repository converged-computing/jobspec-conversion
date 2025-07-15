#!/bin/bash
#FLUX: --job-name=misunderstood-nunchucks-4413
#FLUX: --priority=16

. vars_in.sh
BINARY="../src/juliaset_gpu"
BSIZE_X=32
BSIZE_Y=1
for SIZE in "${SIZE_LIST[@]}"
do 
  $BINARY -r $SIZE $SIZE -b $BSIZE_X $BSIZE_Y -n $NREP -o "task4_gpu_${SIZE}.csv"
done
