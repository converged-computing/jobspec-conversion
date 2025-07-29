#!/bin/bash
#SBATCH --job-name=Model_A
#SBATCH --mail-user=gmuszynski@lbl.gov
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:29:00
#SBATCH --qos=premium
#SBATCH --constraint=haswell

set -u
BATCH_START_TIME=$(date)
echo "[+] ------START TIME (ST): $BATCH_START_TIME------"
echo "Start cluster..."
module load tensorflow/intel-1.13.1-py36
./startCluster.sh & sleep 60 && module load tensorflow/intel-1.13.1-py36 && python test_ipyparallel.py ${1} ${2} & wait
BATCH_END_TIME=$(date)
echo "[+] ------END TIME (ET) $BATCH_END_TIME------"
