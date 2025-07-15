#!/bin/bash
#FLUX: --job-name=wobbly-bike-7502
#FLUX: --priority=16

srun -n 1 --mpi=pmi2 python $APPS/prospector/scripts/prospector_dynesty.py \
--param_file="$APPS"/prospector_alpha/parameter_files/mock_200delta_params.py \
--objname="${SLURM_ARRAY_TASK_ID}" \
--outfile="$APPS"/prospector_alpha/results/mock_200delta/"${SLURM_ARRAY_TASK_ID}"
