#!/bin/bash
#FLUX: --job-name=nerdy-plant-8248
#FLUX: --priority=16

module load gcc/12.2
module load R/4.2.2
Rscript ../NWSimulation.R
