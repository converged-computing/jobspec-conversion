#!/bin/bash
#FLUX: --job-name=salted-latke-8570
#FLUX: -c=8
#FLUX: -t=710
#FLUX: --urgency=16

module load matlab
cd /home/shaws5/projects/def-beckers/shaws5/Research_code/EEGnet/Main
matlab -nodesktop -nosplash -nodisplay -r "run('processLOO_AmyTasks.m'); exit"
