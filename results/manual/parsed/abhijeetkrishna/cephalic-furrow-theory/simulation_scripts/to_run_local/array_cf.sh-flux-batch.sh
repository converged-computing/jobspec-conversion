#!/bin/bash
#FLUX: --job-name=spicy-banana-7522
#FLUX: --urgency=16

job_id=0
py_map_creator=map_index_cf.py
initiator=initialize.py
simulation=gradDescent.jl
map_file=map_index_$job_id.csv
postprocess=postprocess.py
python3 $py_map_creator $job_id
nbfiles=$(wc -l < $map_file)
nbfiles=$((nbfiles-2)) #because bash reads header line
echo "Number of files $nbfiles"
for i in {0..8}
do
	echo "Running task number : $i"
	python3 $initiator $map_file $i #$SLURM_ARRAY_TASK_ID
	julia $simulation $map_file $i #$SLURM_ARRAY_TASK_ID
	python3 $postprocess $map_file $i #$SLURM_ARRAY_TASK_ID
done
