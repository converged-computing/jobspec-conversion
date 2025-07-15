#!/bin/bash
#FLUX: --job-name=autoencoder
#FLUX: --urgency=16

singularity exec -B /om:/om --nv /om/user/nprasad/singularity/tensorflow-1.8.0-gpu-py3.img \
python /om/user/nprasad/aesap/main.py /om/user/nprasad/aesap/ ${SLURM_ARRAY_TASK_ID} 0
