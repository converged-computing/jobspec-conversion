#!/bin/bash
#FLUX: --job-name=fugly-poo-8547
#FLUX: --priority=16

module purge
/nas/longleaf/home/chadi/.conda/envs/diffusion_torch6/bin/python -u main.py --spec_id ${SLURM_ARRAY_TASK_ID} --train True > out_train_${SLURM_ARRAY_TASK_ID}.out 2>&1
