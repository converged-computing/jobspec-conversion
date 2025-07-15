#!/bin/bash
#FLUX: --job-name=blue-bicycle-8745
#FLUX: --urgency=16

sleep 5s
echo $SLURM_ARRAY_TASK_ID 
sleep 5s
