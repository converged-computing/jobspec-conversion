#!/bin/bash
#FLUX: --job-name=prepvae
#FLUX: --queue=short
#FLUX: -t=10
#FLUX: --urgency=16

module load gcc/6.2.0 python/3.7.4
source /home/hw233/virtualenv/py374/bin/activate
python prep_vae.py $SLURM_ARRAY_TASK_ID
