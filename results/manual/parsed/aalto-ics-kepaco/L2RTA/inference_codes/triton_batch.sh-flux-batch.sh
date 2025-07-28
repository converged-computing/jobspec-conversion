#!/bin/bash
#FLUX: --job-name=hairy-despacito-1216
#FLUX: --queue=short
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_PROC_BIND='true'

export OMP_PROC_BIND=true
module load matlab
python triton_auto_run_RSTA.py $SLURM_ARRAY_TASK_ID $TMPDIR '../outputs/compare_run/'
