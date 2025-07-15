#!/bin/bash
#FLUX: --job-name=dump
#FLUX: -t=3600
#FLUX: --priority=16

inputFileName="./input/Dump_input_parameters.txt"
parameters=`sed "${SLURM_ARRAY_TASK_ID}q;d" $inputFileName`
time python ./01_dump.py $parameters
