#!/bin/bash
#FLUX: --job-name=dirty-cattywampus-7699
#FLUX: -t=600
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
myCalculations $SLURM_ARRAY_TASK_ID
