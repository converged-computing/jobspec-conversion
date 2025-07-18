#!/bin/bash
#FLUX: --job-name=psycho-salad-5105
#FLUX: --queue=mhealth,...
#FLUX: --urgency=16

export IFS=';'

echo $SLURM_JOBID - `hostname` - $SPINN_FLAGS >> ~/spinn_machine_assignments.txt
module load python/intel/2.7.12 pytorch/0.2.0_1 protobuf/intel/3.1.0
MODEL="spinn.models.supervised_classifier"
if [ -n "$SPINNMODEL" ]; then
    MODEL=$SPINNMODEL
fi
export IFS=';'
for SUB_FLAGS in $SPINN_FLAGS
do
	unset IFS
	python -m $MODEL --noshow_progress_bar --gpu 0 $SUB_FLAGS &
done
wait
