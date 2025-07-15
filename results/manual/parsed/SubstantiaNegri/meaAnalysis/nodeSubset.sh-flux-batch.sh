#!/bin/bash
#FLUX: --job-name=rainbow-lizard-9561
#FLUX: --priority=16

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load gcc/6.2.0 R/3.4.1
srun ~/scripts/R-3.4.1/wfNodeSubset.R 1
