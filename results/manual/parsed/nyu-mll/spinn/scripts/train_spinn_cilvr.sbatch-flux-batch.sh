#!/bin/bash
#FLUX: --job-name=loopy-butter-8967
#FLUX: --urgency=16

export IFS=';'

echo $SLURM_JOBID - `hostname` - $SPINN_FLAGS >> ~/spinn_machine_assignments.txt
module load python-3.6
MODEL="spinn.models.supervised_classifier"
if [ -n "$SPINNMODEL" ]; then
    MODEL=$SPINNMODEL
fi
export IFS=';'
for SUB_FLAGS in $SPINN_FLAGS
do
	unset IFS
	python3 -m $MODEL --noshow_progress_bar --gpu 0 $SUB_FLAGS &
done
wait 
