#!/bin/bash
#FLUX: --job-name=anxious-hope-4041
#FLUX: --priority=16

export scriptdir='$(dirname $(type -p dti_eddy.sh))'

set -a
module load tacc-singularity
module load Rstats
export scriptdir=$(dirname $(type -p dti_eddy.sh))
${scriptdir}/dti_eddy.sh "$@"
