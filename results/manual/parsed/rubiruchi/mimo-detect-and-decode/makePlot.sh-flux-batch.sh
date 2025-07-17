#!/bin/bash
#FLUX: --job-name=PlotBERBaseline
#FLUX: --queue=normal
#FLUX: -t=18000
#FLUX: --urgency=16

echo "Start test"
module load matlab 
matlab -nodesktop -r "run('PlotPerfectBaseline.m'); run('PlotEstimateBaseline.m'); exit(0);"
echo "End test"
