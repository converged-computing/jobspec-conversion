#!/bin/bash
#FLUX: --job-name=astute-mango-8699
#FLUX: -t=7200
#FLUX: --priority=16

export OMP_PROC_BIND='true'

export OMP_PROC_BIND=true
module load matlab
python triton_auto_run_RSTA.py $SLURM_ARRAY_TASK_ID $TMPDIR '../outputs/compare_run/'
