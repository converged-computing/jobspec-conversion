#!/bin/bash
#FLUX: --job-name=quirky-cherry-0439
#FLUX: -c=2
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --urgency=16

nvidia-smi -l > nv-smi_sa.log.${SLURM_JOB_ID} 2>&1 &
python ./main.py
