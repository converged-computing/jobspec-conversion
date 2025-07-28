#!/bin/bash
#FLUX: --job-name=procSpike
#FLUX: -n=6
#FLUX: -t=900
#FLUX: --urgency=16

module load matlab/r2021a
matlab -nodisplay -nojvm -nosplash < /home/earsenau/code/processSpikingMoveStim/RUNAnalysis_mdbExtract.m
