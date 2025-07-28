#!/bin/bash
#FLUX: --job-name=spicy-pedo-6659
#FLUX: -c=10
#FLUX: -t=172800
#FLUX: --urgency=16

spack env activate nick
Rscript ./scripts/Analyses_Mallard_MultistateModel.R
