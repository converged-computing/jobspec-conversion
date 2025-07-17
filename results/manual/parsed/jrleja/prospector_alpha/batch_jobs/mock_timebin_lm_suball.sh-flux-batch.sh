#!/bin/bash
#FLUX: --job-name=mock_timebin_lm
#FLUX: --queue=conroy,shared
#FLUX: -t=432000
#FLUX: --urgency=16

srun -n 1 --mpi=pmi2 python $APPS/prospector/scripts/prospector_dynesty.py \
--param_file="$APPS"/prospector_alpha/parameter_files/mock_timebin_lm_params.py \
--objname="${SLURM_ARRAY_TASK_ID}" \
--outfile="$APPS"/prospector_alpha/results/mock_timebin_lm/"${SLURM_ARRAY_TASK_ID}"
