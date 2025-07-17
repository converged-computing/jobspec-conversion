#!/bin/bash
#FLUX: --job-name=test_detection
#FLUX: --queue=work
#FLUX: -t=60000
#FLUX: --urgency=16

module load matlab
matlab -nodisplay -nosplash -nodesktop < MonteCarloRun_33.m
