#!/bin/bash
#FLUX: --job-name=outstanding-spoon-7546
#FLUX: -c=28
#FLUX: --exclusive
#FLUX: -t=43140
#FLUX: --urgency=16

ulimit -v unlimited
ulimit -s unlimited
ulimit -u 10000
module load Apps/Matlab/R2020a
job_path="../../$job_name/scripts/"
cd $job_path
matlab -nosplash -nodesktop -r "run ./dc_link_light_.m ;"
