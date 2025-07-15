#!/bin/bash
#FLUX: --job-name=psycho-latke-2202
#FLUX: --urgency=16

JOB_ID=${SLURM_JOB_ID}
echo $JOB_ID
python main.py --method $1 --job_id $JOB_ID --pgd_eps $2 --pgd_itr $3 --lambbda $4
