#!/bin/bash
#FLUX: --job-name=gama_logm
#FLUX: --queue=conroy,shared,conroy-intel,itc_cluster
#FLUX: -t=345600
#FLUX: --urgency=16

IDFILE=$APPS"/prospector_alpha/data/gama.ids"
OBJID=$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$IDFILE")
srun -n $SLURM_NTASKS --mpi=pmi2 python $APPS/prospector/scripts/prospector_dynesty.py \
--param_file="$APPS"/prospector_alpha/parameter_files/gama_logm_params.py \
--objname="$OBJID" \
--outfile="$APPS"/prospector_alpha/results/gama_logm/"$OBJID"
