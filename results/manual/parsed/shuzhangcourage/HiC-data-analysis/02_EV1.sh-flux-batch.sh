#!/bin/bash
#FLUX: --job-name=EV1
#FLUX: --queue=fat
#FLUX: -t=7200
#FLUX: --urgency=16

inputFileName="./input/EV1_input_parameters.txt"
parameters=`sed "${SLURM_ARRAY_TASK_ID}q;d" $inputFileName`
time python ./02_EV1.py $parameters
