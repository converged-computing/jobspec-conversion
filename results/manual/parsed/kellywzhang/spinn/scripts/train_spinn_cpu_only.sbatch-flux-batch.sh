#!/bin/bash
#FLUX: --job-name=eccentric-general-1376
#FLUX: --urgency=16

export IFS=';'

echo $SLURM_JOBID - `hostname` - $SPINN_FLAGS >> ~/spinn_machine_assignments.txt
module load python/intel/2.7.12 pytorch/intel/20170226 protobuf/intel/3.1.0
export IFS=';'
for SUB_FLAGS in $SPINN_FLAGS
do
	unset IFS
	python -m spinn.models.fat_classifier  --noshow_progress_bar $SUB_FLAGS &
done
wait
