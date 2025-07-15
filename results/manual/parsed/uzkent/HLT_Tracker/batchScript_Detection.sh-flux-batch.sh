#!/bin/bash
#FLUX: --job-name=pusheena-cherry-7272
#FLUX: --urgency=16

module load matlab
matlab -nodisplay -nosplash -nodesktop < MonteCarloRun_33.m
