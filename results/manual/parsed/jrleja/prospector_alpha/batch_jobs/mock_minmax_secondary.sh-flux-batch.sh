#!/bin/bash
#FLUX: --job-name=mock_minmax_sec
#FLUX: --queue=conroy-intel,shared,serial_requeue,itc_cluster
#FLUX: -t=57600
#FLUX: --urgency=16

srun -n 1 --mpi=pmi2 python $APPS/prospector_alpha/code/td/postprocessing.py \
$APPS/prospector_alpha/parameter_files/mock_minmax_params.py \
--objname="${SLURM_ARRAY_TASK_ID}" \
--overwrite=True \
--plot=True \
--shorten_spec=True
