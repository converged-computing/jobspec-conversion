#!/bin/bash
#FLUX: --job-name=UAV-POS-VERIFY
#FLUX: --queue=ib
#FLUX: -t=7200
#FLUX: --urgency=16

pyenv shell 3.11.1
python3 main_hpc.py $SLURM_ARRAY_TASK_ID 0
exit
