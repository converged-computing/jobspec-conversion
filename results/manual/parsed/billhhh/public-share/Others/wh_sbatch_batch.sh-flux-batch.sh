#!/bin/bash
#FLUX: --job-name=fat-peanut-butter-6417
#FLUX: -t=86400
#FLUX: --urgency=16

nvidia-smi -l > nv-smi_sa.log.${SLURM_JOB_ID} 2>&1 &
python ./main.py
