#!/bin/bash
#FLUX: --job-name=eccentric-itch-3726
#FLUX: --queue=computeq
#FLUX: -t=300
#FLUX: --urgency=16

module purge
module load matlab
logFile=HPCTemplate.log
mFile=HPCTemplate.m
/public/apps/matlab/R2018a/bin/matlab -nodisplay -nosplash -nodesktop -logfile $logFile -r "run $mFile;quit;"
