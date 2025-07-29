#!/bin/bash
#FLUX: --job-name=EriII_noSFHPrior
#FLUX: --queue=savio2
#FLUX: -t=259200
#FLUX: --urgency=16

echo "Loading modules"
source activate /clusterfs/dweisz/nathan_sandford/.conda/envs/ChemEv
python /clusterfs/dweisz/nathan_sandford/github_repos/ChemWAF/scripts/EriII_noSFHPrior.py
