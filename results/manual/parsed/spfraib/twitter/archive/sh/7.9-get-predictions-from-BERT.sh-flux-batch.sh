#!/bin/bash
#FLUX: --job-name=predictions
#FLUX: -t=86400
#FLUX: --priority=16

module purge
module load anaconda3/2020.02
source ~/mypython/py3.7/bin/activate
cd /scratch/spf248/twitter
srun time python -u ./py/7.9-get-predictions-from-BERT.py > ./log/7.9-get-predictions-from-BERT-${SLURM_ARRAY_TASK_ID}-$(date +%s).log 2>&1
exit
