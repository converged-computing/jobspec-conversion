#!/bin/bash
#FLUX: --job-name=astute-spoon-6204
#FLUX: --urgency=16

module load gcc/12.2
module load R/4.2.2
Rscript ../NWSimulation.R
