#!/bin/bash
#FLUX: --job-name=vo3mrn50
#FLUX: -N 8
#FLUX: --ntasks-per-node=8
#FLUX: -c 10
#FLUX: --gpus-per-task=1 
# Note: The Slurm constraint "volta32gb" needs to be ensured by system configuration
# or by requesting a specific Flux resource if available for that GPU type.
# For example, if 'volta32gb' is a resource: #FLUX: --requires=volta32gb
#FLUX: --mem-per-node=450GB
#FLUX: -t 72h  # 72:00:00
#FLUX: --signal=USR1@600
#FLUX: --mail-user=maksymets@gmail.com
#