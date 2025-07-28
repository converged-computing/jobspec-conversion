#!/bin/bash
#FLUX: --job-name=hairy-dog-0609
#FLUX: --queue=fasse
#FLUX: -t=120
#FLUX: --urgency=16

module load ncf
module load matlab/R2021a-fasrc01
module load spm/12.7487-fasrc01
matlab -nodisplay -nosplash -r "script_6_pxp;exit"
