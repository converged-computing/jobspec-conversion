#!/bin/bash
#FLUX: --job-name=crunchy-chair-0571
#FLUX: --urgency=16

module load python/3.9
cd /project/meisel/users/bmmclain/Y1W1Y2W2
python MultiProcessingCode_Y1W1Y2W2_v1.py $SLURM_JOB_ID 1000000 1000 48 random
