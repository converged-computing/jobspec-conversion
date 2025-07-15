#!/bin/bash
#FLUX: --job-name=spicy-punk-5487
#FLUX: --priority=16

IDFILE=$APPS"/prospector_alpha/data/CANDELS_GDSS_workshop_z1.dat"
n1=`expr $SLURM_ARRAY_TASK_ID + 1`
OBJID=$(awk -v i=$n1 -v j=1 'FNR == i {print $j}' $IDFILE)
srun -n 1 --exclusive --mpi=pmi2 python $APPS/prospector_alpha/code/td/postprocessing.py \
$APPS/prospector_alpha/parameter_files/candels_z3_params.py \
--objname="$OBJID" \
--overwrite=True \
--plot=True \
--shorten_spec=True
