#!/bin/bash
#FLUX: --job-name=hairy-citrus-1661
#FLUX: --urgency=16

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load gcc/6.2.0 R/3.4.1
srun ~/scripts/R-3.4.1/wfNodeSubset.R 1
