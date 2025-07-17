#!/bin/bash
#FLUX: --job-name=MAKE_BDF
#FLUX: -c=32
#FLUX: --queue=normal
#FLUX: -t=28800
#FLUX: --urgency=16

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors
module restore system
module load MATLAB/2020b
echo "starting..."
cd ${SLURM_SUBMIT_DIR}
matlab -nodisplay -nodesktop -nojvm -r "DO_ALL"
echo "done"
