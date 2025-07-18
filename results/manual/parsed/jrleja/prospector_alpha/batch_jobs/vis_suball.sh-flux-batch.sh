#!/bin/bash
#FLUX: --job-name=vis
#FLUX: --queue=shared
#FLUX: -t=604800
#FLUX: --urgency=16

srun -n 1 --mpi=pmi2 python $APPS/prospector/scripts/prospector_dynesty.py \
--param_file="$APPS"/prospector_alpha/parameter_files/vis_params.py \
--outfile="$APPS"/prospector_alpha/results/vis/vis_"${SLURM_ARRAY_TASK_ID}" \
--filter_key="${SLURM_ARRAY_TASK_ID}"
