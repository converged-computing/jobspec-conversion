#!/bin/bash
#FLUX: --job-name=td_dynamic
#FLUX: --queue=conroy-intel,conroy,shared,itc_cluster
#FLUX: -t=604800
#FLUX: --urgency=16

IDFILE=$APPS"/prospector_alpha/data/3dhst/td_dynamic.ids"
OBJID=$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$IDFILE")
srun -n 1 --mpi=pmi2 python $APPS/prospector/scripts/prospector_dynesty.py \
--param_file="$APPS"/prospector_alpha/parameter_files/td_dynamic_params.py \
--objname="$OBJID" \
--outfile="$APPS"/prospector_alpha/results/td_dynamic/"$OBJID" \
--runname="td_dynamic"
