#!/bin/bash
#FLUX: --job-name=blank-itch-3328
#FLUX: -c=40
#FLUX: -t=259200
#FLUX: --priority=16

srun singularity exec --bind /scratch/izar --nv ../pytorch_latest.sif \
  /bin/bash -c "source ../.venv/apollo/bin/activate && time CUDA_VISIBLE_DEVICES=0,1 python3 -u -m openpifpaf.train $(printf "%s " "$@")"
