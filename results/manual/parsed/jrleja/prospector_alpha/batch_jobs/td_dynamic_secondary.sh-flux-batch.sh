#!/bin/bash
#FLUX: --job-name=gassy-mango-4502
#FLUX: --urgency=16

IDFILE=$APPS"/prospector_alpha/data/3dhst/td_dynamic.ids"
OBJID=$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$IDFILE")
python $APPS/prospector_alpha/code/td/postprocessing.py \
$APPS/prospector_alpha/parameter_files/td_dynamic_params.py \
--objname="$OBJID" \
--overwrite=True \
--plot=True \
--shorten_spec=True
