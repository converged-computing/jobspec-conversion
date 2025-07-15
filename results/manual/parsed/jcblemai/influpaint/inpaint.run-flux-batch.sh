#!/bin/bash
#FLUX: --job-name=swampy-buttface-7600
#FLUX: --urgency=16

module purge
/nas/longleaf/home/chadi/.conda/envs/diffusion_torch6/bin/python -u main.py --spec_id ${SLURM_ARRAY_TASK_ID} --inpaint True > out_inpaint_${SLURM_ARRAY_TASK_ID}.out 2>&1
