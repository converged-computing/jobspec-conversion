#!/bin/bash
#FLUX: --job-name=tasktest
#FLUX: -c=4
#FLUX: --queue=qTRDGPUH
#FLUX: -t=60
#FLUX: --urgency=16

sleep 5s
echo $SLURM_ARRAY_TASK_ID 
sleep 5s
