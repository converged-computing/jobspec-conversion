#!/bin/bash
#SBATCH --job-name=wd
#SBATCH --output=log_files/out_%A_%a
#SBATCH --error=log_files/err_%A_%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --array=0-1620%700

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
