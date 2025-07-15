#!/bin/bash
#FLUX: --job-name=affine1Of4
#FLUX: -c=6
#FLUX: -t=7200
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
LINE=$(sed -n "$((SLURM_ARRAY_TASK_ID))"p scripts/AllAffine.txt)
python3 Certify.py  $LINE 
