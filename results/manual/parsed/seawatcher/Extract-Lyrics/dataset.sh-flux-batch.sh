#!/bin/bash
#FLUX: --job-name=evasive-hope-5890
#FLUX: -c=4
#FLUX: -t=18000
#FLUX: --urgency=16

module load python/3.8
module load scipy-stack
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install google==3.0.0
pip install openpyxl
echo "Starting Task $SLURM_ARRAY_TASK_ID"
python -u data_lyrics.py --id $SLURM_ARRAY_TASK_ID
