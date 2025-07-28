#!/bin/bash
#FLUX: --job-name=frigid-avocado-6065
#FLUX: --urgency=16

matlab -nodisplay '+single_thread+' '+jvm_string+' -nodesktop -r "addpath('../scripts/matlab/');, run_selective_search(${SLURM_ARRAY_TASK_ID});"
