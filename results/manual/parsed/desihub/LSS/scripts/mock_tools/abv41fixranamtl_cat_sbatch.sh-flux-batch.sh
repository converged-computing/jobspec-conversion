#!/bin/bash
#FLUX: --job-name=reclusive-egg-4574
#FLUX: -t=1800
#FLUX: --urgency=16

source /global/common/software/desi/users/adematti/cosmodesi_environment.sh main
PYTHONPATH=$PYTHONPATH:$HOME/LSS/py
srun scripts/mock_tools/run1_AMTLmock_LSS_v4_1fixran.sh $SLURM_ARRAY_TASK_ID
