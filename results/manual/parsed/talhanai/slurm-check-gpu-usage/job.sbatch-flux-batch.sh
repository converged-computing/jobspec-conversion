#!/bin/bash
#FLUX: --job-name=goodbye-lizard-3990
#FLUX: --priority=16

source ~/.bashrc
echo "... loading module"
echo "... activating conda env ..."
conda activate tf-gpu
echo " ... running script ..."
NUM_PINGS=20 # number of times to check if gpu is in usage
WAIT_SECS=5  # wait time between pings
nohup python check-gpu-state.py $NUM_PINGS $WAIT_SECS &
python keras-script.py
