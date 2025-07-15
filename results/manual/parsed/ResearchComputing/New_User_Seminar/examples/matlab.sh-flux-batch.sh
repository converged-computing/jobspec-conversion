#!/bin/bash
#FLUX: --job-name=scruptious-caramel-1603
#FLUX: --queue=shas-testing
#FLUX: -t=120
#FLUX: --urgency=16

module purge
module load matlab/R2019b
matlab -nodisplay -nodesktop -r "clear; matlab_tic;"
echo
echo "Job done."
