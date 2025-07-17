#!/bin/bash
#FLUX: --job-name=pusheena-nunchucks-1061
#FLUX: -t=900
#FLUX: --urgency=16

export PATH='/groups/esm/common/julia-1.3:$PATH'

set -euo pipefail
set -x #echo on
export PATH="/groups/esm/common/julia-1.3:$PATH"
julia --project finalize-perf.jl
rm /central/scratchio/esm/slurmci/downloads/${CI_SHA}.tar.gz
rm -rf /central/scratchio/esm/slurmci/sources/${CI_SHA}
