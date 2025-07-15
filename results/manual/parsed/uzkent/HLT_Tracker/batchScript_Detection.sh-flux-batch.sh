#!/bin/bash
#FLUX: --job-name=stinky-platanos-3642
#FLUX: --priority=16

module load matlab
matlab -nodisplay -nosplash -nodesktop < MonteCarloRun_33.m
