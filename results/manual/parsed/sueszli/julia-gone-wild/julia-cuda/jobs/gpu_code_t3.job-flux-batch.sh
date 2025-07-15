#!/bin/bash
#FLUX: --job-name=red-lettuce-3017
#FLUX: --priority=16

. vars_in.sh
BINARY="../src/juliaset_gpu"
BSIZE_X_LIST=(1 32  1 128 1024)
BSIZE_Y_LIST=(1  1 32 1   1)
BSIZE_LEN=${#BSIZE_X_LIST[@]}
SIZE=20000
for (( i=0; i<${BSIZE_LEN}; i++ )); 
do
  BSIZE_X=${BSIZE_X_LIST[$i]}
  BSIZE_Y=${BSIZE_Y_LIST[$i]}
  $BINARY -r $SIZE $SIZE -b $BSIZE_X $BSIZE_Y -n $NREP -o "task3_${BSIZE_X}_${BSIZE_Y}.csv"
done    
