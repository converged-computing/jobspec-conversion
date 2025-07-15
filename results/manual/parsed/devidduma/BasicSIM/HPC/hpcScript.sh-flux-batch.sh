#!/bin/bash
#FLUX: --job-name=salted-sundae-2633
#FLUX: --queue=computeq
#FLUX: -t=300
#FLUX: --priority=16

module purge
module load matlab
logFile=HPCTemplate.log
mFile=HPCTemplate.m
/public/apps/matlab/R2018a/bin/matlab -nodisplay -nosplash -nodesktop -logfile $logFile -r "run $mFile;quit;"
