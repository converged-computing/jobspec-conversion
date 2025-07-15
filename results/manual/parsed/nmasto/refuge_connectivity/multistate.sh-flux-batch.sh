#!/bin/bash
#FLUX: --job-name=lovable-ricecake-4600
#FLUX: -c=10
#FLUX: -t=172800
#FLUX: --priority=16

spack env activate nick
Rscript ./scripts/Analyses_Mallard_MultistateModel.R
