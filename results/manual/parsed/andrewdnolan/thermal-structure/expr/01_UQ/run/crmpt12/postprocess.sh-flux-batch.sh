#!/bin/bash
#FLUX: --job-name=dask_gridding
#FLUX: -c=16
#FLUX: -t=7200
#FLUX: --priority=16

export NUM_WORKERS='16'
export THREADS_PER_WORKER='1'

export NUM_WORKERS=16
export THREADS_PER_WORKER=1
source ../../config/modulefile.cc.cedar
source ./sensitivity.sh
KEY='crmpt12'
dx=50
NT=30000
dt=0.1
mkdir "${SLURM_TMPDIR}/thinned"
if [ ! -d "result/${KEY}/thinned/" ]; then
  mkdir  "result/${KEY}/thinned/"
fi
create_dask_cluster
for file in $(find ./result/crmpt12/nc/ -name "*.nc" -ctime -5); do 
    # get the base filename ,with no path info 
    fn="${file##*/}"
    # strip the file extension, to get the runname 
    run_name="${fn%%.nc}"
    # run the post processing commands
    post_proccess
done 
