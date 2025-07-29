#!/bin/bash
#FLUX: --job-name=Model_A
#FLUX: -N=3
#FLUX: -t=1740
#FLUX: --urgency=16

set -u
BATCH_START_TIME=$(date)
echo "[+] ------START TIME (ST): $BATCH_START_TIME------"
echo "Start cluster..."
module load tensorflow/intel-1.13.1-py36
./startCluster.sh & sleep 60 && module load tensorflow/intel-1.13.1-py36 && python test_ipyparallel.py ${1} ${2} & wait
BATCH_END_TIME=$(date)
echo "[+] ------END TIME (ET) $BATCH_END_TIME------"
