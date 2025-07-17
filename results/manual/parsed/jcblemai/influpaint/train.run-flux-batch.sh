#!/bin/bash
#FLUX: --job-name=rainbow-latke-8912
#FLUX: --queue=jlessler
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
/nas/longleaf/home/chadi/.conda/envs/diffusion_torch6/bin/python -u main.py --spec_id ${SLURM_ARRAY_TASK_ID} --train True > out_train_${SLURM_ARRAY_TASK_ID}.out 2>&1
