#!/bin/bash
#FLUX: --job-name=blank-avocado-4594
#FLUX: --urgency=16

echo "train run"
log=./logs/train_log
rm -rf $log
touch $log
conda activate unifold
echo "Start `date`"
mpirun --oversubscribe -n $num_gpus python train.py 2>&1 | tee -a $log
echo "End `date`"
