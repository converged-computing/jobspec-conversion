#!/bin/bash
#FLUX: --job-name=hairy-hope-2393
#FLUX: --urgency=16

srun -n 1 --mpi=pmi2 python $APPS/prospector/scripts/prospector_dynesty.py \
--param_file="$APPS"/prospector_alpha/parameter_files/mock_hybrid_params.py \
--objname="${SLURM_ARRAY_TASK_ID}" \
--outfile="$APPS"/prospector_alpha/results/mock_hybrid/"${SLURM_ARRAY_TASK_ID}"
