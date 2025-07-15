#!/bin/bash
#FLUX: --job-name=blue-buttface-4554
#FLUX: -c=10
#FLUX: --exclusive
#FLUX: --urgency=16

ulimit -v unlimited
ulimit -s unlimited
ulimit -u 10000
module load matlab/r2019b
job_path="../../$job_name/scripts/"
cd $job_path
matlab -nodisplay -nodesktop -r "run ./dc_begin_.m ; quit"
