#!/bin/bash
#FLUX: --job-name=pusheena-ricecake-6805
#FLUX: -c=20
#FLUX: --exclusive
#FLUX: --urgency=16

ulimit -v unlimited
ulimit -s unlimited
ulimit -u 10000
module load Apps/Matlab/R2020a
job_path="../../$job_name/scripts/"
cd $job_path
matlab -nodisplay -nodesktop -r "run ./wdc_link_.m ; quit"
