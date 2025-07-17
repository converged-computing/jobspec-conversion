#!/bin/bash
#FLUX: --job-name=gaussian3Of4
#FLUX: -c=6
#FLUX: -t=14400
#FLUX: --urgency=16

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
LINE=$(sed -n "$((SLURM_ARRAY_TASK_ID))"p scripts/AllGaussianNoise.txt)
python3 Certify.py  $LINE 
