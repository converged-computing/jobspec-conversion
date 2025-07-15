#!/bin/bash
#FLUX: --job-name=eccentric-fudge-3435
#FLUX: --queue=fnndsc-gpu
#FLUX: -t=432000
#FLUX: --priority=16

module load anaconda3
source activate james
pip install --user -r requirements.txt
python -m age_prediction.train --job-id $SLURM_JOB_ID "$@"
