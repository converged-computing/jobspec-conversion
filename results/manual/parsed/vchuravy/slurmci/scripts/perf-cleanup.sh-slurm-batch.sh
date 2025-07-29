#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:15:00

export PATH='/groups/esm/common/julia-1.3:$PATH'

set -euo pipefail
set -x #echo on
export PATH="/groups/esm/common/julia-1.3:$PATH"
julia --project finalize-perf.jl
rm /central/scratchio/esm/slurmci/downloads/${CI_SHA}.tar.gz
rm -rf /central/scratchio/esm/slurmci/sources/${CI_SHA}
