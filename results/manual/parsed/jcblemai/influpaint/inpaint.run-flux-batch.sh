#!/bin/bash
#FLUX: --job-name=crunchy-pot-9696
#FLUX: --queue=a100-gpu,l40-gpu
#FLUX: -t=57600
#FLUX: --urgency=16

module purge
/nas/longleaf/home/chadi/.conda/envs/diffusion_torch6/bin/python -u main.py --spec_id ${SLURM_ARRAY_TASK_ID} --inpaint True > out_inpaint_${SLURM_ARRAY_TASK_ID}.out 2>&1
