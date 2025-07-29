#!/bin/bash
#FLUX --job-name=delicious-signal-2277
#FLUX -c=10
#FLUX -t=172800
#FLUX --urgency=16

export IFS=';'

echo $SLURM_JOBID - `hostname` - $SPINN_FLAGS >> ~/spinn_machine_assignments.txt
module load python/intel/2.7.12 pytorch/0.2.0_1 protobuf/intel/3.1.0
MODEL="spinn.models.es_classifier"
if [ -n "$SPINNMODEL" ]; then
    MODEL=$SPINNMODEL
fi
export IFS=';'
for SUB_FLAGS in $SPINN_FLAGS
do
	unset IFS
	python -m $MODEL --noshow_progress_bar $SUB_FLAGS
done
wait
