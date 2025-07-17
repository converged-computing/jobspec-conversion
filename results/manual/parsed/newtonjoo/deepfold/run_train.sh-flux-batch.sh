#!/bin/bash
#FLUX: --job-name=train
#FLUX: --urgency=16

echo "train run"
log=./logs/train_log
rm -rf $log
touch $log
conda activate unifold
echo "Start `date`"
mpirun --oversubscribe -n $num_gpus python train.py 2>&1 | tee -a $log
echo "End `date`"
