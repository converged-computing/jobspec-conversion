#!/bin/bash
#FLUX: --job-name=MAKE_BDF
#FLUX: --queue=bigmem
#FLUX: -t=28800
#FLUX: --urgency=16

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors
module restore system
module load MATLAB/2019a
echo "starting..."
cd ${SLURM_SUBMIT_DIR}
matlab -nodisplay -nodesktop -nojvm -r "global RECORD_PDG_TO_PROCESS; RECORD_PDG_TO_PROCESS = 22; MAKE_BIG_DATAFILES"
matlab -nodisplay -nodesktop -nojvm -r "global RECORD_PDG_TO_PROCESS; RECORD_PDG_TO_PROCESS = 11; MAKE_BIG_DATAFILES"
matlab -nodisplay -nodesktop -nojvm -r "global RECORD_PDG_TO_PROCESS; RECORD_PDG_TO_PROCESS = -11; MAKE_BIG_DATAFILES"
echo "done"
