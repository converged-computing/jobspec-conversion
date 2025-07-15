#!/bin/bash
#FLUX: --job-name=psycho-bike-4837
#FLUX: --urgency=16

module load ncf
module load matlab/R2021a-fasrc01
module load spm/12.7487-fasrc01
matlab -nodisplay -nosplash -r "script_6_pxp;exit"
