#!/bin/bash
#FLUX: --job-name=chocolate-bicycle-5332
#FLUX: --priority=16

source new-modules.sh
module load python/2.7.11-fasrc01
source activate $VENV_NAME
RUNNING="python -u $PYTHON $SLURM_ARRAY_TASK_ID"
echo $RUNNING
time $RUNNING
exit 0;
