#!/bin/bash
#FLUX: --job-name=bloated-lizard-5686
#FLUX: --queue=jlessler
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
/nas/longleaf/home/chadi/.conda/envs/diffusion_torch6/bin/python -u main_refine.py --spec_id ${SLURM_ARRAY_TASK_ID} --inpaint True > out_refine_${SLURM_ARRAY_TASK_ID}.out 2>&1
