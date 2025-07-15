#!/bin/bash
#FLUX: --job-name=exampleJob
#FLUX: -c=4
#FLUX: -t=10800
#FLUX: --priority=16

module load gcc
echo "######################### SLURM JOB ########################"
echo HOST NAME
echo `hostname`
echo "############################################################"
environment=CertifyingPointClouds
conda_root=$HOME/anaconda3
source $conda_root/etc/profile.d/conda.sh
conda activate $environment
set -ex
LINE=$(sed -n "$((SLURM_ARRAY_TASK_ID))"p scripts/CurvePoint.txt)
python3 Certify.py  $LINE 
