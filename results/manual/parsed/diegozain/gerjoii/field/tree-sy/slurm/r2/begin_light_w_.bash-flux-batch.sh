#!/bin/bash
#FLUX: --job-name=blue-soup-1906
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
matlab -nosplash -nodesktop -r "run ./w_begin_light_.m ;"
