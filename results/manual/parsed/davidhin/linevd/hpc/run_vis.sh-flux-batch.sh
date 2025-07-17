#!/bin/bash
#FLUX: --job-name=vis
#FLUX: -n=6
#FLUX: --queue=batch
#FLUX: -t=43200
#FLUX: --urgency=16

module load Singularity
module load CUDA/10.2.89
singularity exec -H /g/acvt/a1720858/sastvd --nv main.sif python sastvd/linevd/generate_pred_vis.py
