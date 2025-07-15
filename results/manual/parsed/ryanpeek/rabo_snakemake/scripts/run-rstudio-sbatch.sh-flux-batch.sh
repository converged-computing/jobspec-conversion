#!/bin/bash
#FLUX: --job-name=fuzzy-kitty-2430
#FLUX: --priority=16

module load spack/R/4.1.1
module load rstudio-server/2022.07.1
rserver-farm
