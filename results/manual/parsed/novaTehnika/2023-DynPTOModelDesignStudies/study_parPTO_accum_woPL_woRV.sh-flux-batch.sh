#!/bin/bash
#FLUX: --job-name=red-peanut-butter-9638
#FLUX: -n=11
#FLUX: --queue=msismall
#FLUX: -t=86400
#FLUX: --urgency=16

cd ~/2023-DynPTOModelDesignStudies
module load matlab
matlab -nodisplay -r \
"SS = ${SS}; \
display(['SS = ',num2str(SS)]); \
addpath('Utilities'); \
nWorkers = ${SLURM_NTASKS}-1; \
parSafeStartSlurm; \
study_parPTO_accum_woPL_woRV; \
rmdir(storage_folder)"
