#!/bin/bash
#FLUX: --job-name=salted-fudge-1444
#FLUX: --priority=16

source activate pypeit2
cd /n/home03/vchandra/outerhalo/08_mage/pipeline/
echo 'CPU USED: ' 
cat /proc/cpuinfo | grep 'model name' | head -n 1
echo 'QUEUE NAME:' 
echo $SLURM_JOB_PARTITION
echo 'NODE NAME:' 
echo $SLURMD_NODENAME 
python -u radagast.py --dir=/n/holystore01/LABS/conroy_lab/Lab/vchandra/mage/data/2024_04_22/ --version=0  --skipred=False
