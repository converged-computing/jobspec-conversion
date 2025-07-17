#!/bin/bash
#FLUX: --job-name=salted-hippo-8326
#FLUX: -N=3
#FLUX: --queue=valhalla
#FLUX: -t=7200
#FLUX: --urgency=16

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST="$SLURM_JOB_NODELIST
echo "SLURM_NNODES="$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory="$SLURM_SUBMIT_DIR
python test.py 
