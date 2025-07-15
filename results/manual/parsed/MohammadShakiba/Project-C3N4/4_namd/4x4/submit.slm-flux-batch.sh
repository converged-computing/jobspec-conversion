#!/bin/bash
#FLUX: --job-name=cowy-leader-0690
#FLUX: --queue=general-compute
#FLUX: -t=259200
#FLUX: --urgency=16

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST="$SLURM_JOB_NODELIST
echo "SLURM_NNODES="$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory="$SLURM_SUBMIT_DIR
python run_namd_1000_0.py
