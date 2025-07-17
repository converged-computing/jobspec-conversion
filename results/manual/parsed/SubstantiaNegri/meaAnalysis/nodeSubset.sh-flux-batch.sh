#!/bin/bash
#FLUX: --job-name=conspicuous-mango-3684
#FLUX: --queue=priority
#FLUX: -t=900
#FLUX: --urgency=16

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load gcc/6.2.0 R/3.4.1
srun ~/scripts/R-3.4.1/wfNodeSubset.R 1
