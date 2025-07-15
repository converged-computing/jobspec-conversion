#!/bin/bash
#FLUX: --job-name=pusheena-cattywampus-2117
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_PROC_BIND='true'

export OMP_PROC_BIND=true
module load matlab
python triton_auto_run_RSTA.py $SLURM_ARRAY_TASK_ID $TMPDIR '../outputs/compare_run/'
