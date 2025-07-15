#!/bin/bash
#FLUX: --job-name=l2_reg
#FLUX: -c=2
#FLUX: -t=10800
#FLUX: --urgency=16

array=(0.00001 0.0001 0.001 0.01 0.1 0.5 1)
module load singularity
singularity exec --writable-tmpfs --nv \
    --bind /gscratch/walkerlab/patrick:/data,/mmfs1/home/pqz317/wcst_decode:/src/wcst_decode \
    /gscratch/walkerlab/patrick/singularity/wcst_decode_image.sif \
    /usr/bin/python3 /src/wcst_decode/scripts/pseudo_decoding/20231103_decode_features_subpop_abstract.py \
    --l2_reg ${array[$SLURM_ARRAY_TASK_ID]}
