#!/bin/bash
#FLUX: --job-name=lovable-bits-6976
#FLUX: -t=10800
#FLUX: --urgency=16

source /global/common/software/desi/users/adematti/cosmodesi_environment.sh main
PYTHONPATH=$PYTHONPATH:$HOME/LSS/py
srun /pscratch/sd/a/acarnero/codes/LSS/scripts/mock_tools/run1_AMTLmock_LSS_BGS_clus.sh $SLURM_ARRAY_TASK_ID
