#!/bin/bash
#FLUX: --job-name=array_5
#FLUX: --queue=cpu_compute
#FLUX: --urgency=16

module load R
Rscript R/workflow.R $SLURM_ARRAY_TASK_ID 
