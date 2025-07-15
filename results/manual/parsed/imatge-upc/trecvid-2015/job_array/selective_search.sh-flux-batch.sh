#!/bin/bash
#FLUX: --job-name=hairy-omelette-9050
#FLUX: --priority=16

matlab -nodisplay '+single_thread+' '+jvm_string+' -nodesktop -r "addpath('../scripts/matlab/');, run_selective_search(${SLURM_ARRAY_TASK_ID});"
