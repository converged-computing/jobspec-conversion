#!/bin/bash
#FLUX: --job-name=PlotBERBaseline
#FLUX: --priority=16

echo "Start test"
module load matlab 
matlab -nodesktop -r "run('PlotPerfectBaseline.m'); run('PlotEstimateBaseline.m'); exit(0);"
echo "End test"
