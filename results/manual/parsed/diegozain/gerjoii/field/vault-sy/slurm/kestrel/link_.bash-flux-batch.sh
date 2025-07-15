#!/bin/bash
#FLUX: --job-name=bumfuzzled-spoon-8466
#FLUX: -c=10
#FLUX: --exclusive
#FLUX: --urgency=16

ulimit -v unlimited
ulimit -s unlimited
ulimit -u 10000
module load matlab/r2019b
job_path="../../$job_name/scripts/"
cd $job_path
matlab -nodisplay -nodesktop -r "run ./wdc_link_.m ; quit"
