#!/bin/bash
#FLUX: --job-name=stinky-malarkey-4164
#FLUX: --priority=16

cd ~/2023-DynPTOModelDesignStudies
module load matlab
matlab -nodisplay -r \
"iVar = ${SLURM_ARRAY_TASK_ID}; \
display(['iVar = ',num2str(iVar)]); \
SS = ${SS}; \
display(['SS = ',num2str(SS)]); \
study_parPTO_accumNoDpDt_woPL_wPassiveRV"
