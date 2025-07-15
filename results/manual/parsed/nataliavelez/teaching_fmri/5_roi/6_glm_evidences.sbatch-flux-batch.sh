#!/bin/bash
#FLUX: --job-name=lovely-poo-8940
#FLUX: --priority=16

module load ncf
module load matlab/R2021a-fasrc01
module load spm/12.7487-fasrc01
matlab -nodisplay -nosplash -r "script_6_glm_evidences;exit"
