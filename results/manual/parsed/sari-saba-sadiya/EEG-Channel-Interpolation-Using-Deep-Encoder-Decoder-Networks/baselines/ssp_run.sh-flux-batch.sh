#!/bin/bash
#FLUX: --job-name=chocolate-milkshake-7678
#FLUX: --exclusive
#FLUX: --queue=sched_mit_rgmark
#FLUX: -t=259200
#FLUX: --priority=16

. /etc/profile.d/modules.sh
module load python/3.6.3
module load cuda/8.0
module load cudnn/6.0
pip3 install --user virtualenv
virtualenv -p python3 venv
source venv/bin/activate
pip3 install -r baseline_req.txt
KERAS_BACKEND=tensorflow
python3 ecr_ssp.py $SLURM_ARRAY_TASK_ID
