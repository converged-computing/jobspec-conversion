#!/bin/bash
#FLUX: --job-name=visualization
#FLUX: --queue=debug
#FLUX: -t=504000
#FLUX: --urgency=16

export PROG='pvserver'

if [ X"$SLURM_STEP_ID" = "X" -a X"$SLURM_PROCID" = "X"0 ]
then
  echo "=========================================="
  echo "Date            = $(date)"
  echo "SLURM_JOB_ID    = $SLURM_JOB_ID"
  echo "Nodes Allocated = $SLURM_JOB_NUM_NODES"
  echo "=========================================="
fi
echo "Working Directory = $(pwd)"
cd $SLURM_SUBMIT_DIR
export PROG="pvserver"
module purge
module load paraview/5.11.0
srun $PROG
