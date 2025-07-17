#!/bin/bash
#FLUX: --job-name=phat-cupcake-4191
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
matlab -nosplash -nodesktop -r "run ./dc_begin_light_.m ;"
