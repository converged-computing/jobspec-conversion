#!/bin/bash
#FLUX: --job-name=cowy-malarkey-5215
#FLUX: -t=10800
#FLUX: --priority=16

source /global/common/software/desi/users/adematti/cosmodesi_environment.sh main
PYTHONPATH=$PYTHONPATH:$HOME/LSS/py
srun /pscratch/sd/a/acarnero/codes/LSS/scripts/mock_tools/run1_AMTLmock_LSS_BGS_clus.sh $SLURM_ARRAY_TASK_ID
