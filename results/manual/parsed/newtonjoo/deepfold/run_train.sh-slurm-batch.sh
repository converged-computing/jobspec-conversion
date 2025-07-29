#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=logs/train.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

echo "train run"
log=./logs/train_log
rm -rf $log
touch $log
conda activate unifold
echo "Start `date`"
mpirun --oversubscribe -n $num_gpus python train.py 2>&1 | tee -a $log
echo "End `date`"
