#!/bin/bash
#FLUX: --job-name=bumfuzzled-cherry-7063
#FLUX: -c=10
#FLUX: -t=172800
#FLUX: --urgency=16

spack env activate nick
Rscript ./scripts/Analyses_Mallard_MultistateModel.R
