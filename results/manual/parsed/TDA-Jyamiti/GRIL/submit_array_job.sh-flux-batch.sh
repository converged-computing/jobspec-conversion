#!/bin/bash
#FLUX: --job-name=mega_array
#FLUX: -t=7200
#FLUX: --urgency=16

pwd; hostname; date
PER_TASK=100
START_NUM=$(( $SLURM_ARRAY_TASK_ID * $PER_TASK))
END_NUM=$(( (($SLURM_ARRAY_TASK_ID + 1)) * $PER_TASK))
echo $START_NUM
echo $END_NUM
echo This is task $SLURM_ARRAY_TASK_ID, which will do runs $START_NUM to $(( $END_NUM - 1 ))
module load anaconda
module load boost
source activate mpml
for (( run=$START_NUM; run<END_NUM; run++ )); do
  echo This is SLURM task $SLURM_ARRAY_TASK_ID, run number $run
  #Do your stuff here
  /home/mukher26/.conda/envs/cent7/2020.02-py37/mpml/bin/python main_graph.py --dataset $1 --sample $run
done
date
