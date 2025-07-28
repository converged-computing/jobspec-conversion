#!/bin/bash
#FLUX: --job-name=butterscotch-leg-6267
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
study_parPTO_chargePumpAccum;"
