#!/bin/bash
#FLUX: --job-name=strawberry-soup-5700
#FLUX: --queue=mhealth,...
#FLUX: --urgency=16

export IFS=';'

echo $SLURM_JOBID - `hostname` - $SPINN_FLAGS >> ~/spinn_machine_assignments.txt
module load python3/intel/3.6.3 pytorch/python3.6/0.3.0_4
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
