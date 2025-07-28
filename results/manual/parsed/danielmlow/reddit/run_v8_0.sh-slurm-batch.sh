#!/bin/bash
#FLUX: --job-name=reddit
#FLUX: -t=3600
#FLUX: --urgency=16

echo "now processing task id:: " ${SLURM_ARRAY_TASK_ID}
python3 run.py --job_array_task_id=${SLURM_ARRAY_TASK_ID} --run_version_number=8 --toy=False --dim_reduction=False --run_modelN=0
echo 'Finished.'
