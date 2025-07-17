#!/bin/bash
#FLUX: --job-name=conspicuous-arm-2583
#FLUX: -N=5
#FLUX: -t=36000
#FLUX: --urgency=16

set -u
BATCH_START_TIME=$(date)
echo "[+] ------START TIME (ST): $BATCH_START_TIME------"
echo "Start cluster..."
module load tensorflow/intel-1.15.0-py37
./startCluster.sh & sleep 60 && module load tensorflow/intel-1.15.0-py37 && python test_ipyparallel.py ${1} ${2} ${3} ${4} & wait
BATCH_END_TIME=$(date)
echo "[+] ------END TIME (ET) $BATCH_END_TIME------"
