#!/bin/bash
#FLUX: --job-name=cowy-malarkey-6355
#FLUX: --queue=gpu
#FLUX: -t=1200
#FLUX: --urgency=16

export scriptdir='$(dirname $(type -p dti_eddy.sh))'

set -a
module load tacc-singularity
module load Rstats
export scriptdir=$(dirname $(type -p dti_eddy.sh))
${scriptdir}/dti_eddy.sh "$@"
