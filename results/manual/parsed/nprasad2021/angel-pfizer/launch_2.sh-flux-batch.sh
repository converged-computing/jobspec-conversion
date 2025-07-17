#!/bin/bash
#FLUX: --job-name=new_exp
#FLUX: -n=4
#FLUX: -t=10800
#FLUX: --urgency=16

PATH_ANGEL="/om/user/nprasad/angel-pfizer"
cd ..
singularity exec -B /om:/om --nv /om/user/nprasad/singularity/belledon-tensorflow-keras-master-latest.simg \
python /om/user/nprasad/angel-pfizer/main.py $PATH_ANGEL ${SLURM_ARRAY_TASK_ID}
