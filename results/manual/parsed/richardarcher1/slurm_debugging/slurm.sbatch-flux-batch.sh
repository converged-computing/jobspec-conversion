#!/bin/bash
#FLUX: --job-name=nvidia
#FLUX: --queue=gpu
#FLUX: -t=86700
#FLUX: --urgency=16

echo "SLURM_JOBID="$SLURM_JOBID
echo " "
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo " "
nvidia-smi
conda activate test_build_2point3
echo "==============================="
conda config --show channels
echo "==============================="
python test.py
