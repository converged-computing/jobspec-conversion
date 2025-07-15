#!/bin/bash
#FLUX: --job-name=pygpu
#FLUX: --queue=c18g
#FLUX: -t=28800
#FLUX: --priority=16

echo "------------------------------------------------------------"
echo "SLURM JOB ID: $SLURM_JOBID"
echo "Running on nodes: $SLURM_NODELIST"
echo "------------------------------------------------------------"
module purge
cd ~/multistablesde/
./slurm/$1 ~/artifacts/${SLURM_ARRAY_JOB_ID}_$1/${SLURM_ARRAY_TASK_ID}/
