#!/bin/bash
#FLUX: --job-name=milky-spoon-6501
#FLUX: -t=600
#FLUX: --urgency=16

if [ ${SLURM_ARRAY_TASK_ID} -eq 1 ]; then
   STEP_COUNT=500000
elif [ ${SLURM_ARRAY_TASK_ID} -eq 2 ]; then
   STEP_COUNT=1000000
elif [ ${SLURM_ARRAY_TASK_ID} -eq 3 ]; then
   STEP_COUNT=1500000
fi
python main.py --training_steps ${STEP_COUNT} --env base_prl --save
