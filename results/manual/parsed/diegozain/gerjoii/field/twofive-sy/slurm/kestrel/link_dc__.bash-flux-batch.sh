#!/bin/bash
#FLUX: --job-name=confused-parsnip-2588
#FLUX: -c=10
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --urgency=16

ulimit -v unlimited
ulimit -s unlimited
ulimit -u 10000
module load matlab/R2018a
job_path="../../$job_name/scripts/"
cd $job_path
matlab -nodisplay -nodesktop -r "run ./dc_link__.m ; quit"
