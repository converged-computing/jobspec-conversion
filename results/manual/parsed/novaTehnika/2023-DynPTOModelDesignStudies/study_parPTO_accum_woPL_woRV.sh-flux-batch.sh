#!/bin/bash
#FLUX: --job-name=dinosaur-chair-2834
#FLUX: -n=11
#FLUX: --priority=16

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
