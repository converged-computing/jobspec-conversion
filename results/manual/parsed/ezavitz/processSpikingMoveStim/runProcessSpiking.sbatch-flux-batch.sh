#!/bin/bash
#FLUX: --job-name=procSpike
#FLUX: -n=6
#FLUX: -t=3600
#FLUX: --urgency=16

module load matlab
matlab -nodisplay -nojvm -nosplash < /home/earsenau/code/processSpikingMoveStim/RUNAnalysis_brain.m
