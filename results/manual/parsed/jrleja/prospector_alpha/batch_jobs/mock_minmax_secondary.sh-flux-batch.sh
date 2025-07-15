#!/bin/bash
#FLUX: --job-name=lovable-egg-1661
#FLUX: --priority=16

srun -n 1 --mpi=pmi2 python $APPS/prospector_alpha/code/td/postprocessing.py \
$APPS/prospector_alpha/parameter_files/mock_minmax_params.py \
--objname="${SLURM_ARRAY_TASK_ID}" \
--overwrite=True \
--plot=True \
--shorten_spec=True
