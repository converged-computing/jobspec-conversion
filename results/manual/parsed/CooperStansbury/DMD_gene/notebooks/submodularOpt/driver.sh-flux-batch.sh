#!/bin/bash
#FLUX: --job-name=soss2015
#FLUX: --queue=standard
#FLUX: -t=172800
#FLUX: --priority=16

module load matlab
echo $1
echo $2
echo $3
matlab -nodisplay -r "addpath(genpath(pwd)); driver($1, $SLURM_ARRAY_TASK_ID, 100, $2, $3)"
