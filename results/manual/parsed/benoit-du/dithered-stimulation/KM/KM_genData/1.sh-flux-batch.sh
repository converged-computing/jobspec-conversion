#!/bin/bash
#FLUX: --job-name=KM
#FLUX: --queue=medium
#FLUX: -t=86400
#FLUX: --urgency=16

export MCR_CACHE_ROOT='$(mktemp -d)'

module load MATLAB/R2019b
export MCR_CACHE_ROOT=$(mktemp -d)
./run_KmWrapper.sh /system/software/linux-x86_64/matlab/R2019b "KM_"$SLURM_ARRAY_JOB_ID 350 20 7.9 20000 200 3 350 200 "[0 0.15]" "HH_PRC" 100 5 400 0.0001 130 "[]" 1 "false"
wait 
wait 
rm -rf ${MCR_CACHE_ROOT}
