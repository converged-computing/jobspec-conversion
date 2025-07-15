#!/bin/bash
#FLUX: --job-name=ornery-bits-8076
#FLUX: --priority=16

srun -n 1 --mpi=pmi2 python $APPS/prospector_alpha/code/td/postprocessing.py \
$APPS/prospector_alpha/parameter_files/td_new_mock_params.py \
--objname="${SLURM_ARRAY_TASK_ID}" \
--overwrite=True \
--plot=False \
--shorten_spec=True
