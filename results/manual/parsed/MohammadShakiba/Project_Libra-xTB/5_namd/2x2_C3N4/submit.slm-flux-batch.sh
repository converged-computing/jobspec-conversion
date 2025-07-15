#!/bin/bash
#FLUX: --job-name=eccentric-blackbean-3384
#FLUX: --queue=valhalla
#FLUX: -t=432000
#FLUX: --urgency=16

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST="$SLURM_JOB_NODELIST
echo "SLURM_NNODES="$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory="$SLURM_SUBMIT_DIR
python run_namd_100.py
