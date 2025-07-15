#!/bin/bash
#FLUX: --job-name=tmle3mediate-simulation
#FLUX: --queue=savio2
#FLUX: -t=86400
#FLUX: --urgency=16

module load r/3.6.3
module load r-packages
R CMD BATCH --no-save 03_run_simulation.R
