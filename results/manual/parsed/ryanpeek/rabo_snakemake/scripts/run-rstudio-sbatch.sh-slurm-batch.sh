#!/bin/bash
#FLUX: --job-name=rstudio-server
#FLUX: --queue=high
#FLUX: -t=10800
#FLUX: --urgency=16

module load spack/R/4.1.1
module load rstudio-server/2022.07.1
rserver-farm
