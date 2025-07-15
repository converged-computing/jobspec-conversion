#!/bin/bash
#FLUX: --job-name=creamy-sundae-2818
#FLUX: -c=20
#FLUX: -t=21600
#FLUX: --priority=16

pattern=$1
shift
srun singularity exec --bind /scratch/izar --nv ../pytorch_latest.sif \
  /bin/bash -c "source ../.venv/apollo/bin/activate && find outputs/ -name \"$pattern\" -exec python3 -m openpifpaf.eval --checkpoint {} $(printf "%s " "$@") \;"
