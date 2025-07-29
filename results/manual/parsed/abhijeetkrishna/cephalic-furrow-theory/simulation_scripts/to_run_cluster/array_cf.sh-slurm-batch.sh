#!/bin/bash
#FLUX: --job-name=wd
#FLUX: -t=86400
#FLUX: --urgency=16

py_map_creator=map_index_cf.py
initiator=initialize.py
simulation=gradDescent.jl
map_file=map_index_$SLURM_ARRAY_JOB_ID.csv
postprocess=postprocess.py
if [ ! -f $map_file ]
then
	python3 $py_map_creator $SLURM_ARRAY_JOB_ID
fi
python3 $initiator $map_file $SLURM_ARRAY_TASK_ID
julia $simulation $map_file $SLURM_ARRAY_TASK_ID
python3 $postprocess $map_file $SLURM_ARRAY_TASK_ID
