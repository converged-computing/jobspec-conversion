#!/bin/bash
#FLUX: --job-name=spicy-blackbean-2840
#FLUX: --urgency=16

module load ncf
module load matlab/R2021a-fasrc01
module load spm/12.7487-fasrc01
matlab -nodisplay -nosplash -r "script_6_glm_evidences;exit"
