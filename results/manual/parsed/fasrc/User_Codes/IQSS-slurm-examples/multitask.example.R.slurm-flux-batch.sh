#!/bin/bash
#FLUX: --job-name=multitask.example
#FLUX: -n=5
#FLUX: --queue=serial_requeue
#FLUX: -t=900
#FLUX: --urgency=16

module purge > /dev/null 2>&1
module load gcc/7.1.0-fasrc01 R/3.5.0-fasrc01
module load intel/17.0.4-fasrc01 R/3.5.0-fasrc01
chmod u+x multitask.example.R 
./multitask.example.R "${SLURM_ARRAY_TASK_ID}"   # Run R hello world.
