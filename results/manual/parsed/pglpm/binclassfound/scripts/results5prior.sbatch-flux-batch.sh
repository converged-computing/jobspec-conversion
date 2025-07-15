#!/bin/bash
#FLUX: --job-name=RES5p
#FLUX: -c=17
#FLUX: --queue=normal
#FLUX: -t=600
#FLUX: --priority=16

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors
module --quiet purge
module load R/4.1.2-foss-2021b
cd ~/binclassfound
Rscript mcmc_5prior.R ${1} > mcmc_5prior_${1}.Rout 2>&1
