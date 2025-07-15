#!/bin/bash
#FLUX: --job-name=reclusive-salad-4936
#FLUX: --priority=16

IDFILE=$APPS"/prospector_alpha/data/3dhst/mo.cat"
n1=`expr $SLURM_ARRAY_TASK_ID + 1`
OBJID=$(awk -v i=$n1 -v j=1 'FNR == i {print $j}' $IDFILE)
srun -n 1 --mpi=pmi2 python $APPS/prospector/scripts/prospector_dynesty.py \
--param_file="$APPS"/prospector_alpha/parameter_files/mo_params.py \
--objname="$OBJID" \
--outfile="$APPS"/prospector_alpha/results/mo/"$OBJID"
