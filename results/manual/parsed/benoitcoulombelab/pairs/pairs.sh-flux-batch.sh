#!/bin/bash
#FLUX: --job-name=confused-underoos-0458
#FLUX: -t=604800
#FLUX: --urgency=16

export NXF_OPTS='-Xms500M -Xmx8000M'

set -e
if [[ -n "$CC_CLUSTER" ]]
then
  module purge
  module load StdEnv/2020
  module load nextflow/22.10.6
fi
if [[ "beluga" == "$CC_CLUSTER" ]]
then
  ulimit -v 40000000
fi
export NXF_OPTS="-Xms500M -Xmx8000M"
nextflow run pairs.nf \
    --fasta "fasta_pairs/*.fasta" \
    --outdir "$PWD/output" \
    -c alliancecan.config \
    "$@"
