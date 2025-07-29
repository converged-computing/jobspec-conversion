#!/bin/bash
#SBATCH --output=log.out
#SBATCH --error=log.err
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:00:00

source ~/.bashrc
echo "... loading module"
echo "... activating conda env ..."
conda activate tf-gpu
echo " ... running script ..."
NUM_PINGS=20 # number of times to check if gpu is in usage
WAIT_SECS=5  # wait time between pings
nohup python check-gpu-state.py $NUM_PINGS $WAIT_SECS &
python keras-script.py
