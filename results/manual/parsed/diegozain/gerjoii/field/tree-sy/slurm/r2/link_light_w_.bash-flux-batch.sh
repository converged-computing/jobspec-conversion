#!/bin/bash
#FLUX: --job-name=expensive-animal-9201
#FLUX: -c=28
#FLUX: --exclusive
#FLUX: -t=43140
#FLUX: --urgency=16

ulimit -v unlimited
ulimit -s unlimited
ulimit -u 10000
module load matlab/r2019a
job_path="../../$job_name/scripts/"
cd $job_path
matlab -nosplash -nodesktop -r "run ./w_link_light_.m ;"
