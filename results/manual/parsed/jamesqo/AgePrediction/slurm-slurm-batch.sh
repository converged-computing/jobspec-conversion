#!/bin/bash
#FLUX: --job-name=arid-cattywampus-1948
#FLUX: --queue=fnndsc-gpu
#FLUX: -t=432000
#FLUX: --urgency=16

module load anaconda3
source activate james
pip install --user -r requirements.txt
python -m age_prediction.train --job-id $SLURM_JOB_ID "$@"
