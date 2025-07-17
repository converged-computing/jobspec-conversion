#!/bin/bash
#FLUX: --job-name=stanky-hippo-7133
#FLUX: -N=5
#FLUX: -t=21600
#FLUX: --urgency=16

set -u
BATCH_START_TIME=$(date)
echo "[+] ------START TIME (ST): $BATCH_START_TIME------"
echo "Start cluster..."
module load tensorflow/intel-1.13.1-py36
./startCluster.sh & sleep 60 && module load tensorflow/intel-1.13.1-py36 && python test_ipyparallel.py ${1} ${2} ${3} ${4} & wait
BATCH_END_TIME=$(date)
echo "[+] ------END TIME (ET) $BATCH_END_TIME------"
