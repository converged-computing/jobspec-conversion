#!/bin/bash
#FLUX: --job-name=sample_job_\${SLURM_ARRAY_TASK_ID}
#FLUX: --queue=w10001
#FLUX: -t=600
#FLUX: --urgency=16

module purge all
module load python-anaconda3
source activate slurm-py37-test
IFS=$'\n' read -d '' -r -a lines < list_of_files.txt
python slurm_test.py --job-id $SLURM_ARRAY_TASK_ID --filename ${lines[$SLURM_ARRAY_TASK_ID]}
