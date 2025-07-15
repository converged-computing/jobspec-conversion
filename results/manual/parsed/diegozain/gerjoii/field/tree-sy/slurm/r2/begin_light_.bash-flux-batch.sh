#!/bin/bash
#FLUX: --job-name=confused-animal-3166
#FLUX: -c=20
#FLUX: --exclusive
#FLUX: --urgency=16

ulimit -v unlimited
ulimit -s unlimited
ulimit -u 10000
module load matlab/r2019a
job_path="../../$job_name/scripts/"
cd $job_path
matlab -nosplash -nodesktop -r "run ./wdc_begin_light_.m ;"
