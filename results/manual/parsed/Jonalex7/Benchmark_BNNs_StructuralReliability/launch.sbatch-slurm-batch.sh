#!/bin/bash
#FLUX: --job-name=bnn_surrogate_test
#FLUX: --queue=batch
#FLUX: -t=129600
#FLUX: --urgency=16

ARGS=("--method=bnnbpp --lstate=parabolic" "--method=dropout --lstate=parabolic" "--method=sghmc --lstate=himmelblau" "--method=sghmc --lstate=parabolic" "--method=sghmc --lstate=electric" "--method=sghmc --lstate=high_dim")
ARG=${ARGS[$SLURM_ARRAY_TASK_ID]}
source env/bin/activate
python main_train.py $ARG
