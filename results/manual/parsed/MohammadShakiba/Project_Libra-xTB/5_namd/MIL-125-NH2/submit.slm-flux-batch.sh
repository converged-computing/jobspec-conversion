#!/bin/bash
#FLUX: --job-name=doopy-parsnip-2403
#FLUX: --queue=valhalla  --qos=valhalla
#FLUX: -t=432000
#FLUX: --priority=16

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST="$SLURM_JOB_NODELIST
echo "SLURM_NNODES="$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory="$SLURM_SUBMIT_DIR
python run_namd_80.py
