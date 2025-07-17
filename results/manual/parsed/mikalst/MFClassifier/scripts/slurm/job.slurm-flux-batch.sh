#!/bin/bash
#FLUX: --job-name=matrix-completion-many
#FLUX: -c=20
#FLUX: --queue=WORKQ
#FLUX: -t=600
#FLUX: --urgency=16

module load intel/2018b
module load Python/3.6.6
module list
matlab -nodisplay -nodesktop -nosplash -nojvm -r "test"
