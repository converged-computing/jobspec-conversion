#!/bin/bash
#FLUX: --job-name=peachy-puppy-4074
#FLUX: -c=2
#FLUX: --queue=p100
#FLUX: --urgency=16

JOB_ID=${SLURM_JOB_ID}
echo $JOB_ID
python main.py --method $1 --job_id $JOB_ID --pgd_eps $2 --pgd_itr $3 --lambbda $4
