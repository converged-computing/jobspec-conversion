#!/bin/bash
#FLUX: --job-name=hairy-nunchucks-9647
#FLUX: --priority=16

sleep 5s
echo $SLURM_ARRAY_TASK_ID 
sleep 5s
