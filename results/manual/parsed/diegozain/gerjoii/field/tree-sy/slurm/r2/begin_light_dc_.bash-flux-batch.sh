#!/bin/bash
#FLUX: --job-name=quirky-leader-7726
#FLUX: -c=20
#FLUX: --exclusive
#FLUX: --urgency=16

ulimit -v unlimited
ulimit -s unlimited
ulimit -u 10000
module load matlab/r2019a
job_path="../../$job_name/scripts/"
cd $job_path
matlab -nosplash -nodesktop -r "run ./dc_begin_light_.m ;"
