#!/bin/bash
#FLUX: --job-name=angry-onion-0246
#FLUX: --queue=fasse
#FLUX: -t=300
#FLUX: --urgency=16

module load ncf
module load matlab/R2021a-fasrc01
module load spm/12.7487-fasrc01
matlab -nodisplay -nosplash -r "script_6_glm_evidences;exit"
