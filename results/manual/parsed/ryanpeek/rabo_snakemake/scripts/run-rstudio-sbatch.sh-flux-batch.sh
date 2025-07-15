#!/bin/bash
#FLUX: --job-name=crusty-cinnamonbun-2053
#FLUX: --urgency=16

module load spack/R/4.1.1
module load rstudio-server/2022.07.1
rserver-farm
