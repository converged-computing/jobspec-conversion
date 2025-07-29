#!/bin/bash
#FLUX --job-name=expensive-malarkey-9812
#FLUX -c=10
#FLUX -t=172800
#FLUX --urgency=16

spack env activate nick
Rscript ./scripts/Analyses_Mallard_MultistateModel.R
