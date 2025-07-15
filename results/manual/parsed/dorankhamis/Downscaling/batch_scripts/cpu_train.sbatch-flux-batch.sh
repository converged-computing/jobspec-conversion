#!/bin/bash
#FLUX: --job-name=traindwnscale
#FLUX: --queue=short-serial
#FLUX: -t=86400
#FLUX: --urgency=16

source /home/users/doran/software/envs/pytorch/bin/activate
python ../train_script2.py ${SLURM_ARRAY_TASK_ID}
