#!/bin/bash
#FLUX: --job-name=grupo06-w3
#FLUX: -n=4
#FLUX: --queue=mhigh,mlow
#FLUX: --priority=16

source venv/bin/activate
python m3-project/w3/run.py m3-project/w3/config.ini ${SLURM_ARRAY_TASK_ID} --batch_size 256
