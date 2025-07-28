#!/bin/bash
#FLUX: --job-name=State_Report_Maps
#FLUX: -t=432000
#FLUX: --urgency=16

​
source ~/.bashrc  # need to set up the normal environment.
echo running on: `hostname` # print some info about where we are running
cd $HOME
cd submission-analysis
conda activate coi-maps
​
python maps_and_lookups.py #$SLURM_ARRAY_TASK_ID # run the python code with the arguments. 
