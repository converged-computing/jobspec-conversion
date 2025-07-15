#!/bin/bash
#FLUX: --job-name=fuzzy-malarkey-2843
#FLUX: --urgency=16

IDFILE=$APPS"/prospector_alpha/data/3dhst/td_massive.ids"
OBJID=$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$IDFILE")
srun -n $SLURM_NTASKS --mpi=pmi2 python $APPS/prospector/scripts/prospector.py \
--param_file="$APPS"/prospector_alpha/parameter_files/td_massive_noagb_params.py \
--objname="$OBJID" \
--outfile="$APPS"/prospector_alpha/results/td_massive_noagb/"$OBJID"
