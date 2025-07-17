#!/bin/bash
#FLUX: --job-name=goodbye-lentil-7666
#FLUX: --queue=msismall
#FLUX: -t=28800
#FLUX: --urgency=16

cd ~/2023-DynPTOModelDesignStudies
module load matlab
matlab -nodisplay -r \
"iVar = ${SLURM_ARRAY_TASK_ID}; \
display(['iVar = ',num2str(iVar)]); \
SS = ${SS}; \
display(['SS = ',num2str(SS)]); \
study_parPTO_accumNoDpDt_woPL_wPassiveRV"
