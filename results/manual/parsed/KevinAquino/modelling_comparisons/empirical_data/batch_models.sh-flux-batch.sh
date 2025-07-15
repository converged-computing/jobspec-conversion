#!/bin/bash
#FLUX: --job-name=BOLD
#FLUX: -t=14400
#FLUX: --urgency=16

module load matlab/r2016a
echo $cm
matlab -nodisplay -r "run_multiple_BTF('${cm}'); exit"
