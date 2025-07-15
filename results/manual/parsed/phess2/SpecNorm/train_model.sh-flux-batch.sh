#!/bin/bash
#FLUX: --job-name=train_spec_norm
#FLUX: -c=20
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --priority=16

source /etc/profile.d/modules.sh
module use /cm/shared/modulefiles
module add openmind/miniconda
source activate /om/user/rphess/conda_envs/pytorch_2_tv
which python3
python3 train.py --job_id $SLURM_ARRAY_TASK_ID \
                 --gpus 4 --num_workers 5 \
